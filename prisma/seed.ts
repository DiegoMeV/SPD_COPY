/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable no-console */
import { GeoLocation, GoalType, LocationType, PrismaClient } from "@prisma/client";
import { data } from "./seedData";
import { ProyectoRow } from "./seedData/8914800302/siifProyecto";
import { ActividadRow } from "./seedData/8914800302/siifActividad";
import { MetaRow } from "./seedData/8914800302/siifMeta";
import _ from "lodash";
import { NeighborhoodRow, RuralSettlementRow } from "./seedData/8914800302/geoLocation";
import {
  seedDevPlanLevels,
  seedDevPlans,
  seedEntities,
  seedGoals,
  seedMonitoringRecords,
  seedProductCatalog,
  seedPublicPolitics,
  seedTenants,
  seedUsers,
} from "./seedScripts";
import { seedMonitoringConfigs } from "./seedScripts/monitoringConfigs";

const prisma = new PrismaClient();
type GeoLocationData = Array<Pick<GeoLocation, "code" | "name" | "locationType">>;

async function seedProyectos(tenantKey: string) {
  const proyectos = data[tenantKey].proyectos;

  if (typeof proyectos === "function") {
    const proyectosData: ProyectoRow[] = await proyectos();
    const proyectosDB = await prisma.siifProyecto.findMany({
      where: {
        nitCompania: tenantKey,
        proyecto: { in: proyectosData.map((proyecto: ProyectoRow) => proyecto.proyecto) },
      },
    });
    const existingProyectos = proyectosDB?.map((proyecto) => proyecto.proyecto);
    const newProyectos = proyectosData.filter(
      (proyecto: ProyectoRow) => !existingProyectos.includes(proyecto.proyecto),
    );

    console.log("existingProyectos", existingProyectos?.length);
    console.log("newProyectos", newProyectos?.length);

    // Create non-existing records
    const chunkSize = 100;
    const numChunks = Math.ceil(newProyectos.length / chunkSize);

    for (let i = 0; i < numChunks; i++) {
      const start = i * chunkSize;
      const end = start + chunkSize;
      const chunk = newProyectos.slice(start, end);

      await prisma.siifProyecto.createMany({
        data: chunk,
      });
    }

    // Update existing records
    const existingProyectosForUpdate = proyectosData?.filter(
      (proyectoData: ProyectoRow, index: number) => {
        const proyecto = proyectosDB.find(
          (proyecto) =>
            proyecto.nitCompania === proyectoData.nitCompania &&
            proyecto.proyecto === proyectoData.proyecto,
        );
        if (!proyecto) return false;
        const isMatch = _.isMatch(proyecto, proyectoData);
        return (
          ((proyecto.nitCompania === "8914800302" && proyecto.plan === 5) ||
            proyecto.nitCompania != "8914800302") &&
          !isMatch
        );
      },
    );
    console.log("existingProyectosForUpdate", existingProyectosForUpdate?.length);

    await Promise.all(
      existingProyectosForUpdate.map(async (proyecto: ProyectoRow) => {
        return await prisma.siifProyecto.update({
          where: {
            uqSiifProyecto: {
              nitCompania: proyecto.nitCompania,
              proyecto: proyecto.proyecto,
            },
          },
          data: proyecto,
        });
      }),
    );
  }
}

