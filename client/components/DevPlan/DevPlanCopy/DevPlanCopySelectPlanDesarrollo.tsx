import React, { useEffect } from "react";
import { Form, Col, Row } from "antd";
import { useCopyDevPlan } from "./hooks";
import { DevPlanCopyWizardStepResult } from "./DevPlanCopyWizardStepResult";
import { useWizardStep } from "../../../hooks/useWizard";
import { PlanDesarrolloSelect } from "../../Siif";
import { ResultItem } from "../../Wizard/WizardStepResult";

type Props = {
  id: string;
};

const DevPlanCopySelectPlanDesarrollo: React.FC<Props> = ({ id }) => {
  const { setCompleted } = useWizardStep({ id });
  const [stepResults, setStepResults] = React.useState<ResultItem[]>();

  const { selectedPlanDesarrollo, setSelectedPlanDesarrolloCode, selectedPlanDesarrolloCode } =
    useCopyDevPlan();

  useEffect(() => {
    const results: ResultItem[] = [];
    if (selectedPlanDesarrolloCode) {
      if (selectedPlanDesarrollo?.ejes?.length) {
        results.push({
          status: "success",
          title: "Plan contiene datos",
          description: "El plan de desarrollo seleccionado contiene datos para copiar.",
        });
      } else {
        results.push({
          status: "warning",
          title: "Plan vacío",
          description: "El plan de desarrollo origen no tiene datos para copiar.",
        });
      }
    } else {
      results.push({
        status: "error",
        title: "Plan origen no seleccionado",
        description: "Debe seleccionar un plan de desarrollo origen para continuar.",
      });
    }
    setStepResults(results);
  }, [selectedPlanDesarrollo, selectedPlanDesarrolloCode]);

  useEffect(() => {
    const successResults = stepResults?.filter((result) => result.status === "success");
    setCompleted(Boolean(stepResults?.length && successResults?.length === stepResults?.length));
  }, [stepResults]);

  return (
    <Row gutter={16}>
      <Col span={12}>
        <Form.Item
          name="devPlanCodeSIIF"
          label="Plan de Desarrollo SIIF"
          tooltip="Seleccione el plan de desarrollo de SIIF desde el cual se copiarán los niveles."
        >
          <PlanDesarrolloSelect firstSelected={false} onChange={setSelectedPlanDesarrolloCode} />
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

export { DevPlanCopySelectPlanDesarrollo };
