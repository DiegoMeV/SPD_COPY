import React, { useEffect } from "react";
import { TabsProps, Tabs, Tooltip } from "antd";
import { MonitoringTrackQuantitative } from "./MonitoringTrackQuantitative";
import { MonitoringTrackQualitative } from "./MonitoringTrackQualitative";
import { MonitoringTrackNotes } from "./MonitoringTrackNotes";
import { MonitoringTrackIndicators } from "./MonitoringTrackIndicators";
import { MonitoringTrackTargetED } from "./MonitoringTrackTargetED";
import { MonitoringTrackTargetRE } from "./MonitoringTrackTargetRE";
import { MonitoringTrackTargetOrg } from "./MonitoringTrackTargetOrg";
import { MonitoringTrackAttachments } from "./MonitoringTrackAttachments";
import { MonitoringTrackHistory } from "./MonitoringTrackHistory";
import { GoalMonitoringRecordStatus } from "../../../../graphql/gen/schema";
import { useStoreActions } from "../../../store";
import { Goal } from "../../../types/goal";

type Props = {
  onUpdateFinancialResources?: () => void;
  disabled?: boolean;
  goalStatus?: GoalMonitoringRecordStatus;
  goal?: Goal;
};

const MonitoringTrackTabs: React.FC<Props> = ({
  onUpdateFinancialResources,
  disabled,
  goalStatus,
  goal,
}) => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    if (goal) setCurrentGoal(goal);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [goal]);

  const tabs: TabsProps["items"] = [
    {
      key: "quantitative",
      label: "Avance Cuantitativo",
      children: (
        <MonitoringTrackQuantitative
          onUpdateFinancialResources={onUpdateFinancialResources}
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "qualitative",
      label: "Avance Cualitativo",
      children: (
        <MonitoringTrackQualitative
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "qualitativeNotes",
      label: (
        <Tooltip title="Observaciones Generales">
          <span>Obs. Generales</span>
        </Tooltip>
      ),
      children: (
        <MonitoringTrackNotes
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "targetMatrixED",
      label: (
        <Tooltip title="Focalización Enfoque Diferencial">
          <span>Focalización E.D.</span>
        </Tooltip>
      ),
      children: (
        <MonitoringTrackTargetED
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "targetMatrixOrg",
      label: (
        <Tooltip title="Focalización Organizacional">
          <span>Focalización Org.</span>
        </Tooltip>
      ),
      children: (
        <MonitoringTrackTargetOrg
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "targetMatrixRE",
      label: (
        <Tooltip title="Focalización Recurso Ecosistémico">
          <span>Focalización R.E.</span>
        </Tooltip>
      ),
      children: (
        <MonitoringTrackTargetRE
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "evidences",
      label: (
        <Tooltip title="Archivos de soporte">
          <span>Evidencias</span>
        </Tooltip>
      ),
      children: (
        <MonitoringTrackAttachments
          disabled={disabled ?? goalStatus === GoalMonitoringRecordStatus.Reviewed}
        />
      ),
    },
    {
      key: "indicators",
      label: "Indicadores",
      children: <MonitoringTrackIndicators />,
    },
    {
      key: "history",
      label: "Historial",
      children: <MonitoringTrackHistory />,
    },
  ];

  return <Tabs defaultActiveKey="quantitative" items={tabs} />;
};

export { MonitoringTrackTabs };
