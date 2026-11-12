import { Card, Space, Form, Input, InputNumber, Modal, Typography } from "antd";
import React, { useEffect } from "react";
import { DevPlanFragment } from "../../../graphql/gen/ops";
import {
  GetDevPlanLevelsTreeDocument,
  useDeleteDevPlanLevelsMutation,
  useUpdateDevPlanLevelMutation,
} from "../../../graphql/gen/hooks";
import { ButtonDelete, ButtonSave } from "../Buttons";
import type { DataNode } from "../../types/devPlan";
import { useStoreActions } from "../../store";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import { SelectProductSector } from "../Selects";

const { TextArea } = Input;
const { confirm } = Modal;
const { Title } = Typography;

type Props = {
  devPlan: DevPlanFragment;
  currentNode: DataNode;
};
const DevPlanLevelEdit: React.FC<Props> = ({ devPlan, currentNode }) => {
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [updateDevPlanLevel, { loading: loadingUpdateLevel }] = useUpdateDevPlanLevelMutation();
  const [deleteDevPlanLevels, { loading: loadingDeleteLevel }] = useDeleteDevPlanLevelsMutation({});
  const [form] = Form.useForm();
  const currentNodeLevel = currentNode?.level ?? 0;
  const singularName = devPlan?.config?.levels[currentNodeLevel - 1]?.singularName;
  const isSectorLevel = !!devPlan?.config?.levels[currentNodeLevel - 1]?.isSectorLevel;

  useEffect(() => {
    const editFields = {
      code: currentNode.code,
      name: currentNode.title,
      productCatalogId: currentNode.productCatalogId,
      weighting: currentNode.weighting,
    };
    form.setFieldsValue(editFields);
  }, [currentNode, form]);

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
          id: parseInt((currentNode.key as string) || "0"),
          ...(values.productCatalogId
            ? { productCatalogId: parseInt(values.productCatalogId) }
            : {}),
          weighting: parseFloat(values.weighting),
        },
      };
      const result = await updateDevPlanLevel({ variables });
      sendNotification({
        type: "success",
        message: "Nivel plan de desarrollo actualizado",
        description: `Se ha actualizado satisfactorialmente el ${singularName} con código número ${result.data?.updateDevPlanLevel.code} para el  del plan de desarrollo ${devPlan?.name}`,
      });
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Editando el nivel del plan de desarrollo",
        description: `${e}`,
      });
    }
  };

  const getChildrenIds = (currentNode: DataNode) => {
    let ids: number[] = [];
    currentNode.children?.forEach((node: DataNode) => {
      ids.push(parseInt(node.key as string));
      if (node.children) {
        ids = [...ids, ...getChildrenIds(node)];
      }
    });
    return ids;
  };

  const showDeleteConfirm = (node: DataNode) => {
    confirm({
      title: "Está seguro de eliminar este nivel del plan?",
      icon: <ExclamationCircleOutlined />,
      content: (
        <span>
          El nivel{" "}
          <Title style={{ display: "inline" }} level={5}>
            {`${node.code} ${node.title}`}
          </Title>
          {` del plan ${devPlan.name}, se eliminará de forma permanente junto con sus nodos hijos. Desea continuar?`}
        </span>
      ),
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk() {
        // Get all ids to delete
        const ids = [parseInt(currentNode?.key as string), ...getChildrenIds(currentNode)];
        deleteLevels(ids, currentNode);
      },
    });
  };

  const update = () => {
    onFinish(form.getFieldsValue());
  };
  const deleteLevels = async (ids: number[], node: DataNode) => {
    if (ids.length) {
      try {
        const variables = { ids };
        await deleteDevPlanLevels({
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
          message: "Nivel plan de desarrollo eliminado",
          description: `Se ha eliminado satisfactorialmente el ${singularName} con código ${node.code} del plan de desarrollo ${devPlan?.name}`,
        });
      } catch (e) {
        sendNotification({
          type: "error",
          message: "Eliminando el nivel del plan de desarrollo",
          description: `${e}`,
        });
      }
    }
  };

  return (
    <>
      {currentNodeLevel > 0 &&
        currentNodeLevel <= devPlan?.config?.levels?.length &&
        currentNode.key !== "root" && (
          <Card
            title={`Editar ${singularName}`}
            extra={
              <Space>
                <ButtonSave title="Editar" onClick={update} loading={loadingUpdateLevel} />
                <ButtonDelete
                  title="Eliminar"
                  onClick={() => showDeleteConfirm(currentNode)}
                  loading={loadingDeleteLevel}
                />
              </Space>
            }
          >
            <Form
              {...formItemLayout}
              layout="horizontal"
              form={form}
              // initialValues={{ layout: "horizontal", ...editLevel }}
              initialValues={{ layout: "horizontal" }}
              onFinish={onFinish}
              style={{ display: "flex", marginTop: "20px", flexDirection: "column" }}
            >
              <Form.Item name="code" label="Código">
                <TextArea autoSize={{ minRows: 1, maxRows: 3 }} />
              </Form.Item>
              <Form.Item name="name" label="Nombre">
                <TextArea autoSize={{ minRows: 1, maxRows: 3 }} />
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

export { DevPlanLevelEdit };
