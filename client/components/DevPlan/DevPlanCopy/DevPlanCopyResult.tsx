import React, { useEffect } from "react";
import { useWizardStep } from "../../../hooks/useWizard";
import { useCopyDevPlanMutation } from "../../../../graphql/gen/hooks";
import { Button, Form, Result } from "antd";
import { DataLoading } from "../../Data/DataLoading";
import { useRouter } from "next/router";
import { useCopyDevPlan } from "./hooks";

type Props = {
  id: string;
};

const DevPlanCopyResult: React.FC<Props> = ({ id }) => {
  const form = Form.useFormInstance();
  const router = useRouter();
  const { setCompleted, isCompleted } = useWizardStep({ id });
  const { selectedPlanDesarrolloCode, selectedDevPlanId } = useCopyDevPlan();

  const [copyDevPlan, { data, loading, error }] = useCopyDevPlanMutation();

  useEffect(() => {
    if (!isCompleted && selectedPlanDesarrolloCode && selectedDevPlanId) {
      copyDevPlan({
        variables: {
          data: {
            fromCode: selectedPlanDesarrolloCode,
            toId: selectedDevPlanId,
          },
        },
      });
      setCompleted(true);
    }
  }, [isCompleted, selectedPlanDesarrolloCode, selectedDevPlanId]);

  return (
    <DataLoading loading={loading}>
      <Result
        status={error ? "error" : "success"}
        title={
          error
            ? `Error al copiar el plan de desarrollo`
            : `Plan de desarrollo copiado correctamente`
        }
        subTitle={
          error ? error.message : `Se crearon ${data?.copyDevPlan?.levels?.length} registros`
        }
        extra={[
          <Button
            type="primary"
            key="plan"
            onClick={() => router.push(`/config/dev-plans/${selectedDevPlanId}/levels`)}
          >
            Ver Plan de Desarrollo
          </Button>,
        ]}
      />
    </DataLoading>
  );
};

export { DevPlanCopyResult };
