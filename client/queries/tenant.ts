import { gql } from "@apollo/client";

const GET_TENANTS = gql`
  query getTenants {
    getDevPlans {
      id
      key
      name
      isActive
      createdAt
      updatedAt
    }
  }
`;

const GET_TENANT = gql`
  query getTenant($id: Int!) {
    getTenant(id: $id) {
      id
      key
      name
      isActive
      createdAt
      updatedAt
    }
  }
`;

const GET_TENANT_BY_KEY = gql`
  query getTenantByKey($key: String!) {
    getTenantByKey(key: $key) {
      id
      key
      name
      isActive
      createdAt
      updatedAt
    }
  }
`;

export { GET_TENANTS, GET_TENANT, GET_TENANT_BY_KEY };
