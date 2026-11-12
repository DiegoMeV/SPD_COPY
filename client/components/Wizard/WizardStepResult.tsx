import React from "react";
import { List, Typography } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faCheckCircle,
  faExclamationCircle,
  faTimesCircle,
} from "@fortawesome/free-solid-svg-icons";

const { Text } = Typography;

type Status = "success" | "error" | "warning";

export interface ResultItem {
  title: string;
  description: string | React.ReactNode;
  status: Status;
}

export interface ResultProps {
  results: ResultItem[];
}

const iconStyle = { fontSize: "24px" };

const statusIcon = {
  success: <FontAwesomeIcon icon={faCheckCircle} style={{ ...iconStyle, color: "green" }} />,
  error: <FontAwesomeIcon icon={faTimesCircle} style={{ ...iconStyle, color: "red" }} />,
  warning: <FontAwesomeIcon icon={faExclamationCircle} style={{ ...iconStyle, color: "orange" }} />,
};

const WizardStepResult: React.FC<ResultProps> = ({ results }) => {
  return (
    <List
      itemLayout="horizontal"
      dataSource={results}
      renderItem={(item) => (
        <List.Item>
          <List.Item.Meta
            avatar={statusIcon[item.status]}
            title={<Text>{item.title}</Text>}
            description={item.description}
          />
        </List.Item>
      )}
    />
  );
};

export { WizardStepResult };
