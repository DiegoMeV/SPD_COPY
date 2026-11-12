import React from "react";
import { Form, Typography } from "antd";
import { MoneyInput } from "../../Inputs";
import { MonitoringResourcesOrigin } from "../../../../graphql/gen/schema";
import { monitoringResourcesOriginMap } from "../../../utils/uiUtils";
import { RESOURCES_FIELDS, SGP_RESOURCES_FIELDS } from "../../../../shared/const";
import { useStoreState } from "../../../store";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";

type Props = {
  origin: MonitoringResourcesOrigin;
  disabled?: boolean;
  isTracking?: boolean;
  onUpdateFinancialResources?: () => void;
};

const { Title } = Typography;

const GoalScheduleResourcesCol: React.FC<Props> = ({
  origin,
  disabled = false,
  isTracking = false,
  onUpdateFinancialResources,
}) => {
  const { currentMonitoring } = useMonitoringConfig();
  const isSgpDiscriminatedExpanded = useStoreState(
    (state) => state.monitoringConfig.sgpDiscriminatedExpanded,
  );
  const sgpIndex = RESOURCES_FIELDS.findIndex((resource) => resource === "sgp");
  const resourcesFields = [
    ...RESOURCES_FIELDS.slice(0, sgpIndex + 1),
    ...SGP_RESOURCES_FIELDS,
    ...RESOURCES_FIELDS.slice(sgpIndex + 1),
  ];

  return (
    <>
      <Form.Item hidden name={["monitoringResources", origin, "id"]}></Form.Item>
      <Form.Item style={{ textAlign: "center", height: "1.7rem" }}>
        <Title level={5}>{monitoringResourcesOriginMap[origin]?.shortTag} </Title>
      </Form.Item>
      {resourcesFields.map((field) => (
        <Form.Item
          name={["monitoringResources", origin, field]}
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
        name={["monitoringResources", origin, "resourcesTotal"]}
        key={`formItem${"resourcesTotal"}`}
      >
        <MoneyInput disabled />
      </Form.Item>
    </>
  );
};

export { GoalScheduleResourcesCol };
