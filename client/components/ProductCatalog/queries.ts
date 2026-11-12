import { gql } from "@apollo/client";

const GET_PRODUCTS_CATALOG = gql`
  query {
    product_catalog(where: { parent_id: { _is_null: true } }) {
      id
      code
      name
      product_catalogs {
        id
        code
        name
        product_catalogs {
          id
          code
          name
        }
      }
    }
  }
`;

export { GET_PRODUCTS_CATALOG };
