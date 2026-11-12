import { Arg, Query, Resolver, Mutation } from "type-graphql";
import {
  GetGoalTypeStats,
  GetGoalTypeStatsResponse,
  GetSupersetGuestTokenParams,
} from "../types/dashboard";
import prisma from "../../lib/prisma";
import { GoalType, Prisma } from "@prisma/client";
import { Superset } from "../../lib/superset";

@Resolver()
export class DashboardResolver {
  @Query(() => [GetGoalTypeStatsResponse], { nullable: true })
  async getGoalTypeStats(
    @Arg("data") data: GetGoalTypeStats,
  ): Promise<GetGoalTypeStatsResponse[] | null> {
    const { monitoringConfigId, entityId } = data;
    const itemMap: Record<string, string> = {
      TOTAL: "total",
      SCHEDULED: "scheduled",
      REPORTED: "reported",
    };

    const stats: Array<{ goal_type: string; stat_item: string; total: number }> =
      await prisma.$queryRaw(
        Prisma.sql`
            SELECT g.goal_type , 'TOTAL' stat_item, COUNT(1)::INTEGER total
            FROM   monitoring_config mc
            JOIN   dev_plan_level dpl ON dpl.dev_plan_id = mc.dev_plan_id
            JOIN   goal g ON g.dev_plan_level_id = dpl.id
            WHERE  mc.id = ${monitoringConfigId}
            AND    g.entity_id = ${entityId}
            GROUP BY g.goal_type
            UNION
            SELECT gs.goal_type, 'SCHEDULED' stat_item, COUNT(1)::INTEGER scheduled
            FROM (
                SELECT DISTINCT g.goal_type, mr.monitoring_config_id, mr.goal_id
                FROM    monitoring_record_resource mrr
                JOIN    monitoring_record mr ON mr.id = mrr.monitoring_record_id
                JOIN    monitoring_config mc ON mc.id = mr.monitoring_config_id
                JOIN    goal g ON g.id = mr.goal_id
                WHERE   mrr.resource_type IN ('MANUAL', 'DEFINITIVE')
                AND     mc.id = ${monitoringConfigId}
                AND     g.entity_id = ${entityId}
            ) gs
            GROUP BY gs.goal_type
            UNION
            SELECT gs.goal_type, 'REPORTED' stat_item, COUNT(1)::INTEGER scheduled
            FROM (
                SELECT DISTINCT g.goal_type, mr.monitoring_config_id, mr.goal_id
                FROM    monitoring_record_resource mrr
                JOIN    monitoring_record mr ON mr.id = mrr.monitoring_record_id
                JOIN    monitoring_config mc ON mc.id = mr.monitoring_config_id
                JOIN    goal g ON g.id = mr.goal_id
                WHERE   mrr.resource_type IN ('COMMITMENT', 'OBLIGATION', 'PAYMENT')
                AND     mc.id = ${monitoringConfigId}
                AND     g.entity_id = ${entityId}
            ) gs
            GROUP BY gs.goal_type
    `,
      );
    const resultMap: Record<Partial<string>, Record<string, number>> = {};
    stats?.map((statRecord) => {
      if (!resultMap[statRecord.goal_type])
        resultMap[statRecord.goal_type] = { total: 0, scheduled: 0, reported: 0, noReported: 0 };
      resultMap[statRecord.goal_type][itemMap[statRecord.stat_item]] = statRecord.total;
    });

    const result = Object.keys(resultMap)?.map((k) => {
      return {
        goalType: k as GoalType,
        total: resultMap[k].total,
        scheduled: resultMap[k].scheduled,
        noScheduled: resultMap[k].total - resultMap[k].scheduled,
        reported: resultMap[k].reported,
        noReported: resultMap[k].total - resultMap[k].reported,
      };
    });

    return result;
  }

  @Mutation(() => String, { nullable: true })
  async getSupersetGuestToken(
    @Arg("data") data: GetSupersetGuestTokenParams,
  ): Promise<string | undefined | null> {
    const token = await Superset.instance.getGuestToken(data);
    return token;
  }
}
