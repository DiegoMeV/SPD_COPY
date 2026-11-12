import React from "react";
import { Button, Form, Input, DatePicker, Checkbox, Switch, Divider, FormInstance } from "antd";
import { useRouter } from "next/router";
import { FormButtonContainer } from "../Buttons";
import {
  SelectSpentDoc,
  SelectWeightingType,
  SelectMonitoringResourcesOrigin,
  SelectGoalType,
} from "../Selects";
import { MonitoringConfigColorsForm } from "./MonitoringConfigColorsForm";
import { DevPlanSelect } from "../DevPlan";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";
import { ContentLoading } from "../Utils/ContentLoading";

const { RangePicker } = DatePicker;

type Props = {
  usedFor?: MonitoringConfigUsedFor;
  operation: "create" | "update";
  dataLoading?: boolean;
  saveLoading: boolean;
  dataError?: any;
  form: FormInstance<any>;
  onSave: () => void;
};

const MonitoringConfigForm: React.FC<Props> = ({
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
  form,
  onSave,
  operation,
  dataLoading,
  saveLoading,
  dataError,
}) => {
  const router = useRouter();
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
        <Form.Item name="usedFor" hidden={true} />
        {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
          <Form.Item name="devPlanId" rules={[{ required: true }]} label="Plan de Desarrollo">
            <DevPlanSelect firstSelected width={500} />
          </Form.Item>
        )}
        <Form.Item name="period" rules={[{ required: true }]} label="Periodo">
          <Input placeholder="Periodo" style={{ width: 100 }} />
        </Form.Item>
        <Form.Item name="subperiod" rules={[{ required: true }]} label="Subperiodo">
          <Input placeholder="Subperiodo" style={{ width: 100 }} />
        </Form.Item>
        {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
          <Form.Item name="goalTypes" rules={[{ required: true }]} label="Seguimiento para">
            <SelectGoalType multiple={true} fullGoalTypes={true} />
          </Form.Item>
        )}
        {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
          <>
            <Form.Item
              name="monitoringResourcesOrigin"
              rules={[{ required: true }]}
              label="Origen de datos financieros"
            >
              <SelectMonitoringResourcesOrigin />
            </Form.Item>{" "}
            <Form.Item name="spentDocs" rules={[{ required: true }]} label="Documento de ejecución">
              <SelectSpentDoc />
            </Form.Item>
            <Form.Item name="weightingType" rules={[{ required: true }]} label="Ponderación">
              <SelectWeightingType />
            </Form.Item>
          </>
        )}
        {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
          <Form.Item
            name="scheduling"
            rules={[{ required: true }]}
            label="Fecha inicio/fin programación"
          >
            <RangePicker />
          </Form.Item>
        )}
        <Form.Item name="reporting" rules={[{ required: true }]} label="Fecha inicio/fin reporte">
          <RangePicker />
        </Form.Item>
        <Form.Item
          name="validating"
          rules={[{ required: true }]}
          label="Fecha inicio/fin validación"
        >
          <RangePicker />
        </Form.Item>
        <Form.Item
          name="reviewing"
          rules={[{ required: true }]}
          label="Fecha inicio/fin de revisión"
        >
          <RangePicker />
        </Form.Item>
        {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
          <>
            <Form.Item name="copyGoals" valuePropName="checked" label="Copiar metas">
              <Checkbox>Copiar la programación de metas del subperiodo anterior?</Checkbox>
            </Form.Item>
            <Form.Item
              name="supportProductMonitoring"
              valuePropName="checked"
              label="Seguimiento Catálogo de Productos"
            >
              <Checkbox>Permitir seguimiento de indicadores del catálogo de productos?</Checkbox>
            </Form.Item>
            <Form.Item name="sgpDiscriminated" valuePropName="checked" label="SGP Discriminado">
              <Checkbox>Discriminar fuente de financiación SGP?</Checkbox>
            </Form.Item>
          </>
        )}
        <Form.Item
          name="isActive"
          rules={[{ required: true }]}
          label="Activo"
          valuePropName="checked"
        >
          <Switch />
        </Form.Item>
        <div style={{ marginTop: "10px" }}>
          <Divider orientation="left">Colores de Indicadores</Divider>
          <Form.List name="colorsConfig">
            {(fields, { add, remove }) => (
              <MonitoringConfigColorsForm
                fields={fields}
                add={add}
                remove={remove}
                colorsConfig={form.getFieldValue("colorsConfig")}
              />
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
            <Button type="default" onClick={() => router.push("/monitoring/config")}>
              Volver
            </Button>
          </FormButtonContainer>
        </Form.Item>
      </Form>
    </ContentLoading>
  );
};

export { MonitoringConfigForm };
