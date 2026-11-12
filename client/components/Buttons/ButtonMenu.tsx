import React from "react";
import { Button, Tooltip } from "antd";
import type { SizeType } from "antd/lib/config-provider/SizeContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBars } from "@fortawesome/free-solid-svg-icons";

type ButtonMenuProps = {
  onClick: () => void;
  title?: string;
  size?: SizeType;
};

const ButtonMenu: React.FC<ButtonMenuProps> = ({ onClick, title, size = "large" }) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="circle"
          icon={<FontAwesomeIcon icon={faBars} />}
          size={size}
          onClick={onClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonMenu };
