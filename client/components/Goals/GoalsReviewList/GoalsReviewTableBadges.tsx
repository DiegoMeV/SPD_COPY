import { Badge, Tooltip } from "antd";
import React from "react";
import { GoalType } from "../../../../graphql/gen/schema";
import { Goal } from "../../../types/goal";
import { goalTypeMap } from "../../../utils/uiUtils";

type Props = {
  goals: Goal[];
};

const GoalsReviewTableBadges: React.FC<Props> = ({ goals }) => {
  const goalTypes = Array.from(new Set(goals?.map((goal) => goal.goalType)));
  const totalByType: Partial<Record<GoalType, number>> = {};
  goals?.forEach((goal) => {
    totalByType[goal.goalType] = (totalByType[goal.goalType] ?? 0) + 1;
  });

  return (
    <>
      <span> [</span>
      {goalTypes.map((goalType) => {
        return (
          <span key={goalType} style={{ padding: "0 5px" }}>
            <span>{goalTypeMap[goalType]?.tag}</span>
            <Tooltip title={`${totalByType[goalType]} metas`}>
              <Badge
                count={totalByType[goalType] ?? 0}
                size="default"
                style={{ padding: "0 3px" }}
                color={goalTypeMap[goalType]?.color ?? "cyan"}
                offset={[4, 0]}
              ></Badge>
            </Tooltip>
          </span>
        );
      })}
      <span> ]</span>
    </>
  );
};

export { GoalsReviewTableBadges };
