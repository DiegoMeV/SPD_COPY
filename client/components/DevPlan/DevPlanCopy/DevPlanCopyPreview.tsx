import React, { useEffect } from "react";
import { Col, Row, Form, Alert } from "antd";
import { useWizardStep } from "../../../hooks/useWizard";
import { usePreviewPlanDesarrollo } from "./hooks";
import { DevPlanTree } from "../../DevPlanTree";
import { GoalType } from "../../../../graphql/gen/schema";

type Props = {
  id: string;
};

const DevPlanCopyPreview: React.FC<Props> = ({ id }) => {
  const form = Form.useFormInstance();
  const { setCompleted } = useWizardStep({ id });

  const { data, loading, error } = usePreviewPlanDesarrollo({
    code: `${form.getFieldValue("devPlanCodeSIIF")}`,
  });

  useEffect(() => {
    if (!loading && !error) {
      setCompleted(true);
    }
  }, [loading, error]);

  return (
    <Row gutter={[16, 8]}>
      <Col span={12}>
        <Alert
          message="A continuación puede ver una vista previa de los diferentes niveles del plan de desarrollo que serán creados. Dé clic en el botón Importar para crear estos niveles."
          type="info"
          showIcon
        />
      </Col>
      <Col span={12} />
      <Col span={12}>
        <DevPlanTree
          data={data}
          loading={loading}
          error={error}
          goalTypes={[GoalType.Result, GoalType.Product, GoalType.Project, GoalType.ActionPlan]}
        />
      </Col>
    </Row>
  );
};

export { DevPlanCopyPreview };
