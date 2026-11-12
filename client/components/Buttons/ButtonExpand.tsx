import React from "react";
import { Button, Tooltip } from "antd";
import type { SizeType } from "antd/lib/config-provider/SizeContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCaretDown, faCaretUp } from "@fortawesome/free-solid-svg-icons";

type ButtonExpandProps = {
  onClick: () => void;
  title?: string;
  size?: SizeType;
  icon?: "expand" | "shrink";
};

const ButtonExpand: React.FC<ButtonExpandProps> = ({
  onClick,
  title,
  size = "large",
  icon = "expand",
}) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          shape="default"
          icon={<FontAwesomeIcon icon={icon === "expand" ? faCaretDown : faCaretUp} />}
          size={size}
          onClick={onClick}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonExpand };
