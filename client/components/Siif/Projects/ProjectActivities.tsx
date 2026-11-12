import React, { useContext, useEffect, useRef, useState } from "react";
import { ProyectoRecord } from "./hooks";
import { Col, Flex, Form, Row, Table, Typography } from "antd";
import type { ColumnsType } from "antd/lib/table";
import { useRowSelection, useTable } from "../../../hooks/useTable";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalDetails } from "../../Goals";
import { useLinkGoalToActivityMutation } from "../../../../graphql/gen/hooks";
import { GoalActivitySource, GoalType } from "../../../../graphql/gen/schema";
import { GoalSelectForPlan } from "../../Goals/GoalSelectForPlan";
import { ButtonEdit } from "../../Buttons";

const EditableContext = React.createContext<any>(null);
const { Link, Text } = Typography;

type ActivityType = NonNullable<ProyectoRecord["actividades"]>[number];
type Props = {
  project: ProyectoRecord;
};

const EditableRow = ({ index, ...props }: { index: number }) => {
  const [form] = Form.useForm();
  return (
    <Form form={form} component={false}>
      <EditableContext.Provider value={form}>
        <tr {...props} />
      </EditableContext.Provider>
    </Form>
  );
};

const EditableCell = ({
  title,
  editable,
  children,
  dataIndex,
  record,
  rowIndex,
  availableAssignees,
  optionsAssignees,
  handleSave,
  devPlanId,
  ...restProps
}: any) => {
  const [editing, setEditing] = useState(false);
  const inputRef = useRef<any>(null);
  const form = useContext(EditableContext);
  useEffect(() => {
    if (editing && inputRef?.current) {
      inputRef?.current?.focus();
    }
  }, [editing]);

  const toggleEdit = () => {
    setEditing(!editing);
    form.setFieldsValue({
      [dataIndex]: record[dataIndex],
    });
  };

  const save = async () => {
    const values = await form.validateFields();
    const goalId = values.codigoMeta;
    toggleEdit();
    if (dataIndex === "codigoMeta" && values.codigoMeta !== record.codigoMeta) {
      handleSave(dataIndex, { ...record, rowIndex, devPlanId, ...values, goalId });
    }
  };

  let childNode = children;

  if (editable) {
    childNode = editing ? (
      <div className="editable-cell-input">
        <Form.Item
          style={{
            margin: 0,
          }}
          name={dataIndex}
        >
          <GoalSelectForPlan
            devPlanId={devPlanId}
            goalType={GoalType.Product}
            onBlur={save}
            inputRef={inputRef}
          />
        </Form.Item>
      </div>
    ) : (
      <Flex justify="space-between">
        <Text>{children}</Text>
        <ButtonEdit onClick={toggleEdit} size="small" />
      </Flex>
    );
  }

  return <td {...restProps}>{childNode}</td>;
};

const ProjectActivities: React.FC<Props> = ({ project }) => {
  const { getColumnRender } = useTable();
  const [linkGoalAndActivity] = useLinkGoalToActivityMutation();
  const [activities, setActivities] = useState<ActivityType[]>(project.actividades ?? []);

  const components = {
    body: {
      row: EditableRow,
      cell: EditableCell,
    },
  };

  const defaultColumns = [
    {
      ...getColumnRender("codigoAct", "Actividad"),
      render: (field: string, row: ActivityType) => (
        <span>
          {field} - {row.descripcion}
        </span>
      ),
    },
    {
      ...getColumnRender("codigoMeta", "Código Meta"),
      editable: project.devPlan?.goalActivitySource === GoalActivitySource.Manual,
      render: (field: string, row: ActivityType) =>
        field && row.linkedGoal ? (
          <span>
            <ModalLink link={<Link>{field}</Link>}>
              <GoalDetails goal={row.linkedGoal} />
            </ModalLink>
          </span>
        ) : null,
    },
    {
      ...getColumnRender("nombreMeta", "Meta"),
      render: (field: string, row: ActivityType) => (field ? <Text>{field}</Text> : null),
    },
  ];

  const columns: ColumnsType<ActivityType> = defaultColumns.map((col: any) => {
    if (!col.editable) {
      return col;
    }

    return {
      ...col,
      onCell: (record: ActivityType, rowIndex: number) => ({
        record,
        rowIndex,
        editable: col.editable,
        dataIndex: col.dataIndex,
        title: col.title,
        devPlanId: project?.devPlan?.id,
        handleSave,
      }),
    };
  }) as ColumnsType<ActivityType>;

  const handleSave = async (dataIndex: string, row: ActivityType & { linkedGoalId: number }) => {
    // The optimisticResponse allows the UI to be
    // updated even before the mutation is pushed
    // to the GraphQL server
    if (row.linkedGoalId) {
      linkGoalAndActivity({
        variables: {
          data: {
            id: row.linkedGoalId,
            activityId: row.id,
            goalId: row.linkedGoalId,
          },
        },
        onCompleted: (data) => {
          setActivities(
            activities?.map((activity: ActivityType) =>
              activity.id === row.id
                ? {
                    ...activity,
                    linkedGoal: data?.linkGoalToActivity?.goal,
                    codigoMeta: data?.linkGoalToActivity?.goal?.code,
                    nombreMeta: data?.linkGoalToActivity?.goal?.name,
                  }
                : activity,
            ),
          );
        },
      });
    }
  };

  return (
    <Row gutter={[12, 4]}>
      <Col span={24}>
        <Table
          dataSource={activities ?? []}
          columns={columns}
          size="small"
          rowKey={(record: ActivityType) => record.id}
          bordered
          components={components}
          rowClassName={() => "editable-row"}
        />
      </Col>
    </Row>
  );
};

export default ProjectActivities;
