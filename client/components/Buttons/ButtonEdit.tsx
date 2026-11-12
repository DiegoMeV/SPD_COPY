import React from "react";
import { Button, Tooltip } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPenToSquare } from "@fortawesome/free-solid-svg-icons";
import { SizeType } from "antd/lib/config-provider/SizeContext";

type ButtonEditProps = {
  onClick: () => void;
  title?: string;
  loading?: boolean;
  size?: SizeType;
  disabled?: boolean;
};

const ButtonEdit: React.FC<ButtonEditProps> = ({
  onClick,
  title,
  size = "large",
  disabled = false,
}) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          size={size}
          icon={<FontAwesomeIcon icon={faPenToSquare} />}
          onClick={onClick}
          disabled={disabled}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonEdit };
