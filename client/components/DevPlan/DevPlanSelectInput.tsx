import React, { useEffect } from "react";
import { useActiveMonitoring } from "../MonitoringConfig/hooks";
import { Form } from "antd";
import { DevPlanSelect } from "./DevPlanSelect";
import { useDevPlan } from "./hooks";
import { DataLoading } from "../Data/DataLoading";

type Props = {
  tooltip?: string;
  firstSelected?: boolean;
};

const DevPlanSelectInput: React.FC<Props> = ({ tooltip, firstSelected = true }) => {
  const form = Form.useFormInstance();
  const {
    data: activeMonitoring,
    loading: loadingActiveMonitoring,
    error: errorActiveMonitoring,
  } = useActiveMonitoring();

  const { setSelectedDevPlanId } = useDevPlan({
    id: activeMonitoring?.devPlanId,
  });

  useEffect(() => {
    if (activeMonitoring) {
      setSelectedDevPlanId(activeMonitoring?.devPlanId);
      form.setFieldValue("devPlanId", activeMonitoring?.devPlanId);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [activeMonitoring]);

  return (
    <DataLoading loading={loadingActiveMonitoring} error={errorActiveMonitoring}>
      <Form.Item name="devPlanId" label="Plan de Desarrollo" tooltip={tooltip}>
        <DevPlanSelect
          firstSelected={firstSelected}
          width={"100%"}
          onChange={setSelectedDevPlanId}
        />
      </Form.Item>
    </DataLoading>
  );
};

export { DevPlanSelectInput };
