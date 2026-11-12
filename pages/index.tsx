import React from "react";
import LoginPage from "./login";
import { useStoreState } from "../client/store";
import WizardPage from "./wizard";

const IndexPage: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  if (!user) return <LoginPage />;
  return <WizardPage />;
};

export default IndexPage;
