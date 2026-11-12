import jwt from "jsonwebtoken";
import { UserAccount } from "../graphql/types";

/*
 * Function to create a signed JSON Web Token for the User provided as arg.
 */
export const createJWT = (
  user: UserAccount,
  { expiration = process.env.TOKEN_EXPIRATION ?? "8h" } = {},
): string => {
  return jwt.sign(user, process.env.TOKEN_SECRET ?? "", {
    expiresIn: expiration,
  });
};

/*
 * Function that verifies and decodes a JWT by checking its signature.
 */
export const verifyJWT = (token: string): any => {
  let resp;
  if (token.length > 0) {
    try {
      // Removes the Bearer Token word from the *token* parameter
      token = token.replace(/Bearer /gi, "");
      const payload = jwt.verify(token, process.env.TOKEN_SECRET ?? "");
      resp = { success: true, payload };
    } catch (error) {
      resp = { success: false, error };
    }
  }
  return resp;
};

/*
 * Function that decodes a JWT .
 */
export const decodeJWT = (token: string): any => {
  let resp;
  if (token.length > 0) {
    try {
      // Removes the Bearer Token word from the *token* parameter
      token = token.replace(/Bearer /gi, "");
      const payload = jwt.decode(token, { complete: false });
      resp = { success: true, payload };
    } catch (error) {
      resp = { success: false, error };
    }
  }
  return resp;
};
