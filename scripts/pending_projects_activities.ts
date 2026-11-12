/* eslint-disable @typescript-eslint/no-var-requires */
const data = require("./pending_projects_activities.json");
const axios = require("axios");
const _ = require("lodash") as _.LoDashStatic;

const SIIF_SQS_URL = "https://8ivhsrizi4.execute-api.us-west-1.amazonaws.com/prod/publisher";

function sleep(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

const main = async () => {
  const items = data.items.sort((itemA: any, itemB: any) => itemA.id - itemB.id);
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const payload = _.omit(JSON.parse(item.payload), ["data.formulado_por"]);
    const id = item.id;
    const createdAt = item.created_at;
    console.log("id", id);
    console.log("created_at", createdAt);
    console.log("payload", payload);
    const result = await axios.post(SIIF_SQS_URL, payload);
    console.log("result", result.data);
    await sleep(10000);
  }
};

main();
