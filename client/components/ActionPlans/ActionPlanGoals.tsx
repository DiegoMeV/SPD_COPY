import React, { useEffect, useState } from "react";
import {
  Card,
  Col,
  Form,
  Input,
  InputNumber,
  Popconfirm,
  Row,
  Space,
  Table,
  TableProps,
  Typography,
} from "antd";
import { useTable } from "../../hooks/useTable";
import { GoalType } from "../../../graphql/gen/schema";
import { ButtonBack, ButtonCancel, ButtonDelete, ButtonEdit, ButtonSave } from "../Buttons";
import { useGoal, useDeleteGoal } from "../Goals/hooks";
import { Goal } from "../../types/goal";
import { GoalNew } from "../Goals/GoalNew";
import { useUpdateGoalMutation } from "../../../graphql/gen/hooks";
import { ProjectActivitySelect } from "../Siif/Projects/ProjectActivitySelect";

const EditableContext = React.createContext<any>(null);
const { Link, Text } = Typography;

interface EditableCellProps extends React.HTMLAttributes<HTMLElement> {
  editing: boolean;
  dataIndex: string;
  title: any;
  inputType: "number" | "text" | "textArea" | "activitySelect";
  record: Goal;
  index: number;
}

const EditableCell: React.FC<React.PropsWithChildren<EditableCellProps>> = ({
  editing,
  dataIndex,
  title,
  inputType,
  record,
  index,
  children,
  ...restProps
}) => {
  const inputNode =
    inputType === "number" ? (
      <InputNumber />
    ) : inputType === "textArea" ? (
      <Input.TextArea />
    ) : inputType === "activitySelect" ? (
      <ProjectActivitySelect
        project={record.projectCode ?? "0"}
        width={300}
        value={record.actividad?.id}
      />
    ) : (
      <Input />
    );

  return (
    <td {...restProps}>
      {editing ? (
        <Form.Item
          name={dataIndex}
          style={{ margin: 0 }}
          rules={[
            {
              required: true,
              message: `Por favor ingresa ${title}!`,
            },
          ]}
        >
          {inputNode}
        </Form.Item>
      ) : (
        children
      )}
    </td>
  );
};

const ActionPlanGoals: React.FC = () => {
  const { getColumnRender } = useTable();
  const { currentGoal, setCurrentGoal } = useGoal();
  const { deleteGoal, loading: loadingDelete } = useDeleteGoal();
  const [activities, setActivities] = useState<Goal[]>([]);
  const [form] = Form.useForm();
  const [editingId, setEditingId] = useState<number | undefined>();
  const [updateGoalMutation, { loading: loadingUpdate, error, data }] = useUpdateGoalMutation();

  useEffect(() => {
    setActivities(currentGoal?.children ?? []);
  }, [currentGoal?.children]);

  const isEditing = (record: Goal) => record.id === editingId;

  const edit = (record: Partial<Goal>) => {
    form.setFieldsValue({ name: record.name, code: record.code, actividad: record?.actividad?.id });
    setEditingId(record.id);
  };

  const cancel = () => {
    setEditingId(undefined);
  };

  const save = async (row: Goal) => {
    try {
      const values = await form.validateFields();
      const result = await updateGoalMutation({
        variables: {
          data: { id: row.id, code: values.code, name: values.name, activityId: values.actividad },
        },
      });
      setEditingId(undefined);

      const index = activities.findIndex((item) => row.id === item.id);
      if (index > -1) {
        setActivities([
          ...activities.slice(0, index),
          { ...activities[index], ...result?.data?.updateGoal },
          ...activities.slice(index + 1),
        ]);
      }
      setEditingId(undefined);
    } catch (errInfo) {
      console.log("Validate Failed:", errInfo);
    }
  };

  const columns = [
    {
      ...getColumnRender("code", "Código"),
      width: "8%",
      editable: true,
      render: (field: string, row: Goal) => <span>{row.code}</span>,
    },
    {
      ...getColumnRender("name", "Meta"),
      width: "40%",
      editable: true,
      render: (field: string, row: Goal) => (field ? <Text>{field}</Text> : null),
    },
    {
      ...getColumnRender("actividad", "Actividad"),
      editable: true,
      width: "40%",
      render: (field: Goal["actividad"]) =>
        field ? (
          <Text>
            {field.codigoAct} - {field.descripcion}
          </Text>
        ) : null,
    },
    {
      ...getColumnRender("id", "Acciones"),
      width: 100,
      render: (field: string, row: Goal) => {
        const editable = isEditing(row);

        return editable ? (
          <Space>
            <ButtonSave onClick={() => save(row)} />
            <ButtonCancel onClick={() => setEditingId(undefined)} />
          </Space>
        ) : (
          <Space>
            <ButtonEdit onClick={() => edit(row)} disabled={editingId !== undefined} />
            <ButtonDelete
              message="Está seguro de eliminar esta meta?"
              onDelete={async () => {
                const result = await deleteGoal(row.id);
                if (result && currentGoal) {
                  setCurrentGoal({
                    ...currentGoal,
                    children: currentGoal.children?.filter((goal) => goal.id !== row.id),
                  });
                }
              }}
              loading={loadingDelete}
              disabled={editingId !== undefined}
            />
          </Space>
        );
      },
    },
  ];

  const mergedColumns: TableProps<Goal>["columns"] = columns.map((col) => {
    if (!col.editable) {
      return col;
    }
    return {
      ...col,
      onCell: (record: Goal) => ({
        record,
        inputType: col.dataIndex === "actividad" ? "activitySelect" : "text",
        dataIndex: col.dataIndex,
        title: col.title,
        editing: isEditing(record),
      }),
    };
  });

  return (
    <Card
      title="Metas del Plan de Acción"
      extra={
        <Space>
          <ButtonBack onClick={() => setCurrentGoal(undefined)} />
          <GoalNew goalTypes={[GoalType.ActionPlanActivity]} />
        </Space>
      }
      styles={{ body: { paddingTop: "6px" } }}
    >
      <Row gutter={[12, 4]}>
        <Col span={24}>
          <Form form={form} component={false}>
            <Table<Goal>
              dataSource={activities ?? []}
              columns={mergedColumns}
              size="small"
              rowKey={(record: Goal) => record.id}
              bordered
              components={{
                body: { cell: EditableCell },
              }}
              rowClassName="editable-row"
            />
          </Form>
        </Col>
      </Row>
    </Card>
  );
};

export default ActionPlanGoals;
