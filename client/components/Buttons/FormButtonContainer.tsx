import React from "react";
import { Space } from "antd";

type Props = {
  children: React.ReactNode;
};

const FormButtonContainer: React.FC<Props> = ({ children }) => {
  return <Space size={"middle"}>{children}</Space>;
};

export { FormButtonContainer };