async function seedActividades(tenantKey: string) {
  const actividades = data[tenantKey].actividades;

  if (typeof actividades === "function") {
    const actividadesData: ActividadRow[] = await actividades();
    const existingActividades = await prisma.siifActividad.findMany({
      where: {
        nitCompania: tenantKey,
      },
      include: {
        siifProyecto: true,
      },
    });
    const existingActividadesMap: Record<string, Record<string, number>> = {};
    existingActividades.forEach((actividad) => {
      if (!existingActividadesMap[actividad.proyecto])
        existingActividadesMap[actividad.proyecto] = {};
      existingActividadesMap[actividad.proyecto][actividad.codigoAct] = actividad.codigoAct;
    });

    const newActividades = actividadesData.filter(
      (actividad: ActividadRow) =>
        !existingActividadesMap?.[actividad.proyecto]?.[actividad.codigoAct],
    );
    console.log("actividadesData", actividadesData?.length);
    console.log("existingActividades", existingActividades?.length);
    console.log("newActividades: ", newActividades?.length);

    const chunkSize = 100;
    const numChunks = Math.ceil(newActividades.length / chunkSize);

    for (let i = 0; i < numChunks; i++) {
      const start = i * chunkSize;
      const end = start + chunkSize;
      const chunk = newActividades.slice(start, end);

      await prisma.siifActividad.createMany({
        data: chunk,
      });
    }

    // Update existing records
    // let isLogged = false;
    const existingActividadesForUpdate = actividadesData?.filter(
      (actividadData: ActividadRow, index: number) => {
        const actividad = existingActividades.find(
          (actividad) =>
            actividad.nitCompania === actividadData.nitCompania &&
            actividad.proyecto === actividadData.proyecto &&
            actividad.codigoAct === actividadData.codigoAct,
        );
        if (!actividad) return false;
        const isMatch = _.isMatch(actividad, _.omit(actividadData, ["idMeta", "idProducto"]));

        return (
          ((actividad.nitCompania === "8914800302" && actividad.siifProyecto.plan === 5) ||
            actividad.nitCompania != "8914800302") &&
          !isMatch
        );
      },
    );
    console.log("existingActividadesForUpdate", existingActividadesForUpdate?.length);

    await Promise.all(
      existingActividadesForUpdate.map(async (actividad: ActividadRow) => {
        return await prisma.siifActividad.update({
          where: {
            uqSiifActividad: {
              nitCompania: actividad.nitCompania,
              proyecto: actividad.proyecto,
              codigoAct: actividad.codigoAct,
            },
          },
          data: actividad,
        });
      }),
    );
  }
}

async function seedActividadMeta(tenantKey: string) {
  const metas = data[tenantKey].metas;

  if (typeof metas === "function") {
    const metasData = await metas();
    const goals = await prisma.goal.findMany({
      where: {
        devPlanLevel: {
          devPlan: {
            tenant: {
              key: tenantKey,
            },
          },
        },
        goalType: GoalType.PRODUCT,
      },
    });

    const findGoalId = (id: number | null): number | undefined => {
      const siifMeta: MetaRow | undefined = metasData.find((meta: MetaRow) => meta.id === id);
      if (siifMeta) {
        const goal = goals.find((goal) => goal.code === siifMeta.codigo);
        return goal?.id;
      }
      return undefined;
    };

    const actividades = await prisma.siifActividad.findMany({
      where: {
        nitCompania: tenantKey,
        idMeta: { not: null },
        siifActividadMetas: { none: {} },
      },
    });

    const data: Array<any> = [];
    actividades.forEach((actividad) => {
      const record = {
        nitCompania: actividad.nitCompania,
        proyecto: actividad.proyecto,
        codigoAct: actividad.codigoAct,
        goalId: findGoalId(actividad.idMeta),
        weighting: 100.0,
      };
      data.push(record);
    });

    const validData = data.filter((record) => record.goalId);
    const invalidaData = data.filter((record) => !record.goalId);
    console.log("Actividades-Meta OK: ", validData?.length);
    console.log("Actividades-Meta Error: ", invalidaData?.length);
    if (invalidaData?.length) {
      console.log("Invalid records (first 10): ", invalidaData.slice(0, 10));
    } else {
      // const chunkSize = 100;
      // const numChunks = Math.ceil(validData.length / chunkSize);
      // for (let i = 0; i < numChunks; i++) {
      //   const start = i * chunkSize;
      //   const end = start + chunkSize;
      //   const chunk = validData.slice(start, end);
      //   await prisma.siifActividadMeta.createMany({
      //     data: chunk,
      //   });
      // }
    }
  }
}

async function seedInitialLocations(tenantKey: string) {
  const initialLocations: GeoLocationData = data[tenantKey].initialLocations as GeoLocationData;

  const dbTenant = await prisma.tenant.findFirst({
    where: {
      key: tenantKey,
    },
  });
  if (!dbTenant) return;

  await Promise.all(
    initialLocations.map(async (location: Pick<GeoLocation, "code" | "name" | "locationType">) => {
      const existingLocation = await prisma.geoLocation.findFirst({
        where: {
          tenantId: dbTenant.id,
          code: location.code,
          name: location.name,
          locationType: location.locationType,
        },
      });
      if (!existingLocation) {
        await prisma.geoLocation.create({
          data: {
            ...location,
            tenantId: dbTenant.id,
          },
        });
      }
    }),
  );
}

async function seedNeighborhoods(tenantKey: string) {
  const neighborhoods = data[tenantKey].neighborhoods;
  const initialLocations: GeoLocationData = data[tenantKey].initialLocations as GeoLocationData;

  const dbTenant = await prisma.tenant.findFirst({
    where: {
      key: tenantKey,
    },
  });
  if (!dbTenant) return;

  if (typeof neighborhoods === "function") {
    const neighborhoodsData = await neighborhoods();
    const location = initialLocations?.[0];
    const municipality = await prisma.geoLocation.findFirst({
      where: {
        tenantId: dbTenant.id,
        code: location.code,
        name: location.name,
        locationType: location.locationType,
      },
    });
    if (!municipality) return;

    // Create districts
    const districtNames = Array.from(
      new Set<string>(
        neighborhoodsData.map((neighborhood: NeighborhoodRow) => neighborhood.comuna),
      ),
    ).filter((name) => !!name);
    const districsData: NeighborhoodRow[] = districtNames.map((districtName) =>
      neighborhoodsData.find(
        (neighborhood: NeighborhoodRow) => neighborhood.comuna === districtName,
      ),
    );
    await Promise.all(
      districsData.map(async (district: NeighborhoodRow) => {
        const result = await prisma.geoLocation.findFirst({
          where: {
            tenantId: dbTenant.id,
            code: district.codigoComuna,
            name: district.comuna,
            locationType: LocationType.DISTRICT,
          },
        });
        if (!result) {
          await prisma.geoLocation.create({
            data: {
              tenantId: dbTenant.id,
              code: district.codigoComuna,
              name: district.comuna,
              locationType: LocationType.DISTRICT,
              parentLocationId: municipality.id,
            },
          });
        }
        return;
      }),
    );

    // Create neighborhoods
    const districts = await prisma.geoLocation.findMany({
      where: {
        tenantId: dbTenant.id,
        locationType: LocationType.DISTRICT,
        parentLocationId: municipality.id,
      },
    });
    const existingNeighborhoods = await prisma.geoLocation.findMany({
      where: {
        tenantId: dbTenant.id,
        locationType: LocationType.NEIGHBORHOOD,
      },
    });
    console.log(`# districts: ${districts.length ?? 0}`);
    console.log(`# existing neighborhoods: ${existingNeighborhoods.length ?? 0}`);

    await Promise.all(
      neighborhoodsData.map(async (neighborhood: NeighborhoodRow) => {
        const district = districts.find((district) => district.name === neighborhood.comuna);
        if (!district) return;
        const existingNeighborhood = existingNeighborhoods.find(
          (row) => row.name === neighborhood.barrio && row.parentLocationId === district.id,
        );
        if (!existingNeighborhood) {
          await prisma.geoLocation.create({
            data: {
              code: neighborhood.codigoBarrio,
              name: neighborhood.barrio,
              tenantId: dbTenant.id,
              locationType: LocationType.NEIGHBORHOOD,
              parentLocationId: district.id,
            },
          });
        }
        return;
      }),
    );
  }
}

