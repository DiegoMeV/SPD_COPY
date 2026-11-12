import React from "react";
import { List } from "antd";

import { PublicPoliticComponentFragment } from "../../../graphql/gen/ops";

type Props = {
  components?: PublicPoliticComponentFragment[];
};
const PublicComponentsModal: React.FC<Props> = ({ components }) => {
  return (
    <List
      size="small"
      style={{ overflowY: "scroll", maxHeight: "400px" }}
      dataSource={components}
      renderItem={(item) => <List.Item>{item.name}</List.Item>}
    />
  );
};

export { PublicComponentsModal };
