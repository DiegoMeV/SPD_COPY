import { List, Avatar, Tooltip } from "antd";
import React from "react";
import { useGoal } from "../../Goals/hooks";
import { Goal } from "../../../types/goal";
import { goalHistoryEventLocale } from "../../../utils/uiUtils";
import { date2FormattedStr } from "../../../utils/formatUtils";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";

const GoalHistory: React.FC = () => {
  const { currentGoal } = useGoal();
  const { currentMonitoring } = useMonitoringConfig();
  const history = currentGoal?.history?.filter(
    (entry) =>
      !entry.monitoringRecord?.monitoringConfigId ||
      entry.monitoringRecord?.monitoringConfigId === currentMonitoring?.id,
  );

  return (
    <List
      itemLayout="horizontal"
      dataSource={history ?? []}
      renderItem={(entry: NonNullable<Goal["history"]>[number]) => {
        const user = entry.createdByAccount ?? { firstName: "SPD", lastName: "" };
        return (
          <List.Item>
            <List.Item.Meta
              avatar={
                <Avatar style={{ backgroundColor: "#87d068" }}>
                  <Tooltip title={`${user?.firstName} ${user?.lastName}`}>
                    {user?.firstName?.[0]}
                    {user?.lastName?.[0]}
                  </Tooltip>
                </Avatar>
              }
              title={`${goalHistoryEventLocale[entry.event]} - ${date2FormattedStr(
                entry.createdAt,
              )}`}
              description={entry.description}
            />
          </List.Item>
        );
      }}
    />
  );
};

export { GoalHistory };