async function seedRuralSettlements(tenantKey: string) {
  const ruralSettlements = data[tenantKey].ruralSettlements;
  const initialLocations: GeoLocationData = data[tenantKey].initialLocations as GeoLocationData;

  const dbTenant = await prisma.tenant.findFirst({
    where: {
      key: tenantKey,
    },
  });
  if (!dbTenant) return;

  if (typeof ruralSettlements === "function") {
    const ruralSettlementsData = await ruralSettlements();
    const location = initialLocations?.[0];
    const municipality = await prisma.geoLocation.findFirst({
      where: {
        tenantId: dbTenant.id,
        code: location.code,
        name: location.name,
        locationType: location.locationType,
      },
    });
    if (!municipality) return;

    // Create townships
    const townshipNames = Array.from(
      new Set<string>(
        ruralSettlementsData.map(
          (ruralSettlement: RuralSettlementRow) => ruralSettlement.corregimiento,
        ),
      ),
    ).filter((name) => !!name);
    const townshipsData: RuralSettlementRow[] = townshipNames.map((townshipName) =>
      ruralSettlementsData.find(
        (ruralSettlement: RuralSettlementRow) => ruralSettlement.corregimiento === townshipName,
      ),
    );
    await Promise.all(
      townshipsData.map(async (township: RuralSettlementRow) => {
        const result = await prisma.geoLocation.findFirst({
          where: {
            tenantId: dbTenant.id,
            code: township.codigoCorregimiento,
            name: township.corregimiento,
            locationType: LocationType.TOWNSHIP,
          },
        });
        if (!result) {
          await prisma.geoLocation.create({
            data: {
              tenantId: dbTenant.id,
              code: township.codigoCorregimiento,
              name: township.corregimiento,
              locationType: LocationType.TOWNSHIP,
              parentLocationId: municipality.id,
            },
          });
        }
        return;
      }),
    );

    // Create ruralSettlements
    const townships = await prisma.geoLocation.findMany({
      where: {
        tenantId: dbTenant.id,
        locationType: LocationType.TOWNSHIP,
        parentLocationId: municipality.id,
      },
    });
    const existingRuralSettlements = await prisma.geoLocation.findMany({
      where: {
        tenantId: dbTenant.id,
        locationType: LocationType.RURAL_SETTLEMENT,
      },
    });
    console.log(`# townships: ${townships.length ?? 0}`);
    console.log(`# existing ruralSettlements: ${existingRuralSettlements.length ?? 0}`);

    await Promise.all(
      ruralSettlementsData.map(async (ruralSettlement: RuralSettlementRow) => {
        const township = townships.find(
          (township) => township.name === ruralSettlement.corregimiento,
        );
        if (!township) return;
        const existingRuralSettlement = existingRuralSettlements.find(
          (row) => row.name === ruralSettlement.vereda && row.parentLocationId === township.id,
        );
        if (!existingRuralSettlement) {
          await prisma.geoLocation.create({
            data: {
              code: ruralSettlement.codigoVereda,
              name: ruralSettlement.vereda,
              tenantId: dbTenant.id,
              locationType: LocationType.RURAL_SETTLEMENT,
              parentLocationId: township.id,
            },
          });
        }
        return;
      }),
    );
  }
}

async function main() {
  const tenantKey = process.argv?.[2];
  console.log(`Seeding database for tenant: ${tenantKey}`);
  await seedTenants();
  await seedUsers();
  await seedProductCatalog();
  if (tenantKey) {
    await seedDevPlans(tenantKey);
    await seedDevPlanLevels(tenantKey);
    await seedEntities(tenantKey);
    await seedPublicPolitics(tenantKey);
    await seedGoals(tenantKey);
    await seedMonitoringConfigs(tenantKey);
    // await seedMonitoringRecords(tenantKey);
    // await seedProyectos(tenantKey);
    // await seedActividades(tenantKey);
    // await seedActividadMeta(tenantKey);
    // await seedInitialLocations(tenantKey);
    // await seedNeighborhoods(tenantKey);
    // await seedRuralSettlements(tenantKey);
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
