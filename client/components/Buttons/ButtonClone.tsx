import React from "react";
import { Button, Tooltip, Modal } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faClone } from "@fortawesome/free-solid-svg-icons";
import { ExclamationCircleOutlined, LoadingOutlined } from "@ant-design/icons";
import { SizeType } from "antd/lib/config-provider/SizeContext";

type ButtonCloneProps = {
  title?: string;
  loading?: boolean;
  size?: SizeType;
  message?: string;
  description?: string | React.ReactNode;
  onClick?: () => void;
  onOk?: () => void;
};

const { confirm } = Modal;

const ButtonClone: React.FC<ButtonCloneProps> = ({
  title = "Eliminar",
  message,
  description,
  loading,
  size = "large",
  onClick,
  onOk,
}) => {
  const handleOnClick = () => {
    confirm({
      title: message ?? "",
      ...(description ? { content: description } : {}),
      icon: <ExclamationCircleOutlined />,
      okText: "Confirmar",
      okType: "primary",
      cancelText: "Cancelar",
      onOk: onOk,
    });
  };

  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          size={size}
          icon={loading ? <LoadingOutlined /> : <FontAwesomeIcon icon={faClone} />}
          onClick={onClick ?? handleOnClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonClone };
