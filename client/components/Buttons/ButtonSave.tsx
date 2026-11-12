import React from "react";
import { Button, Tooltip } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faFloppyDisk } from "@fortawesome/free-solid-svg-icons";
import { LoadingOutlined } from "@ant-design/icons";

type ButtonSaveProps = {
  loading?: boolean;
  onClick: () => void;
  title?: string;
};

const ButtonSave: React.FC<ButtonSaveProps> = ({ onClick, loading = false, title }) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          size="large"
          htmlType="submit"
          icon={loading ? <LoadingOutlined /> : <FontAwesomeIcon icon={faFloppyDisk} />}
          onClick={onClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonSave };
