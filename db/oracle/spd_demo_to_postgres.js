/* =============================================================================
   Copia los datos de demostración de Seguimiento (spd_demo_seguimiento.sql) del Oracle
   local a la base PostgreSQL de la app React, para comparar las dos aplicaciones con
   los mismos datos. Solo local / pruebas.

   Copia las filas SPD_* con CREATED_BY = 999999 (configuraciones, metas, registros,
   recursos, adjuntos e historial). Los IDs nuevos se remapean; las metas, entidades y
   niveles existentes tienen el mismo ID en las dos bases (el seed de Oracle salió de
   PostgreSQL). Se puede re-ejecutar: primero borra en PostgreSQL lo marcado con 999999.

   Uso (desde la raíz del repo, con Node 20):
     node db/oracle/spd_demo_to_postgres.js
   Variables opcionales: DATABASE_URL (por defecto postgres local), ORACLE_USER,
   ORACLE_PASSWORD, ORACLE_CONNECT (por defecto siif/siif@localhost:1521/FREEPDB1).
   ============================================================================= */
process.env.DATABASE_URL =
  process.env.DATABASE_URL || "postgresql://postgres:postgres@localhost:5432/spd?schema=public";

const oracledb = require("oracledb");
const { PrismaClient } = require("@prisma/client");

const DEMO = 999999;
oracledb.fetchAsString = [oracledb.CLOB];
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

const json = (v) => (v == null ? null : JSON.parse(v));
const yes = (v) => v === "S";

