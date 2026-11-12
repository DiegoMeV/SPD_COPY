import axios from "axios";

export interface GetLoginTokenResponse {
  accessToken: string;
  refreshToken: string;
}

export class Superset {
  private static _instance: Superset | undefined;
  private tokenCache: GetLoginTokenResponse | undefined;
  private guestTokenCache: string | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getLoginToken(): Promise<GetLoginTokenResponse | undefined> {
    console.log("[getLoginToken] this.tokenCache", JSON.stringify(this.tokenCache, null, 2));
    if (this.tokenCache) return this.tokenCache;
    if (!process.env.SUPERSET_HOST)
      throw new Error("Variable de entorno SUPERSET_HOST no se ha definido");
    const SUPERSET_URL = `${process.env.SUPERSET_HOST}/api/v1/security/login`;

    console.log("[getLoginToken] SUPERSET_URL", SUPERSET_URL);

    if (!process.env.SUPERSET_USERNAME)
      throw new Error("Variable de entorno SUPERSET_USERNAME no se ha definido");
    if (!process.env.SUPERSET_PASSWORD)
      throw new Error("Variable de entorno SUPERSET_PASSWORD no se ha definido");

    const headers = {
      accept: "application/json",
      "Content-Type": "application/json",
    };
    const data = {
      password: process.env.SUPERSET_USERNAME,
      provider: "db",
      refresh: "true",
      username: process.env.SUPERSET_PASSWORD,
    };
    console.log("[getLoginToken] data", JSON.stringify(data, null, 2));

    try {
      const apiResult = await axios.post(SUPERSET_URL, data, {
        headers,
      });
      console.log("[getLoginToken] apiResult?.data", JSON.stringify(apiResult?.data, null, 2));

      if (apiResult?.data) {
        this.tokenCache = apiResult?.data
          ? {
              accessToken: apiResult?.data?.access_token,
              refreshToken: apiResult?.data?.refresh_token,
            }
          : undefined;
        return this.tokenCache;
      }
    } catch (e) {
      console.log(`[getLoginToken] error: ${e}`);
    }

    return undefined;
  }

  async getGuestToken({ dashboardId }: { dashboardId: string }): Promise<string | undefined> {
    console.log("[getGuestToken] this.guestTokenCache", this.guestTokenCache);
    if (this.guestTokenCache) return this.guestTokenCache;
    if (!process.env.SUPERSET_HOST)
      throw new Error("Variable de entorno SUPERSET_HOST no se ha definido");
    const SUPERSET_URL = `${process.env.SUPERSET_HOST}/api/v1/security/guest_token`;

    if (!process.env.SUPERSET_GUEST_USERNAME)
      throw new Error("Variable de entorno SUPERSET_GUEST_USERNAME no se ha definido");
    if (!process.env.SUPERSET_GUEST_FIRST_NAME)
      throw new Error("Variable de entorno SUPERSET_GUEST_FIRST_NAME no se ha definido");
    if (!process.env.SUPERSET_GUEST_LAST_NAME)
      throw new Error("Variable de entorno SUPERSET_GUEST_LAST_NAME no se ha definido");

    console.log("[getGuestToken] call this.getLoginToken");
    const token = await this.getLoginToken();
    console.log("[getGuestToken] token", JSON.stringify(token ?? {}, null, 2));

    const headers = {
      //   accept: "application/json",
      Authorization: `Bearer ${token?.accessToken}`,
      "Content-Type": "application/json",
    };
    console.log("[getGuestToken] headers", JSON.stringify(headers, null, 2));
    const data = {
      resources: [{ id: dashboardId, type: "dashboard" }],
      rls: [],
      //   access_token: token?.accessToken,
      user: {
        first_name: process.env.SUPERSET_GUEST_FIRST_NAME,
        last_name: process.env.SUPERSET_GUEST_LAST_NAME,
        username: process.env.SUPERSET_GUEST_USERNAME,
      },
    };
    console.log("[getGuestToken] data", JSON.stringify(data, null, 2));

    try {
      const apiResult = await axios.post(SUPERSET_URL, data, {
        headers,
      });
      console.log("[getGuestToken] apiResult?.data", JSON.stringify(apiResult?.data, null, 2));

      if (apiResult?.data) {
        this.guestTokenCache = apiResult?.data?.token;
        return this.guestTokenCache;
      }
    } catch (e) {
      console.log(`[getGuestToken] error: ${e}`);
    }

    return undefined;
  }
}
