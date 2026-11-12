import React from "react";
import { Button, Tooltip, Modal } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCopy } from "@fortawesome/free-solid-svg-icons";
import { LoadingOutlined } from "@ant-design/icons";
import { SizeType } from "antd/lib/config-provider/SizeContext";

type ButtonCopyProps = {
  title?: string;
  loading?: boolean;
  size?: SizeType;
  onClick: () => void;
};

const { confirm } = Modal;

const ButtonCopy: React.FC<ButtonCopyProps> = ({
  title = "Copiar",
  loading,
  size = "large",
  onClick,
}) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          size={size}
          icon={loading ? <LoadingOutlined /> : <FontAwesomeIcon icon={faCopy} />}
          onClick={onClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonCopy };
