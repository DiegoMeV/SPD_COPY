import React, { CSSProperties } from "react";
import { Button, ButtonProps, Tooltip } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faCircleDollarToSlot as faDollarCircle,
  faRotate,
} from "@fortawesome/free-solid-svg-icons";

type ButtonReloadProps = {
  title?: string;
  size?: ButtonProps["size"];
  link?: string;
  variant?: "default" | "active" | "partial";
  disabled?: boolean;
  onClick?: () => void;
  width?: number | string;
  heigth?: number | string;
  style?: CSSProperties;
};

const ButtonReload: React.FC<ButtonReloadProps> = ({
  title,
  size = "large",
  link,
  width = 32,
  heigth = 32,
  variant = "default",
  disabled = false,
  style,
  onClick,
}) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          disabled={disabled}
          shape="circle"
          size={size}
          {...(variant === "default"
            ? {
                icon: <FontAwesomeIcon icon={faRotate} />,
              }
            : {
                icon: (
                  <FontAwesomeIcon icon={faDollarCircle} style={{ height: heigth, width: width }} />
                ),
                style: {
                  ...style,
                  border: "none",
                  color: variant === "active" ? "green" : "#f99c07",
                },
              })}
          {...(onClick ? { onClick } : {})}
          {...(link
            ? {
                href: link,
                target: "_blank",
              }
            : {})}
        ></Button>
      </Tooltip>
    </>
  );
};
export { ButtonReload };
