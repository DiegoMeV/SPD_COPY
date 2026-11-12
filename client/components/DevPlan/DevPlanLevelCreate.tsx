import React from "react";
import { Card, Space, Form, Input, InputNumber } from "antd";
import { ButtonSave } from "../Buttons";
import { useStoreActions } from "../../store";
import { DevPlanFragment } from "../../../graphql/gen/ops";
import {
  GetDevPlanLevelsTreeDocument,
  useCreateDevPlanLevelMutation,
} from "../../../graphql/gen/hooks";
import { DataNode, DevPlanConfigLevel } from "../../types/devPlan";
import { SelectProductSector } from "../Selects";

const { TextArea } = Input;
type Props = {
  devPlan: DevPlanFragment;
  parentNode: DataNode;
};

const DevPlanLevelCreate: React.FC<Props> = ({ devPlan, parentNode }) => {
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [createDevPlanLevel, { loading: loadingCreateLevel }] = useCreateDevPlanLevelMutation();
  const [form] = Form.useForm();
  const parentNodeLevel = parentNode?.level ?? 0;
  const devPlanLevelNumbers = [
    0,
    ...(devPlan?.config?.levels?.map((level: DevPlanConfigLevel) => level.number) ?? []),
  ];
  const lastLevel: number = [...devPlanLevelNumbers].sort().pop();
  const singularName = devPlan?.config?.levels[parentNodeLevel]?.singularName;
  const isSectorLevel = !!devPlan?.config?.levels[parentNodeLevel]?.isSectorLevel;

  const formItemLayout = {
    labelCol: { span: 7 },
    wrapperCol: { span: 17 },
  };

  const onFinish = async (values: Record<string, string>) => {
    try {
      const variables = {
        data: {
          devPlanId: devPlan.id,
          code: values.code,
          name: values.name,
          parentId: parentNode.level === 0 ? null : parseInt((parentNode.key as string) || "0"),
          weighting: parseFloat(values.weighting),
          level: (parentNode.level || 0) + 1,
          ...(values.productCatalogId
            ? { productCatalogId: parseInt(values.productCatalogId) }
            : {}),
        },
      };
      const result = await createDevPlanLevel({
        variables,
        refetchQueries: [
          {
            query: GetDevPlanLevelsTreeDocument,
            variables: {
              devPlanId: devPlan.id,
              getRootAsNode: true,
            },
          },
        ],
      });
      sendNotification({
        type: "success",
        message: "Nivel plan de desarrollo creado",
        description: `Se ha creado correctamente el ${singularName} con código número ${result.data?.createDevPlanLevel.code} para el  del plan de desarrollo ${devPlan?.name}`,
      });
      form.resetFields();
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Creando el nivel del plan de desarrollo",
        description: `${e}`,
      });
    }
  };

  const save = () => {
    onFinish(form.getFieldsValue());
  };

  return (
    <>
      {devPlanLevelNumbers.includes(parentNodeLevel) && parentNodeLevel !== lastLevel && (
        <Card
          title={`Crear ${singularName}`}
          style={{ marginTop: "10px" }}
          extra={
            <Space>
              <ButtonSave title="Guardar" onClick={save} loading={loadingCreateLevel} />
            </Space>
          }
        >
          <Form
            {...formItemLayout}
            layout="horizontal"
            form={form}
            initialValues={{ layout: "horizontal" }}
            onFinish={onFinish}
            style={{ display: "flex", marginTop: "20px", flexDirection: "column" }}
          >
            <Form.Item name="code" label={`Código`}>
              <TextArea allowClear autoSize={{ minRows: 1, maxRows: 3 }} />
            </Form.Item>
            <Form.Item name="name" label="Nombre">
              <TextArea allowClear autoSize={{ minRows: 1, maxRows: 3 }} />
            </Form.Item>
            {isSectorLevel && (
              <Form.Item name="productCatalogId" label="Sector DNP">
                <SelectProductSector />
              </Form.Item>
            )}
            <Form.Item name="weighting" label="Ponderación">
              <InputNumber min={0} max={100} />
            </Form.Item>
          </Form>
        </Card>
      )}
    </>
  );
};

export { DevPlanLevelCreate };
