import React, { useEffect } from "react";
import { Col, Row, Form, Alert, Typography, Badge, Table } from "antd";
import { useWizardStep } from "../../../hooks/useWizard";
import { useCopyGoalsPreview } from "./hooks";
import { ResultItem, WizardStepResult } from "../../Wizard/WizardStepResult";
import { VSpdMetaFragment } from "../../../../graphql/gen/ops";

type Props = {
  id: string;
};

const { Text } = Typography;

const GoalsCopyPreview: React.FC<Props> = ({ id }) => {
  const form = Form.useFormInstance();
  const { setCompleted } = useWizardStep({ id });
  const [stepResults, setStepResults] = React.useState<ResultItem[]>([]);

  const { data, loading, error, columns, handleTableChange, pagination } = useCopyGoalsPreview({
    devPlanId: form.getFieldValue("devPlanId"),
  });

  useEffect(() => {
    const results: ResultItem[] = [];
    if (data?.goalstoCopyFromSIIF) {
      if (data.countGoalsSIIF) {
        results.push({
          status: "success",
          title: "Metas SIIF",
          description: (
            <>
              <Text>{`Se encontraron `}</Text>
              <Badge
                count={data.countGoalsSIIF}
                showZero
                overflowCount={1000}
                style={{ backgroundColor: "#52c41a" }}
              ></Badge>
              <Text>{` metas en el plan de desarrollo de SIIF.`}</Text>
            </>
          ),
        });
      } else {
        results.push({
          status: "error",
          title: "Metas SIIF",
          description: (
            <>
              <Text>{`El plan de desarrollo seleccionado tiene `}</Text>
              <Badge count={0} showZero></Badge>
              <Text>{` metas en SIIF.`}</Text>
            </>
          ),
        });
      }
      if (data.goalstoCopyFromSIIF.length > 0) {
        results.push({
          status: "success",
          title: "Metas a crear",
          description: (
            <>
              <Text>{`Se encontraron `}</Text>
              <Badge
                count={data.goalstoCopyFromSIIF.length}
                showZero
                overflowCount={1000}
                style={{ backgroundColor: "#52c41a" }}
              ></Badge>
              <Text>{` metas de SIIF que pueden ser creadas en SPD.`}</Text>
            </>
          ),
        });
      } else {
        results.push({
          status: "error",
          title: "Metas a crear",
          description: (
            <>
              <Text>{`El plan de desarrollo seleccionado tiene `}</Text>
              <Badge count={0} showZero></Badge>
              <Text>{` metas que aún no han sido creadas en SPD.`}</Text>
            </>
          ),
        });
      }
    } else {
      results.push({
        status: "error",
        title: "Error",
        description: "Ocurrió un error al obtener las metas del plan de desarrollo de SIIF.",
      });
    }
    setStepResults(results);
  }, [data?.goalstoCopyFromSIIF]);

  useEffect(() => {
    const successResults = stepResults?.filter((result) => result.status === "success");
    setCompleted(
      !loading &&
        !error &&
        Boolean(stepResults?.length && successResults?.length === stepResults?.length),
    );
  }, [stepResults, loading, error]);

  return (
    <Row gutter={[16, 8]}>
      <Col span={18}>
        <Alert
          message="A continuación puede ver una vista previa de las metas del plan de desarrollo que se van a importar de SIIF. Dé clic en el botón Importar para crear estas metas."
          type="info"
          showIcon
        />
      </Col>
      <Col span={6} />
      <Col span={18}>
        <Table
          dataSource={data?.goalstoCopyFromSIIF}
          loading={loading}
          columns={columns}
          onChange={handleTableChange}
          rowKey={(record: VSpdMetaFragment) => `${record.id}`}
          pagination={pagination}
          size="small"
        />
      </Col>
      <Col span={6}>
        <WizardStepResult results={stepResults} />
      </Col>
    </Row>
  );
};

export { GoalsCopyPreview };
