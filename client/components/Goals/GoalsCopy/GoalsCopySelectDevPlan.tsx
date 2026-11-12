import React, { useEffect } from "react";
import { Form, Col, Row } from "antd";
import { WizardStepResult, ResultItem } from "../../Wizard/WizardStepResult";
import { useWizardStep } from "../../../hooks/useWizard";
import { useCopyGoals } from "./hooks";
import { DevPlanSelect } from "../../DevPlan";

type Props = {
  id: string;
};

const GoalsCopySelectDevPlan: React.FC<Props> = ({ id }) => {
  const { setCompleted } = useWizardStep({ id });
  const [stepResults, setStepResults] = React.useState<ResultItem[]>();

  const { selectedDevPlan, setSelectedDevPlanId, selectedDevPlanId } = useCopyGoals();

  useEffect(() => {
    const results: ResultItem[] = [];
    if (selectedDevPlanId) {
      if (selectedDevPlan?.config?.levels?.some((level: any) => level.goalType)) {
        results.push({
          status: "success",
          title: "Plan configurado",
          description:
            "El plan de desarrollo seleccionado tiene asociados los niveles con tipos de meta.",
        });
      } else {
        results.push({
          status: "error",
          title: "Plan sin niveles",
          description: `Debe definir cuáles niveles del plan de desarrollo están asociados a tipos de meta.`,
        });
      }
    } else {
      results.push({
        status: "error",
        title: "Plan no seleccionado",
        description: "Debe seleccionar un plan de desarrollo para continuar.",
      });
    }
    setStepResults(results);
  }, [selectedDevPlan, selectedDevPlanId]);

  useEffect(() => {
    const successResults = stepResults?.filter((result) => result.status === "success");
    setCompleted(Boolean(stepResults?.length && successResults?.length === stepResults?.length));
  }, [stepResults]);

  return (
    <Row gutter={16}>
      <Col span={12}>
        <Form.Item
          name="devPlanId"
          label="Plan de Desarrollo"
          tooltip="Seleccione el plan de desarrollo para el cual desea copiar las metas."
        >
          <DevPlanSelect firstSelected={false} onChange={setSelectedDevPlanId} />
        </Form.Item>
      </Col>
      {stepResults?.length && (
        <Col span={12}>
          <WizardStepResult results={stepResults} />
        </Col>
      )}
    </Row>
  );
};

export { GoalsCopySelectDevPlan };
