import React, { useEffect } from "react";
import { Button, DatePicker, Divider, Form, FormInstance, Input } from "antd";
import { DevPlanLevelForm } from "./DevPlanLevelForm";
import { FormButtonContainer } from "../Buttons";
import { useRouter } from "next/router";
import { ContentLoading } from "../Utils/ContentLoading";
import { useCreateDevPlan } from "./hooks";
import { SelectGoalActivitySource } from "../Selects";

type Props = {
  onSave: () => void;
  operation: "create" | "update";
  id?: number;
  dataLoading?: boolean;
  saveLoading: boolean;
  dataError?: any;
  form: FormInstance<any>;
};

const { RangePicker } = DatePicker;

const DevPlanForm: React.FC<Props> = ({
  form,
  onSave,
  operation,
  id,
  dataLoading,
  saveLoading,
  dataError,
}) => {
  const router = useRouter();
  const { searchPlanByCode } = useCreateDevPlan();

  const formItemLayout = {
    labelCol: { span: 5 },
    wrapperCol: { span: 14 },
  };

  return (
    <ContentLoading loading={dataLoading} error={dataError}>
      <Form
        {...formItemLayout}
        layout="horizontal"
        form={form}
        initialValues={{ layout: "horizontal" }}
        onFinish={onSave}
        requiredMark={true}
      >
        <Form.Item
          name="code"
          label="Código plan"
          rules={[
            { required: true },
            ({ getFieldValue }) => ({
              validator: async (_, value) => {
                if (value) {
                  const devPlan = await searchPlanByCode(value);
                  if (
                    devPlan &&
                    (operation === "create" || (operation === "update" && devPlan?.id !== id))
                  ) {
                    throw new Error(
                      "Este código ya está siendo utilizado, por favor intente con otro",
                    );
                  }
                }
              },
            }),
          ]}
        >
          <Input placeholder="Código" style={{ width: 100 }} />
        </Form.Item>
        <Form.Item name="name" rules={[{ required: true }]} label="Nombre plan">
          <Input placeholder="Nombre del plan de desarrollo" />
        </Form.Item>
        <Form.Item name="startEndDates" rules={[{ required: true }]} label="Fecha inicio/fin plan">
          <RangePicker />
        </Form.Item>
        <Form.Item name="governmentName" rules={[{ required: true }]} label="Nombre gobernante">
          <Input placeholder="Nombre gobernador(a)/alcalde(sa)" />
        </Form.Item>
        <Form.Item
          name="governmentStartEndDates"
          rules={[{ required: true }]}
          label="Fecha inicio/fin gobernante"
        >
          <RangePicker />
        </Form.Item>
        <Form.Item
          name="goalActivitySource"
          rules={[{ required: true }]}
          label="Vinculación de actividades y metas"
        >
          <SelectGoalActivitySource />
        </Form.Item>

        <div style={{ marginTop: "10px" }}>
          <Divider orientation="left">Niveles</Divider>
          <Form.List name="levels">
            {(fields, { add, remove }) => (
              <DevPlanLevelForm fields={fields} add={add} remove={remove} />
            )}
          </Form.List>
        </div>

        <Form.Item
          style={{ marginTop: "10px" }}
          wrapperCol={{
            xs: { span: 24, offset: 0 },
            sm: { span: 14, offset: 10 },
          }}
        >
          <FormButtonContainer>
            <Button type="primary" htmlType="submit" loading={saveLoading}>
              Guardar
            </Button>
            <Button type="default" onClick={() => router.push("/config/dev-plans/")}>
              Volver
            </Button>
          </FormButtonContainer>
        </Form.Item>
      </Form>
    </ContentLoading>
  );
};

export { DevPlanForm };
