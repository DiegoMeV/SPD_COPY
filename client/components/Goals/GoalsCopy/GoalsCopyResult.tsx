import React, { useEffect } from "react";
import { useWizardStep } from "../../../hooks/useWizard";
import { Button, Form, Result } from "antd";
import { DataLoading } from "../../Data/DataLoading";
import { useRouter } from "next/router";
import { useCopyGoals } from "./hooks";
import { useCopyGoalsFromSiifMutation } from "../../../../graphql/gen/hooks";

type Props = {
  id: string;
};

const GoalsCopyResult: React.FC<Props> = ({ id }) => {
  const form = Form.useFormInstance();
  const router = useRouter();
  const { setCompleted, isCompleted } = useWizardStep({ id });
  const { selectedDevPlanId } = useCopyGoals();

  const [copyGoalsFromSIIF, { data, loading, error }] = useCopyGoalsFromSiifMutation();

  useEffect(() => {
    if (!isCompleted && selectedDevPlanId) {
      copyGoalsFromSIIF({
        variables: {
          devPlanId: selectedDevPlanId,
        },
      });
      setCompleted(true);
    }
  }, [isCompleted]);

  return (
    <DataLoading loading={loading}>
      <Result
        status={error ? "error" : "success"}
        title={
          error
            ? `Error al crear metas del plan de desarrollo`
            : `Metas del Plan de desarrollo creadas correctamente`
        }
        subTitle={error ? error.message : `Se crearon ${data?.copyGoalsFromSIIF?.length} registros`}
        extra={[
          <Button type="primary" key="plan" onClick={() => router.push(`/config/goals`)}>
            Ver Metas
          </Button>,
        ]}
      />
    </DataLoading>
  );
};

export { GoalsCopyResult };
