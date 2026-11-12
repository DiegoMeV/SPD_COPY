import React from "react";
import { Button, Tooltip } from "antd";
import type { SizeType } from "antd/lib/config-provider/SizeContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faFileExport } from "@fortawesome/free-solid-svg-icons";

type ButtonAddProps = {
  onClick: () => void;
  loading?: boolean;
  title?: string;
  size?: SizeType;
};

const ButtonDownload: React.FC<ButtonAddProps> = ({
  onClick,
  title,
  size = "large",
  loading = false,
}) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          icon={<FontAwesomeIcon icon={faFileExport} />}
          size={size}
          onClick={onClick}
          loading={loading}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonDownload };
