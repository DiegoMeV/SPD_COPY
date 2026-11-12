import { PrismaClient } from "@prisma/client";
import { data } from "../seedData";
import { GoalRow } from "../seedData/common/types";

const prisma = new PrismaClient();

async function seedGoals(tenantKey: string) {
  const goals = data[tenantKey].goals;

  if (typeof goals === "function") {
    const goalsData = await goals();
    console.log(`[seedGoals] Number of goals to create: ${goalsData.length}`);
    const result = (
      await Promise.all(
        goalsData.map(async (goal: GoalRow) => {
          const existingGoal = await prisma.goal.findFirst({
            where: {
              devPlanId: goal.devPlanId,
              code: goal.code,
            },
          });
          if (!existingGoal) {
            const result = await prisma.goal.create({
              data: goal,
            });
            return result.id;
          }
          return undefined;
        }),
      )
    ).filter((id) => id !== undefined);
    console.log(`[seedGoals] Number of goals created: ${result.length}`);
  }
}

export { seedGoals };
