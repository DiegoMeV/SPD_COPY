import "reflect-metadata";
import "../styles/globals.css";
import "antd/dist/reset.css";
import "../styles/app.css";
import React, { useEffect } from "react";
import type { AppProps } from "next/app";
import { ApolloProvider } from "@apollo/client";
import { SPDTemplate } from "../client/components/Layout/SPDTemplate";
import { store, useStoreActions, useStoreState } from "../client/store";
import { StoreProvider, useStoreRehydrated } from "easy-peasy";
import { Notifications } from "../client/components/Utils/Notifications";
import { useRouteParam } from "../client/hooks/useParam";
import { Skeleton, Result, ConfigProvider } from "antd";
import esES from "antd/lib/locale/es_ES";
import { Login } from "../client/components/Login";
import { apolloClient } from "../client/lib/apollo";
import theme from "../theme/themeConfig";
import { useApp } from "../client/hooks/useApp";
import { useRouter } from "next/router";
import { convertPathToArray } from "../client/utils/uiUtils";
import { useAppMenu } from "../client/components/AppMenu/hooks";

const App = ({ Component, pageProps }: AppProps) => {
  const key = useRouteParam("key");
  const isRehydrated = useStoreRehydrated();
  const router = useRouter();
  const tenant = useStoreState((state) => state.tenant.data);
  const user = useStoreState((state) => state.user.data);
  const tenantLoading = useStoreState((state) => state.tenant.loading.tenant);
  const { fetchTenant } = useStoreActions((actions) => actions.tenant);
  const { userLogout } = useStoreActions((actions) => actions.user);
  const currentOption = useStoreState((state) => state.app.currentOption);
  const { getAllowedActions, setCurrentPermissions } = useApp();
  const { setCurrentKeyPath } = useAppMenu();

  useEffect(() => {
    if (isRehydrated && key && (!tenant || (tenant && tenant?.key !== key))) {
      fetchTenant(key);
    }
    // Invalidate user session
    if (isRehydrated && key && user?.tenantId !== tenant?.id) {
      userLogout();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isRehydrated, tenant, key, user]);

  useEffect(() => {
    const allowedActions = getAllowedActions();
    setCurrentPermissions(allowedActions);
  }, [currentOption]);

  useEffect(() => {
    if (router.pathname && !currentOption) {
      console.log("App reloaded with pathname", router.pathname);
      const keyPath = convertPathToArray(router.pathname);
      console.log("Key path", keyPath);
      setCurrentKeyPath(keyPath);
      // const option = router.pathname.split("/")[1];
      // setCurrentPermissions([]);
      // setCurrentPermissions(getAllowedActions());
    }
  }, [router.pathname, currentOption]);

  if (!isRehydrated) {
    return <Skeleton active />;
  }

  if (!key) {
    if (!tenant) {
      if (tenantLoading) {
        return <Skeleton active />;
      } else {
        return (
          <SPDTemplate>
            <Result
              status="404"
              title="404"
              subTitle={
                <span>
                  El link al que intenta ingresar no existe. Asegúrese de tener el parámetro{" "}
                  <strong>key</strong> en la URL
                </span>
              }
            />
          </SPDTemplate>
        );
      }
    }
  } else {
    if (!tenant && !tenantLoading) {
      return (
        <SPDTemplate>
          <Result
            status="404"
            title="404"
            subTitle={
              <span>
                No se encontró la entidad con key <strong>{key}</strong>
              </span>
            }
          />
        </SPDTemplate>
      );
    }
  }

  return (
    <SPDTemplate>
      {user && <Component {...pageProps} />}
      {!user && <Login />}
      <Notifications />
    </SPDTemplate>
  );
};

const AppWithStore = (props: AppProps) => {
  return (
    <ApolloProvider client={apolloClient}>
      <StoreProvider store={store}>
        <ConfigProvider locale={esES} theme={theme}>
          <App {...props} />
        </ConfigProvider>
      </StoreProvider>
    </ApolloProvider>
  );
};

export default AppWithStore;
