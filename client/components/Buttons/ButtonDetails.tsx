import React from "react";
import { Button, Tooltip } from "antd";
import type { SizeType } from "antd/lib/config-provider/SizeContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTableList } from "@fortawesome/free-solid-svg-icons";

type ButtonDetailsProps = {
  onClick: () => void;
  title?: string;
  size?: SizeType;
};

const ButtonDetails: React.FC<ButtonDetailsProps> = ({ onClick, title, size = "large" }) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          icon={<FontAwesomeIcon icon={faTableList} />}
          size={size}
          onClick={onClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonDetails };
