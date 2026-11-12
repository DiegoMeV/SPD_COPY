import React from "react";
import { Form, Input, Drawer, Space, InputNumber, Divider } from "antd";
import { ButtonEdit } from "../Buttons";
import { EntitySelect } from "../Entities/EntitySelect";
import {
  SelectAccumulationType,
  SelectGoal,
  SelectMacroProject,
  SelectOds,
  SelectProductCatalog,
  SelectPublicPoliticComponents,
  SelectPublicPolitics,
  SelectUnits,
} from "../Selects";
import { MonitoringConfigUsedFor, PublicPoliticCategory } from "../../../graphql/gen/schema";
import { useEditGoal, useGoal } from "./hooks";
import { useMonitoringConfig } from "../MonitoringConfig/hooks";
import { useDevPlanTree } from "../DevPlanTree/hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";
import { Goal } from "../../types/goal";

const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 16, offset: 0.5 },
};

type Props = {
  goal: Goal;
  usedFor?: MonitoringConfigUsedFor;
};

const GoalEdit: React.FC<Props> = ({
  goal,
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
}) => {
  const [form] = Form.useForm();
  const {
    updateGoal,
    getFormEditValues,
    open,
    selectedEntityId,
    setOpen,
    updateLoading,
    setCurrentGoal,
    onValuesChange,
    selectedPublicPolitic,
  } = useEditGoal({
    id: goal.id,
    form,
    usedFor,
  });
  const { searchGoalsByCode } = useGoal();
  const { currentGoalTypeLabel, isParentGoalTypeLevel, selectedNode, currentLevelSingularName } =
    useDevPlanTree();
  const { currentMonitoring } = useMonitoringConfig();

  const onClose = () => {
    setOpen(false);
  };

  const title =
    usedFor === MonitoringConfigUsedFor.DevelopmentPlans
      ? `Editar meta de ${currentGoalTypeLabel}`
      : "Editar acción";

  return (
    <Space>
      <ButtonEdit
        onClick={() => {
          setCurrentGoal(goal);
          setOpen(true);
        }}
        title={title}
      />
      <Drawer
        title={title}
        placement="right"
        size="large"
        onClose={onClose}
        open={open}
        extra={
          <FormSubmitButtons
            type="text"
            submitAction={updateGoal}
            returnAction={() => setOpen(false)}
            loading={updateLoading}
          />
        }
      >
        <Form
          form={form}
          layout="horizontal"
          onFinish={updateGoal}
          {...formItemLayout}
          requiredMark={true}
          initialValues={{ unitsFactor: 1, ...getFormEditValues() }}
          disabled={updateLoading}
          onValuesChange={onValuesChange}
        >
          <Form.Item name="devPlanLevel" label={currentLevelSingularName}>
            <span className="ant-form-text">{selectedNode?.title}</span>
          </Form.Item>
          <Form.Item
            name="code"
            label={`Código ${
              usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? "Meta" : "Acción"
            }`}
            rules={[
              { required: true },
              ({ getFieldValue }) => ({
                validator: async (_, value) => {
                  if (value) {
                    const goals = await searchGoalsByCode(value);
                    if ((goals ?? []).length > 0) {
                      throw new Error(
                        "Este código ya está siendo utilizado, por favor intente con otro",
                      );
                    }
                  }
                },
              }),
            ]}
          >
            <Input style={{ width: "40%" }} />
          </Form.Item>
          <Form.Item name="name" label="Nombre" rules={[{ required: true }]}>
            <Input.TextArea rows={2} />
          </Form.Item>
          <Form.Item name="entityId" label="Entidad" rules={[{ required: true }]}>
            <EntitySelect />
          </Form.Item>
          {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
            <Form.Item name="macroProjectId" label="Macro Proyecto">
              <SelectMacroProject />
            </Form.Item>
          )}
          {usedFor === MonitoringConfigUsedFor.PublicPolitics && (
            <Form.Item name="extraEntityIds" label="Corresponsables">
              <EntitySelect multiple excludeIds={selectedEntityId ? [selectedEntityId] : []} />
            </Form.Item>
          )}
          {isParentGoalTypeLevel && (
            <Form.Item name="parentGoalId" label="Meta padre">
              <SelectGoal
                levelId={parseInt(selectedNode?.key as string)}
                parentGoals
                width="100%"
              />
            </Form.Item>
          )}
          {usedFor === MonitoringConfigUsedFor.PublicPolitics && (
            <Form.Item name="publicPoliticComponentId" label="Componente">
              <SelectPublicPoliticComponents
                multiple={false}
                showIds={selectedPublicPolitic?.components?.map((component) => component.id)}
              />
            </Form.Item>
          )}
          <Form.Item name="indicator" label="Indicador" rules={[{ required: true }]}>
            <Input.TextArea rows={2} />
          </Form.Item>
          <Form.Item name="formula" label="Fórmula">
            <Input.TextArea rows={2} />
          </Form.Item>
          <Form.Item name="description" label="Descripción">
            <Input.TextArea rows={3} />
          </Form.Item>
          <Form.Item name="accumulationType" label="Tipo de acumulación">
            <SelectAccumulationType />
          </Form.Item>
          {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
            <>
              <Form.Item name="weighting" label="Ponderación">
                <InputNumber min={0} max={100} style={{ width: "40%" }} />
              </Form.Item>
              <Form.Item name="baseValue" label="Valor base">
                <Input style={{ width: "40%" }} />
              </Form.Item>
            </>
          )}
          <Form.Item name="goalValue" label="Valor meta" rules={[{ required: true }]}>
            <Input style={{ width: "40%" }} />
          </Form.Item>
          <Form.Item name="unitsFactor" label="Factor meta" rules={[{ required: true }]}>
            <Input style={{ width: "25%" }} />
          </Form.Item>
          <Form.Item name="unitsName" label="Unidad medida">
            <SelectUnits />
          </Form.Item>
          {currentMonitoring?.supportProductMonitoring &&
            usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
              <>
                <Divider>Indicador de Producto</Divider>
                <Form.Item name="productCatalogId" label="Indicador de Producto">
                  <SelectProductCatalog />
                </Form.Item>
                <Form.Item name="piBaseValue" label="Valor base">
                  <Input style={{ width: "40%" }} />
                </Form.Item>
                <Form.Item name="piGoalValue" label="Valor meta">
                  <Input style={{ width: "40%" }} />
                </Form.Item>
                <Form.Item name="piUnitsFactor" label="Factor meta">
                  <Input style={{ width: "25%" }} />
                </Form.Item>
                <Form.Item name="piUnitsName" label="Unidad medida">
                  <SelectUnits />
                </Form.Item>
              </>
            )}
          {!currentMonitoring?.supportProductMonitoring &&
            usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
              <Form.Item name="productCatalogId" label="Indicador de Producto">
                <SelectProductCatalog />
              </Form.Item>
            )}
          {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && (
            <>
              <Divider />
              <Form.Item name="peacePoliticId" label="Política de Paz">
                <SelectPublicPolitics category={PublicPoliticCategory.Peace} />
              </Form.Item>
              <Form.Item name="victimsPoliticId" label=" Política de Víctimas">
                <SelectPublicPolitics category={PublicPoliticCategory.Victims} />
              </Form.Item>
              <Form.Item name="odsIds" label="ODS">
                <SelectOds />
              </Form.Item>
            </>
          )}
        </Form>
      </Drawer>
    </Space>
  );
};

export { GoalEdit };
