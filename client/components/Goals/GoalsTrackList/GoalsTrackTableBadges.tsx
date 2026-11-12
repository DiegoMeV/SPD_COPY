import { Badge, Tooltip } from "antd";
import React from "react";
import { GoalType } from "../../../../graphql/gen/schema";
import { goalTypeMap } from "../../../utils/uiUtils";
import { GoalTypeCountFragment } from "../../../../graphql/gen/ops";

type Props = {
  data: GoalTypeCountFragment[];
};

const GoalsTrackTableBadges: React.FC<Props> = ({ data }) => {
  return (
    <>
      {data.length > 0 ? (
        <>
          <span> [</span>
          {data.map((goalTypeCount) => {
            return (
              <span key={goalTypeCount.goalType} style={{ padding: "0 5px" }}>
                <span>{goalTypeMap[goalTypeCount.goalType]?.tag}</span>
                <Tooltip title={`${goalTypeCount.count} metas`}>
                  <Badge
                    count={goalTypeCount.count ?? 0}
                    size="default"
                    style={{ padding: "0 3px" }}
                    color={goalTypeMap[goalTypeCount.goalType]?.color ?? "cyan"}
                    offset={[4, 0]}
                    overflowCount={999}
                  ></Badge>
                </Tooltip>
              </span>
            );
          })}
          <span> ]</span>
        </>
      ) : (
        <Badge
          count={0}
          size="default"
          style={{ padding: "0 3px" }}
          color="hwb(205 6% 9%)"
          offset={[4, 0]}
          showZero
        />
      )}
    </>
  );
};

export { GoalsTrackTableBadges };
