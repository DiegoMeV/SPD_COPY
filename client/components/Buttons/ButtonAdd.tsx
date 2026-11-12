import React from "react";
import { Button, Tooltip } from "antd";
import type { SizeType } from "antd/lib/config-provider/SizeContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPlus } from "@fortawesome/free-solid-svg-icons";

type ButtonAddProps = {
  onClick: () => void;
  title?: string;
  size?: SizeType;
};

const ButtonAdd: React.FC<ButtonAddProps> = ({ onClick, title, size = "large" }) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          icon={<FontAwesomeIcon icon={faPlus} />}
          size={size}
          onClick={onClick}
          color="red"
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonAdd };
