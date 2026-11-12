import { faCheckCircle } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import React from "react";

type Props = {
  active: boolean;
  width?: string | number;
  height?: string | number;
  paddingTop?: string | number;
  activeColor?: string;
  inactiveColor?: string;
};

const ActiveStatus: React.FC<Props> = ({
  active,
  width = "2rem",
  height = "2rem",
  paddingTop,
  activeColor = "green",
  inactiveColor = "gray",
}) => {
  return (
    <FontAwesomeIcon
      icon={faCheckCircle}
      style={{
        color: active ? activeColor : inactiveColor,
        height,
        width,
        paddingTop,
      }}
    />
  );
};

export { ActiveStatus };
