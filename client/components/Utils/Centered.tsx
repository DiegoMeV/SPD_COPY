import React from "react";

interface CenteredProps {
  width?: number | string;
  children?: React.ReactNode | undefined;
}

export const Centered: React.FC<CenteredProps> = ({ width = 1200, children }) => {
  return (
    <div style={{ display: "flex", justifyContent: "center", padding: 4, height: "100%" }}>
      <div style={{ width, height: "100%", marginTop: 4 }}>{children}</div>
    </div>
  );
};
