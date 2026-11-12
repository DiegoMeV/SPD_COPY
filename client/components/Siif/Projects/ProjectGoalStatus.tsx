import { Tooltip } from "antd";
import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { goalCurrentStatusMap } from "../../../utils/uiUtils";
import { MonitoringConfig } from "../../../types/monitoringConfig";
import { ProyectoForScheduleRecord } from "./hooks";
import {
  GoalMonitoringRecordStatus,
  MonitoringRecordStatus,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";

const iconOuterStyle = {
  width: "32px",
  height: "32px",
  paddingInlineStart: 0,
  paddingInlineEnd: 0,
  borderRadius: "50%",
};

type Props = {
  project: ProyectoForScheduleRecord;
  monitoringConfig?: MonitoringConfig;
  stage: MonitoringStatus;
};

const ProjectGoalStatus: React.FC<Props> = ({
  project,
  monitoringConfig,
  stage = MonitoringStatus.Scheduling,
}) => {
  const goalStatus = project.totalResources
    ? GoalMonitoringRecordStatus.Scheduled
    : GoalMonitoringRecordStatus.New;
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
        width={32}
        height={32}
      />
    </Tooltip>
  );
};

export { ProjectGoalStatus };
