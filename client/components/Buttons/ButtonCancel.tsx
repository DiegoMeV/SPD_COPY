import React from "react";
import { Button, Tooltip, Modal } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCancel } from "@fortawesome/free-solid-svg-icons";
import { LoadingOutlined } from "@ant-design/icons";
import { SizeType } from "antd/lib/config-provider/SizeContext";

type ButtonCancelProps = {
  title?: string;
  loading?: boolean;
  size?: SizeType;
  onClick: () => void;
};

const { confirm } = Modal;

const ButtonCancel: React.FC<ButtonCancelProps> = ({
  title = "Cancelar",
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
          icon={loading ? <LoadingOutlined /> : <FontAwesomeIcon icon={faCancel} />}
          onClick={onClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonCancel };
