import React, { useEffect } from "react";
import { Button, message, Steps, Form, Card, Flex } from "antd";
import { DevPlanCopySelectDevPlan } from "./DevPlanCopySelectDevPlan";
import { DevPlanCopySelectPlanDesarrollo } from "./DevPlanCopySelectPlanDesarrollo";
import { DevPlanCopyPreview } from "./DevPlanCopyPreview";
import { DevPlanCopyResult } from "./DevPlanCopyResult";
import { useWizard } from "../../../hooks/useWizard";
import { useCopyDevPlan } from "./hooks";

const WIZARD_ID = "dev-plan-copy";

const steps = [
  {
    title: "Seleccione Plan Destino",
    content: <DevPlanCopySelectDevPlan id={WIZARD_ID} />,
  },
  {
    title: "Seleccione Plan Origen",
    content: <DevPlanCopySelectPlanDesarrollo id={WIZARD_ID} />,
  },
  {
    title: "Vista Previa",
    content: <DevPlanCopyPreview id={WIZARD_ID} />,
  },
  {
    title: "Resultado Final",
    content: <DevPlanCopyResult id={WIZARD_ID} />,
  },
];

type Props = {
  devPlanId?: number;
};

const DevPlanCopyWizard: React.FC<Props> = ({ devPlanId }) => {
  const [form] = Form.useForm();
  const { current, isCompleted, prevStep, nextStep } = useWizard({
    id: WIZARD_ID,
    steps: steps.map((step) => ({ title: step.title, completed: false })),
  });
  const { setSelectedDevPlanId, setSelectedPlanDesarrolloCode } = useCopyDevPlan();

  useEffect(() => {
    setSelectedDevPlanId(undefined);
    setSelectedPlanDesarrolloCode(undefined);
  }, []);

  useEffect(() => {
    if (devPlanId) {
      form.setFieldValue("devPlanId", devPlanId);
      setSelectedDevPlanId(devPlanId);
    }
  }, [devPlanId]);

  const items = steps.map((item) => ({ key: item.title, title: item.title }));

  const contentStyle: React.CSSProperties = {
    marginTop: 16,
    padding: 8,
  };

  return (
    <Card title="Copiar Plan de Desarrollo">
      <Form form={form} layout="vertical">
        <Steps current={current} items={items} />
        <Card style={contentStyle}>{steps[current]?.content}</Card>
        <Flex justify="center" style={{ marginTop: 24 }}>
          {current > 0 && (
            <Button style={{ margin: "0 8px" }} onClick={() => prevStep()}>
              Anterior
            </Button>
          )}
          {current === steps.length - 2 && isCompleted && (
            <Button type="primary" onClick={() => nextStep()}>
              Importar
            </Button>
          )}
          {current < steps.length - 2 && isCompleted && (
            <Button type="primary" onClick={() => nextStep()}>
              Siguiente
            </Button>
          )}
        </Flex>
      </Form>
    </Card>
  );
};

export { DevPlanCopyWizard };
