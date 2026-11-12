import React from "react";
import { Form, Typography } from "antd";
import { MoneyInput } from "../../Inputs";
import {
  GoalMonitoringRecordStatus,
  MonitoringResourceType,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { monitoringResourceTypeMap } from "../../../utils/uiUtils";
import { RESOURCES_FIELDS, SGP_RESOURCES_FIELDS } from "../../../../shared/const";
import { ButtonReload } from "../../Buttons/ButtonReload";
import { useGoal } from "../../Goals/hooks";
import { useStoreState } from "../../../store";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";

type Props = {
  resourceType: MonitoringResourceType;
  disabled?: boolean;
  isTracking?: boolean;
  onUpdateFinancialResources?: () => void;
};

const { Title } = Typography;

const MonitoringTrackResourcesCol: React.FC<Props> = ({
  resourceType,
  disabled = false,
  isTracking = false,
  onUpdateFinancialResources,
}) => {
  const { currentMonitoring } = useMonitoringConfig();

  const isSgpDiscriminatedExpanded = useStoreState(
    (state) => state.monitoringConfig.sgpDiscriminatedExpanded,
  );
  const { currentGoal, getGoalStatus } = useGoal();
  const sgpIndex = RESOURCES_FIELDS.findIndex((resource) => resource === "sgp");
  const resourcesFields = [
    ...RESOURCES_FIELDS.slice(0, sgpIndex + 1),
    ...SGP_RESOURCES_FIELDS,
    ...RESOURCES_FIELDS.slice(sgpIndex + 1),
  ];
  const goalStatus = getGoalStatus({
    goal: currentGoal,
    monitoringConfig: currentMonitoring,
    stage: MonitoringStatus.Reporting,
  });

  return (
    <>
      <Form.Item hidden name={["monitoringResources", resourceType, "id"]}></Form.Item>
      <Form.Item style={{ textAlign: "center", height: "1.7rem" }}>
        <Title level={5}>{monitoringResourceTypeMap[resourceType]?.tagPlural}</Title>
      </Form.Item>
      {resourcesFields.map((field) => (
        <Form.Item
          name={["monitoringResources", resourceType, field]}
          key={`formItem${field}`}
          hidden={!isSgpDiscriminatedExpanded && SGP_RESOURCES_FIELDS.includes(field)}
        >
          <MoneyInput
            disabled={
              disabled ||
              field === "TOTAL" ||
              (field === "sgp" && !!currentMonitoring?.sgpDiscriminated)
            }
          />
        </Form.Item>
      ))}
      <Form.Item
        name={["monitoringResources", resourceType, "resourcesTotal"]}
        key={`formItem${"resourcesTotal"}`}
      >
        <MoneyInput disabled />
      </Form.Item>
    </>
  );
};

export { MonitoringTrackResourcesCol };
