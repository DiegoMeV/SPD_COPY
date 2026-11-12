import React from "react";
import { Button, ButtonProps, Tooltip } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEye } from "@fortawesome/free-solid-svg-icons";

type ButtonEyeProps = {
  title?: string;
  size?: ButtonProps["size"];
  link?: string;
  variant?: "default" | "active";
  disabled?: boolean;
  onClick?: () => void;
};

const ButtonEye: React.FC<ButtonEyeProps> = ({
  title,
  size = "large",
  link,
  variant = "default",
  disabled = false,
  onClick,
}) => {
  return (
    <>
      <Tooltip title={title}>
        <Button
          // shape="circle"
          size={size}
          disabled={disabled}
          icon={
            <FontAwesomeIcon
              icon={faEye}
              size="2x"
              style={{
                "--fa-primary-color": "#141414",
                "--fa-secondary-color": "#ce6503",
                "--fa-secondary-opacity": 0.6,
                "--fa-primary-opacity": 0.9,
              }}
            />
          }
          style={{
            border: "none",
            ...(variant === "active" ? { color: "green" } : {}),
            backgroundColor: "transparent",
          }}
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
export { ButtonEye };
