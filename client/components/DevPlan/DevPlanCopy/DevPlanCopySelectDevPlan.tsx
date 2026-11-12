import React, { useEffect } from "react";
import { Form, Col, Row } from "antd";
import { useCopyDevPlan } from "./hooks";
import { DevPlanCopyWizardStepResult } from "./DevPlanCopyWizardStepResult";
import { useWizardStep } from "../../../hooks/useWizard";
import { DevPlanSelect } from "../DevPlanSelect";
import { ResultItem } from "../../Wizard/WizardStepResult";

type Props = {
  id: string;
};

const DevPlanCopySelectDevPlan: React.FC<Props> = ({ id }) => {
  const { setCompleted } = useWizardStep({ id });
  const [stepResults, setStepResults] = React.useState<ResultItem[]>();

  const { selectedDevPlan, setSelectedDevPlanId, selectedDevPlanId } = useCopyDevPlan();

  useEffect(() => {
    const results: ResultItem[] = [];
    if (selectedDevPlanId) {
      if (selectedDevPlan?.config?.levels?.length) {
        results.push({
          status: "success",
          title: "Plan configurado",
          description:
            "El plan de desarrollo seleccionado cuenta con al menos un nivel configurado.",
        });
      } else {
        results.push({
          status: "error",
          title: "Plan sin niveles",
          description: `Debe definir cuáles son los niveles del plan de desarrollo, p.e., "Eje", "Componente", "Programa", etc.`,
        });
      }
      if (selectedDevPlan?.levels?.length) {
        results.push({
          status: "warning",
          title: "Plan contiene datos",
          description:
            "El plan de desarrollo seleccionado debe estar vacío para proceder con la copia desde SIIF.",
        });
      } else {
        results.push({
          status: "success",
          title: "Plan vacío",
          description: "El plan de desarrollo seleccionado no contiene datos.",
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
          tooltip="Seleccione el plan de desarrollo al que desea copiar los niveles"
        >
          <DevPlanSelect firstSelected={false} onChange={setSelectedDevPlanId} />
        </Form.Item>
      </Col>
      {stepResults?.length && (
        <Col span={12}>
          <DevPlanCopyWizardStepResult results={stepResults} />
        </Col>
      )}
    </Row>
  );
};

export { DevPlanCopySelectDevPlan };
