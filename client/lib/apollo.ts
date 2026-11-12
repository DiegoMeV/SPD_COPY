import { from, ApolloClient, InMemoryCache, HttpLink, ApolloLink } from "@apollo/client";
import { setContext } from "@apollo/client/link/context";
import { store } from "../store";
import { GraphQLError } from "graphql";
import { asyncMap } from "@apollo/client/utilities";
import { getTitleForErrorPath } from "./apolloPathMap";

const isTokenExpiredError = (error: GraphQLError) => {
  return error.extensions?.code === "UNAUTHENTICATED" && /expired/gi.test(error.message);
};

const errorLoggingLink = new ApolloLink((operation, forward) => {
  const { sendNotification } = store.getActions().notifications;
  const { refreshToken, userLogout } = store.getActions().user;
  return asyncMap(forward(operation), async (response) => {
    const { errors } = response;
    if (errors) {
      for (const error of errors) {
        if (isTokenExpiredError(error)) {
          await refreshToken();
          userLogout();
        } else {
          sendNotification({
            type: "error",
            duration: 0, // never auto-close
            message: `Error '${getTitleForErrorPath(`${error.path}`)}'`,
            description: error.message,
          });
        }
      }
    }
    return response;
  });
});

const authLink = setContext((_, { headers }) => {
  // get the authentication token from store state
  const token = store.getState().user.data?.token;

  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    },
  };
});

const httpLink = new HttpLink({
  uri: "/api/graphql",
  credentials: "same-origin",
  fetch,
});

export const apolloClient = new ApolloClient({
  cache: new InMemoryCache(),
  link: from([errorLoggingLink, authLink, httpLink]),
});
