import React from "react";
import { Button, Tooltip } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faRotateLeft } from "@fortawesome/free-solid-svg-icons";

type ButtonBackProps = {
  onClick: () => void;
  title?: string;
  disabled?: boolean;
};

const ButtonBack: React.FC<ButtonBackProps> = ({ onClick, title, disabled = false }) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          size="large"
          icon={<FontAwesomeIcon icon={faRotateLeft} />}
          onClick={onClick}
          disabled={disabled}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonBack };
