import { Resolver, Float, FieldResolver, Root, Query, Arg, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { MonitoringRecordResource } from "../types";
import { GetGoalResources, GetGoalResourcesResponse } from "../types/monitoringRecordResource";
import type { Context } from "../types/common";
import axios from "axios";
import { MonitoringResourceType } from "../gen/schema";
import _ from "lodash";
import prisma from "../../lib/prisma";
import { round2dp } from "../../client/utils/formatUtils";
import { getRestApiUrlOrRaise } from "../../lib/utils";

type GetGoalResourcesResponseType = {
  NIT_COMPANIA: string;
  PROYECTO: number;
  CODIGO_ACT: number;
  TIPO_COMPPTAL: string;
} & Record<string, number>;

type GetGoalResourcesResponseCamelType = {
  nitCompania: string;
  proyecto: number;
  codigoAct: number;
  tipoCompptal: string;
} & Record<string, number>;

type GetResourcesForTypeInput = {
  id: number;
  period: number;
  cutoffDate: string;
  resourceType: MonitoringResourceType;
  ctx: Context;
};

@Resolver(() => MonitoringRecordResource)
export class MonitoringRecordResourceResolver extends SPDResolver {
  @FieldResolver(() => Float)
  resourcesTotal(@Root() monitoringRecordResource: MonitoringRecordResource): number {
    return (
      (monitoringRecordResource.cd ?? 0) +
      (monitoringRecordResource.cn ?? 0) +
      (monitoringRecordResource.capital ?? 0) +
      (monitoringRecordResource.credit ?? 0) +
      (monitoringRecordResource.de ?? 0) +
      (monitoringRecordResource.management ?? 0) +
      (monitoringRecordResource.monopoly ?? 0) +
      (monitoringRecordResource.operation ?? 0) +
      (monitoringRecordResource.others ?? 0) +
      (monitoringRecordResource.rp ?? 0) +
      (monitoringRecordResource.sgp ?? 0) +
      (monitoringRecordResource.sgr ?? 0)
    );
  }

  getResourcesForType = async (
    data: GetResourcesForTypeInput,
  ): Promise<GetGoalResourcesResponse | null> => {
    type RESOURCES_KEY_MAP_TYPE = {
      capital: string;
      cd: string;
      cn: string;
      credito: string;
      otros: string;
      rp: string;
      sgp: string;
      sgpAguaPotable: string;
      sgpAliEscolar: string;
      sgpCultura: string;
      sgpDeporte: string;
      sgpEducacion: string;
      sgpLibInversion: string;
      sgpLibDestinacion: string;
      sgpPrimeraInfancia: string;
      sgpSalud: string;
      sgr: string;
    };
    const RESOURCES_KEY_MAP: Record<string, keyof GetGoalResourcesResponse> = {
      capital: "capital",
      cd: "cd",
      cn: "cn",
      credito: "credit",
      otros: "others",
      rp: "rp",
      sgp: "sgp",
      sgpAguaPotable: "sgpWater",
      sgpAliEscolar: "sgpSchoolFeeding",
      sgpCultura: "sgpCulture",
      sgpDeporte: "sgpSport",
      sgpEducacion: "sgpEducation",
      sgpLibInversion: "sgpFreeInvestment",
      sgpLibDestinacion: "sgpFreeDestination",
      sgpPrimeraInfancia: "sgpEarlyChildhood",
      sgpSalud: "sgpHealt",
      sgr: "sgr",
    };
    const RESOURCE_TYPE_MAP: Partial<Record<Partial<MonitoringResourceType>, string>> = {
      [MonitoringResourceType.Definitive]: "APROPIADO_DEF",
      [MonitoringResourceType.Commitment]: "COMPROMISO",
      [MonitoringResourceType.Obligation]: "OBLIGACION",
    };
    if (!process.env.APP_URL) throw new Error("Variable de entorno APP_URL no se ha definido");
    const API_URL = getRestApiUrlOrRaise(this.getContextTenantKey(data.ctx));

    const result: any = {
      capital: 0.0,
      cd: 0.0,
      cn: 0.0,
      credito: 0.0,
      otros: 0.0,
      rp: 0.0,
      sgp: 0.0,
      sgpAguaPotable: 0.0,
      sgpAliEscolar: 0.0,
      sgpCultura: 0.0,
      sgpDeporte: 0.0,
      sgpEducacion: 0.0,
      sgpLibInversion: 0.0,
      sgpLibDestinacion: 0.0,
      sgpPrimeraInfancia: 0.0,
      sgpSalud: 0.0,
      sgr: 0.0,
    };
    // 1. Linked Goal - SiifActividad
    const linkedActividadMetas = await prisma.siifActividadMeta.findMany({
      where: {
        goalId: data.id,
      },
    });
    // console.log(JSON.stringify(linkedActividadMetas, null, 2));

    // 2. Generate array of siifProyecto
    const projects = Array.from(new Set(linkedActividadMetas?.map((record) => record.proyecto)));
    // console.log(JSON.stringify(projects, null, 2));

    const headers = {
      Origin: process.env.APP_URL,
      nit_compania: this.getContextTenantKey(data.ctx),
      proyecto: JSON.stringify(projects),
      periodo: data.period,
      fecha_corte: data.cutoffDate,
      tipo_comprobante: RESOURCE_TYPE_MAP[data.resourceType],
    };

    console.log(`Request headers: ${JSON.stringify(headers)}`);
    try {
      // 3. Ask SIIF API for the data
      const apiResult = await axios.get(`${API_URL}/siifweb/api/ppto/getPptoActAgrupadoPD`, {
        headers,
      });
      if (apiResult?.data?.data) {
        // 4. Generate result response
        result.resourceType = data.resourceType;
        const apiRecords: Array<any> = apiResult?.data?.data?.map(
          (resultRow: GetGoalResourcesResponseType) => {
            return _.mapKeys(resultRow, (value, key) => {
              return _.camelCase(key);
            });
            // console.log(resultRowCamel);
            // const { nitCompania, proyecto, codigoAct, tipoCompptal, ...resourceData } = resultRowCamel;
          },
        );
        console.log("apiRecords");
        console.log(apiRecords);
        linkedActividadMetas?.forEach((actividadMeta) => {
          const apiRecord: {
            nitCompania: string;
            proyecto: string;
            codigoAct: string;
            tipoCompptal: string;
          } & Record<keyof RESOURCES_KEY_MAP_TYPE, number> = apiRecords.find(
            (apiRecord) =>
              apiRecord.proyecto == actividadMeta.proyecto &&
              apiRecord.codigoAct == actividadMeta.codigoAct,
          );
          console.log("apiRecord");
          console.log(apiRecord);
          if (apiRecord) {
            // eslint-disable-next-line @typescript-eslint/no-unused-vars
            const { nitCompania, proyecto, codigoAct, tipoCompptal, ...resourceData } = apiRecord;
            Object.entries(resourceData).map(([k, v]) => {
              result[RESOURCES_KEY_MAP[k]] = round2dp(
                (result[RESOURCES_KEY_MAP[k]] ?? 0) + (v * actividadMeta.weighting) / 100,
              );
            });
          }
        });
        console.log("Result");
        console.log(result);
        return result as GetGoalResourcesResponse;
      } else {
        console.log(`No data returned from ${API_URL}/siifweb/api/ppto/getPptoActAgrupadoPD`);
      }
    } catch (e) {
      console.log(
        `Exception getting data from ${API_URL}/siifweb/api/ppto/getPptoActAgrupadoPD`,
        e,
      );
      throw new Error(`${e}`);
    }
    return null;
  };

  @Query(() => [GetGoalResourcesResponse], { nullable: true })
  async GetGoalResources(
    @Arg("data") data: GetGoalResources,
    @Ctx() ctx: Context,
  ): Promise<Array<GetGoalResourcesResponse>> {
    const { resourceTypes, ...dataArgs } = data;
    const response = await Promise.all(
      resourceTypes.map(async (resourceType) => {
        const resourcesData = await this.getResourcesForType({
          ...dataArgs,
          resourceType: resourceType as MonitoringResourceType,
          ctx,
        });
        return { ...resourcesData, resourceType } as GetGoalResourcesResponse;
      }),
    );
    return response;
  }
}
