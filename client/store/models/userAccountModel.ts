import { Action, action, Thunk, thunk } from "easy-peasy";
import { apolloClient } from "../../lib/apollo";
import {
  UserLoggedInFragment,
  UserLoginQuery,
  UserLoginQueryVariables,
  RefreshTokenQuery,
} from "../../../graphql/gen/ops";
import { UserLoginDocument, RefreshTokenDocument } from "../../../graphql/gen/hooks";
import { SearchUserAccount } from "../../../graphql/gen/schema";

type LoadingMap = {
  user: boolean;
};

type UserLoginType = {
  tenantId: number;
  email: string;
  password: string;
};

export type UserAccountModel = {
  data: UserLoggedInFragment | undefined;
  searchUserAccountVariables: SearchUserAccount;
  loading: LoadingMap;
  setUser: Action<UserAccountModel, UserLoggedInFragment | undefined>;
  setLoading: Action<UserAccountModel, Partial<LoadingMap>>;
  userLogin: Thunk<UserAccountModel, UserLoginType>;
  userLogout: Thunk<UserAccountModel>;
  refreshToken: Thunk<UserAccountModel>;
  setSearchUserAccountVariables: Action<UserAccountModel, SearchUserAccount>;
};

export const userAccountModel: UserAccountModel = {
  data: undefined,
  searchUserAccountVariables: {},
  loading: {
    user: false,
  },
  setUser: action((state, user) => {
    state.data = user;
  }),
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  userLogin: thunk(async (actions, loginData) => {
    actions.setLoading({ user: true });
    try {
      const query = await apolloClient.query<UserLoginQuery, UserLoginQueryVariables>({
        query: UserLoginDocument,
        variables: {
          data: loginData,
        },
        fetchPolicy: "network-only",
      });
      actions.setUser(query.data?.userLogin ?? undefined);
      return query.data?.userLogin;
    } finally {
      actions.setLoading({ user: false });
    }
  }),
  userLogout: thunk((actions) => {
    actions.setUser(undefined);
  }),
  refreshToken: thunk(async (actions) => {
    actions.setLoading({ user: true });
    try {
      const query = await apolloClient.query<RefreshTokenQuery>({
        query: RefreshTokenDocument,
        fetchPolicy: "network-only",
      });
      actions.setUser(query.data?.refreshToken ?? undefined);
      return query.data?.refreshToken;
    } finally {
      actions.setLoading({ user: false });
    }
  }),
  setSearchUserAccountVariables: action((state, queryVariables) => {
    state.searchUserAccountVariables = queryVariables;
  }),
};
