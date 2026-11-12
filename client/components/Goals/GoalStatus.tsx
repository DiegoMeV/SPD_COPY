import { Tooltip } from "antd";
import React from "react";
import { Goal } from "../../types/goal";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useGoal } from "./hooks";
import { goalCurrentStatusMap } from "../../utils/uiUtils";
import { MonitoringConfig } from "../../types/monitoringConfig";
import { MonitoringStatus } from "../../../graphql/gen/schema";

const iconOuterStyle = {
  paddingInlineStart: 0,
  paddingInlineEnd: 0,
  borderRadius: "50%",
};

type Props = {
  goal: Goal;
  monitoringConfig?: MonitoringConfig;
  stage: MonitoringStatus;
};

const GoalStatus: React.FC<Props> = ({
  goal,
  monitoringConfig,
  stage = MonitoringStatus.Created,
}) => {
  const { getGoalStatus } = useGoal();
  const goalStatus = getGoalStatus({ goal, monitoringConfig, stage });
  const goalStatusDefinition =
    goalStatus != undefined ? goalCurrentStatusMap[goalStatus] : undefined;

  if (!goalStatusDefinition) return null;

  const { primaryColor, secondaryColor, opacity, border, ...extraStyle } =
    goalStatusDefinition.style ?? {};
  const iconStyle = {
    ...extraStyle,
    ...(border ? { border: `1px solid ${primaryColor}` } : {}),
    "--fa-primary-color": primaryColor,
    "--fa-secondary-color": secondaryColor,
    "--fa-secondary-opacity": opacity,
  };

  return (
    <Tooltip title={goalStatusDefinition.tag}>
      <FontAwesomeIcon
        icon={goalStatusDefinition.icon}
        style={{ ...iconOuterStyle, ...iconStyle }}
        size="2x"
      />
    </Tooltip>
  );
};

export { GoalStatus };
