import { Action, action, Thunk, thunk } from "easy-peasy";
import { apolloClient } from "../../lib/apollo";
import { TenantRecord } from "../../types/tenant";
import { GET_TENANT_BY_KEY } from "../../queries/tenant";

type LoadingMap = {
  tenant: boolean;
};

export type TenantModel = {
  data: TenantRecord | undefined;
  loading: LoadingMap;
  setTenant: Action<TenantModel, TenantRecord>;
  setLoading: Action<TenantModel, Partial<LoadingMap>>;
  fetchTenant: Thunk<TenantModel, string>;
};

export const tenantModel: TenantModel = {
  data: undefined,
  loading: {
    tenant: false,
  },
  setTenant: action((state, tenant) => {
    state.data = tenant;
  }),
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  fetchTenant: thunk(async (actions, key) => {
    actions.setLoading({ tenant: true });
    const query = await apolloClient.query({
      query: GET_TENANT_BY_KEY,
      variables: {
        key,
      },
    });
    actions.setLoading({ tenant: false });
    actions.setTenant(query.data?.getTenantByKey);
    return query.data?.getTenantByKey;
  }),
};