async function main() {
  const prisma = new PrismaClient();
  const ora = await oracledb.getConnection({
    user: process.env.ORACLE_USER || "siif",
    password: process.env.ORACLE_PASSWORD || "siif",
    connectString: process.env.ORACLE_CONNECT || "localhost:1521/FREEPDB1",
  });
  const q = async (sql) => (await ora.execute(sql)).rows;

  const configs = await q(`SELECT * FROM SPD_MONITORING_CONFIG WHERE CREATED_BY = ${DEMO} ORDER BY ID`);
  const goals = await q(
    `SELECT * FROM SPD_GOAL WHERE CREATED_BY = ${DEMO} ORDER BY CASE WHEN PARENT_GOAL_ID IS NULL THEN 0 ELSE 1 END, ID`,
  );
  const records = await q(`SELECT * FROM SPD_MONITORING_RECORD WHERE CREATED_BY = ${DEMO} ORDER BY ID`);
  const resources = await q(`SELECT * FROM SPD_MONITORING_RECORD_RESOURCE WHERE CREATED_BY = ${DEMO}`);
  const attachments = await q(`SELECT * FROM SPD_MONITORING_RECORD_ATTACH WHERE CREATED_BY = ${DEMO}`);
  const history = await q(`SELECT * FROM SPD_GOAL_HISTORY WHERE CREATED_BY = ${DEMO}`);
  // ubicaciones demo (para la focalización): se copian con el mismo ID, porque TARGET_MATRIX guarda los ID
  const geos = await q("SELECT * FROM SPD_GEO_LOCATION WHERE CODE LIKE 'DEMO-%' ORDER BY CASE WHEN PARENT_LOCATION_ID IS NULL THEN 0 ELSE 1 END, ID");
  await ora.close();
  if (!configs.length) throw new Error("No hay datos demo en Oracle: ejecute antes spd_demo_seguimiento.sql");

  // Compañía (tenant.key = NIT) y plan (dev_plan.code = PLAN) en PostgreSQL
  const tenants = new Map();
  const plans = new Map();
  const tenantId = async (nit) => {
    if (!tenants.has(nit)) {
      const t = await prisma.tenant.findFirst({ where: { key: nit } });
      if (!t) throw new Error(`No existe tenant con key ${nit}`);
      tenants.set(nit, t.id);
    }
    return tenants.get(nit);
  };
  const devPlanId = async (nit, plan) => {
    if (plan == null) return null;
    const k = `${nit}/${plan}`;
    if (!plans.has(k)) {
      const p = await prisma.devPlan.findFirst({ where: { tenantId: await tenantId(nit), code: `${plan}` } });
      if (!p) throw new Error(`No existe dev_plan ${plan} para ${nit}`);
      plans.set(k, p.id);
    }
    return plans.get(k);
  };

  await prisma.$transaction(
    async (tx) => {
      // ---- limpieza (lo que copió una corrida anterior)
      // incluye lo que se haya guardado desde la app sobre las configuraciones / metas demo
      const oldRec = {
        monitoringRecord: { OR: [{ createdBy: DEMO }, { monitoringConfig: { createdBy: DEMO } }] },
      };
      await tx.goalHistory.deleteMany({
        where: { OR: [{ createdBy: DEMO }, { goal: { createdBy: DEMO } }, oldRec] },
      });
      await tx.monitoringRecordAttachment.deleteMany({ where: oldRec });
      await tx.monitoringRecordResource.deleteMany({ where: oldRec });
      await tx.monitoringRecord.deleteMany({
        where: { OR: [{ createdBy: DEMO }, { monitoringConfig: { createdBy: DEMO } }] },
      });
      await tx.monitoringConfig.deleteMany({ where: { createdBy: DEMO } });
      await tx.goal.deleteMany({ where: { createdBy: DEMO, parentGoalId: { not: null } } });
      await tx.goal.deleteMany({ where: { createdBy: DEMO } });
      await tx.geoLocation.deleteMany({ where: { code: { startsWith: "DEMO-" }, parentLocationId: { not: null } } });
      await tx.geoLocation.deleteMany({ where: { code: { startsWith: "DEMO-" } } });
      for (const g of geos) {
        await tx.geoLocation.create({
          data: { id: g.ID, tenantId: await tenantId(g.NIT_COMPANIA), code: g.CODE, name: g.NAME,
                  locationType: g.LOCATION_TYPE, parentLocationId: g.PARENT_LOCATION_ID },
        });
      }
      if (geos.length) {
        await tx.$executeRawUnsafe("SELECT setval(pg_get_serial_sequence('geo_location', 'id'), (SELECT max(id) FROM geo_location))");
      }

      // ---- configuraciones
      const cfgMap = new Map();
      for (const c of configs) {
        const row = await tx.monitoringConfig.create({
          data: {
            usedFor: c.USED_FOR,
            tenantId: await tenantId(c.NIT_COMPANIA),
            isActive: yes(c.IS_ACTIVE),
            devPlanId: await devPlanId(c.NIT_COMPANIA, c.PLAN),
            period: c.PERIOD,
            subperiod: c.SUBPERIOD,
            periodicity: c.PERIODICITY,
            spentDocs: json(c.SPENT_DOCS) ?? [],
            weightingType: c.WEIGHTING_TYPE,
            datesConfig: json(c.DATES_CONFIG),
            colorsConfig: json(c.COLORS_CONFIG),
            status: c.STATUS,
            monitoringResourcesOrigin: c.MONITORING_RESOURCES_ORIGIN,
            supportProductMonitoring: yes(c.SUPPORT_PRODUCT_MONITORING),
            sgpDiscriminated: yes(c.SGP_DISCRIMINATED),
            goalTypes: json(c.GOAL_TYPES) ?? [],
            createdAt: c.CREATED_AT,
            createdBy: DEMO,
          },
        });
        cfgMap.set(c.ID, row.id);
      }

      // la demo activa queda como única activa de la compañía (igual que en Oracle; la app
      // React toma la primera configuración activa)
      for (const c of configs.filter((x) => yes(x.IS_ACTIVE))) {
        await tx.monitoringConfig.updateMany({
          where: { tenantId: await tenantId(c.NIT_COMPANIA), isActive: true, id: { not: cfgMap.get(c.ID) } },
          data: { isActive: false },
        });
      }

      // ---- metas nuevas (proyectos, actividades, planes de acción); padres primero
      const goalMap = new Map();
      for (const g of goals) {
        const row = await tx.goal.create({
          data: {
            tenantId: await tenantId(g.NIT_COMPANIA),
            parentGoalId: g.PARENT_GOAL_ID == null ? null : goalMap.get(g.PARENT_GOAL_ID),
            isActive: yes(g.IS_ACTIVE),
            devPlanId: await devPlanId(g.NIT_COMPANIA, g.PLAN),
            devPlanLevelId: g.DEV_PLAN_LEVEL_ID,
            entityId: g.ENTITY_ID,
            goalType: g.GOAL_TYPE,
            code: g.CODE,
            name: g.NAME,
            indicator: g.INDICATOR,
            description: g.DESCRIPTION,
            accumulationType: g.ACCUMULATION_TYPE,
            baseValue: g.BASE_VALUE,
            goalValue: g.GOAL_VALUE,
            unitsFactor: g.UNITS_FACTOR,
            unitsName: g.UNITS_NAME,
            isBaseValueNotAvailable: yes(g.IS_BASE_VALUE_NOT_AVAILABLE),
            projectCode: g.PROJECT_CODE,
            startDate: g.START_DATE,
            endDate: g.END_DATE,
            createdAt: g.CREATED_AT,
            createdBy: DEMO,
          },
        });
        goalMap.set(g.ID, row.id);
      }
      const goalId = (id) => goalMap.get(id) ?? id; // las metas existentes conservan el ID

      // ---- registros
      const recMap = new Map();
      for (const r of records) {
        const row = await tx.monitoringRecord.create({
          data: {
            monitoringConfigId: cfgMap.get(r.MONITORING_CONFIG_ID),
            goalId: goalId(r.GOAL_ID),
            period: r.PERIOD,
            goalValue: r.GOAL_VALUE,
            piGoalValue: r.PI_GOAL_VALUE,
            fromMonth: r.FROM_MONTH,
            toMonth: r.TO_MONTH,
            goalAchievedValue: r.GOAL_ACHIEVED_VALUE,
            piGoalAchievedValue: r.PI_GOAL_ACHIEVED_VALUE,
            recordStatus: r.RECORD_STATUS,
            weighting: r.WEIGHTING,
            notes: r.NOTES,
            questionHow: r.QUESTION_HOW,
            questionResult: r.QUESTION_RESULT,
            questionEvidence: r.QUESTION_EVIDENCE,
            questionProblem: r.QUESTION_PROBLEM,
            physicalIndicator: r.PHYSICAL_INDICATOR,
            totalPeople: r.TOTAL_PEOPLE,
            targetMatrix: json(r.TARGET_MATRIX) ?? undefined,
            createdAt: r.CREATED_AT,
            createdBy: DEMO,
            updatedAt: r.UPDATED_AT,
            updatedBy: DEMO,
          },
        });
        recMap.set(r.ID, row.id);
      }

      // ---- recursos, adjuntos e historial
      const n = (v) => (v == null ? 0 : v);
      await tx.monitoringRecordResource.createMany({
        data: resources.map((x) => ({
          monitoringRecordId: recMap.get(x.MONITORING_RECORD_ID),
          resourceType: x.RESOURCE_TYPE,
          capital: n(x.CAPITAL), cd: n(x.CD), cn: n(x.CN), credit: n(x.CREDIT), de: n(x.DE),
          operation: n(x.OPERATION), management: n(x.MANAGEMENT), monopoly: n(x.MONOPOLY),
          others: n(x.OTHERS), rp: n(x.RP), sgp: n(x.SGP), sgr: n(x.SGR),
          sgpEducation: n(x.SGP_EDUCATION), sgpHealt: n(x.SGP_HEALTH), sgpWater: n(x.SGP_WATER),
          sgpCulture: n(x.SGP_CULTURE), sgpSport: n(x.SGP_SPORT), sgpFreeInvestment: n(x.SGP_FREE_INVESTMENT),
          sgpFreeDestination: n(x.SGP_FREE_DESTINATION), sgpSchoolFeeding: n(x.SGP_SCHOOL_FEEDING),
          sgpMagdalenaRiver: n(x.SGP_MAGDALENA_RIVER), sgpEarlyChildhood: n(x.SGP_EARLY_CHILDHOOD),
          financialIndicator: x.FINANCIAL_INDICATOR,
          createdBy: DEMO,
        })),
      });
      await tx.monitoringRecordAttachment.createMany({
        data: attachments.map((x) => ({
          monitoringRecordId: recMap.get(x.MONITORING_RECORD_ID),
          s3Path: x.S3_PATH,
          name: x.NAME,
          description: x.DESCRIPTION,
          createdBy: DEMO,
        })),
      });
      await tx.goalHistory.createMany({
        data: history.map((x) => ({
          goalId: x.GOAL_ID == null ? null : goalId(x.GOAL_ID),
          monitoringRecordId: x.MONITORING_RECORD_ID == null ? null : recMap.get(x.MONITORING_RECORD_ID),
          event: x.EVENT,
          description: x.DESCRIPTION,
          createdAt: x.CREATED_AT,
          createdBy: DEMO,
        })),
      });
    },
    { timeout: 300000 },
  );

  console.log(
    `PostgreSQL: ${configs.length} configuraciones, ${goals.length} metas, ${records.length} registros, ` +
      `${resources.length} recursos, ${attachments.length} adjuntos, ${history.length} eventos de historial, ${geos.length} ubicaciones`,
  );
  await prisma.$disconnect();
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
