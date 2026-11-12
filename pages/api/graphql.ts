import "reflect-metadata";
import { ApolloServer } from "@apollo/server";
import { startServerAndCreateNextHandler } from "@as-integrations/next";
import { pick } from "lodash";
import { NextApiHandler, PageConfig } from "next";
import { parseBody } from "next/dist/server/api-utils/node/parse-body";
import { buildSchema } from "type-graphql";
import { resolvers } from "../../graphql/resolvers";
import { decodeJWT, verifyJWT } from "../../util";

const createServerHandler = async () => {
  const schema = await buildSchema({
    resolvers: [...resolvers],
  });

  const server = new ApolloServer({
    schema,
    introspection: true,
    formatError: (error) => {
      return {
        ...pick(error, ["message", "locations", "path", "extensions"]),
      };
    },
  });

  const handler = startServerAndCreateNextHandler(server, {
    context: async (req, res) => {
      // Get the user token from the headers.
      const token = req.headers["authorization"] ?? req.headers["Authorization"];
      if (typeof token !== "string") {
        return {};
      }

      // get the payload object from the JWT
      let jwtPayload = verifyJWT(token);
      if (!jwtPayload?.success) {
        // throws an error for any exception other than *TokenExpiredError*
        if (!jwtPayload?.error?.expiredAt) {
          // On other exceptions, thorws an error
          const error = `[ApolloContext] ${jwtPayload?.error}`;
          console.error(error);
          throw new Error(error);
        }

        // if the Token has expired, gets the payload from the current JWT
        jwtPayload = decodeJWT(token);
        return { user: {}, tokenExpiredData: jwtPayload?.payload };
      }

      // Add the user to the context
      return { user: jwtPayload?.payload };
      // return { req, res };
    },
  });

  return handler;
};

const graphql: NextApiHandler = async (req, res) => {
  res.setHeader("Access-Control-Allow-Credentials", "true");
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

  if (req.method === "OPTIONS") {
    res.status(200).end();
  }

  req.body = await parseBody(req, "10mb");

  try {
    const handler = await createServerHandler();
    return await handler(req, res);
  } catch (e) {
    res.status(500).send(`Error: ${e instanceof Error ? e.message : `${e}`}`);
  }
};

export default graphql;

// // Apollo Server takes care of body parsing
export const config: PageConfig = {
  api: {
    bodyParser: false,
  },
};
