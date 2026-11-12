import React from "react";

interface AlignedProps {
  width?: number | string;
  children?: React.ReactNode | undefined;
  align?: "start" | "end";
}

const Aligned: React.FC<AlignedProps> = ({ width, children, align = "start" }) => {
  return <div style={{ display: "flex", justifyContent: `flex-${align}` }}>{children}</div>;
};

export { Aligned };
