import React from "react";
import { Button, Tooltip, Modal } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTrashCan } from "@fortawesome/free-solid-svg-icons";
import { ExclamationCircleOutlined, LoadingOutlined } from "@ant-design/icons";
import { SizeType } from "antd/lib/config-provider/SizeContext";

type ButtonDeleteProps = {
  title?: string;
  loading?: boolean;
  size?: SizeType;
  message?: string;
  description?: string | React.ReactNode;
  disabled?: boolean;
  onClick?: () => void;
  onDelete?: () => void;
};

const { confirm } = Modal;

const ButtonDelete: React.FC<ButtonDeleteProps> = ({
  title = "Eliminar",
  message,
  description,
  loading,
  size = "large",
  disabled = false,
  onClick,
  onDelete,
}) => {
  const handleOnClick = () => {
    confirm({
      title: message ?? "",
      ...(description ? { content: description } : {}),
      icon: <ExclamationCircleOutlined />,
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk: onDelete,
    });
  };

  return (
    <>
      <Tooltip title={title}>
        <Button
          className="btn-delete"
          shape="circle"
          size={size}
          icon={loading ? <LoadingOutlined /> : <FontAwesomeIcon icon={faTrashCan} />}
          onClick={onClick ?? handleOnClick}
          disabled={disabled}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonDelete };
