import { devPlans } from "./devPlans";
import { entities } from "./entities";
import { devPlanLevels } from "./devPlanLevels";
import { publicPolitics } from "./publicPolitics";
import { goals } from "./goals";
import { proyectos } from "./siifProyecto";
import { actividades } from "./siifActividad";
import { metas } from "./siifMeta";
import { ruralSettlements, neighborhoods, initialLocations } from "./geoLocation";

// let goalsData: Array<GoalRow> = [];
// async function getGoals() {
//     goalsData = await goals();
// }

export default {
  "8914800302": {
    devPlans,
    devPlanLevels,
    entities,
    publicPolitics,
    goals,
    proyectos,
    actividades,
    metas,
    initialLocations,
    ruralSettlements,
    neighborhoods,
  },
};
