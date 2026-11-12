import { gql } from "@apollo/client";

const USER_LOGIN = gql`
  query UserLogin($data: LoginUserAccount!) {
    userLogin(data: $data) {
      id
      createdAt
      tenantId
      email
      docNumber
      firstName
      lastName
      phone
      isActive
    }
  }
`;

export { USER_LOGIN };
