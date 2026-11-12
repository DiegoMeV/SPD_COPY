import React, { use } from "react";
import { Form, Input, Drawer, Space, InputNumber, Divider } from "antd";
import { ButtonAdd } from "../Buttons";
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
import {
  GoalType,
  MonitoringConfigUsedFor,
  PublicPoliticCategory,
} from "../../../graphql/gen/schema";
import { useCreateGoal, useGoal } from "./hooks";
import { useDevPlanTree } from "../DevPlanTree/hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";
import { useMonitoringConfig } from "../MonitoringConfig/hooks";
import { useMonitoring } from "../../hooks/useMonitoring";
import { ProjectSelect } from "../Siif/Projects/ProjectSelect";
import { ProjectActivitySelect } from "../Siif/Projects/ProjectActivitySelect";

const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 16, offset: 0.5 },
};

type Props = {
  usedFor?: MonitoringConfigUsedFor;
  mode?: "hierarchy" | "list";
  goalTypes?: GoalType[];
  onClick?: () => void;
};

const GoalNew: React.FC<Props> = ({
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
  mode = "hierarchy",
  goalTypes,
  onClick,
}) => {
  const [form] = Form.useForm();
  const { searchGoalsByCode, searchActionPlanGoalsByCode } = useGoal();
  const { currentGoalTypeLabel, isParentGoalTypeLevel, selectedNode, currentLevelSingularName } =
    useDevPlanTree();
  const {
    createGoal,
    loading,
    open,
    selectedEntityId,
    selectedPublicPolitic,
    setOpen,
    onValuesChange,
  } = useCreateGoal({
    form,
    usedFor,
    goalTypes,
  });
  const { currentMonitoring } = useMonitoringConfig();
  const { isActionPlanMonitoring, isActionPlanActivityMonitoring, isGoalMonitoring } =
    useMonitoring({
      goalTypes,
    });
  const { currentGoal } = useGoal();

  const onClose = () => {
    setOpen(false);
  };

  console.log(`GoalNew: currentGoal:`, currentGoal);

  const getTitle = () => {
    if (usedFor === MonitoringConfigUsedFor.DevelopmentPlans) {
      if (mode === "hierarchy") {
        if (isGoalMonitoring()) return `Nueva meta de ${currentGoalTypeLabel}`;
        else if (isActionPlanMonitoring()) return "Nuevo plan de acción";
        else if (isActionPlanActivityMonitoring()) return "Nueva meta del plan de acción";
        else return "Nueva acción";
      } else return "Nueva meta";
    } else {
      return "Nueva acción";
    }
  };

  const getLabel = () => {
    if (usedFor === MonitoringConfigUsedFor.DevelopmentPlans) {
      if (mode === "hierarchy") {
        if (isGoalMonitoring()) return `${currentGoalTypeLabel}`;
        else if (isActionPlanMonitoring()) return "Plan de acción";
        else if (isActionPlanActivityMonitoring()) return "Meta";
        else return "Acción";
      } else return "Meta";
    } else {
      return "Acción";
    }
  };

  const title = getTitle();

  return (
    <Space>
      <ButtonAdd
        onClick={() => {
          setOpen(true);
          onClick?.();
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
            submitAction={form.submit}
            returnAction={() => setOpen(false)}
            loading={loading}
          />
        }
      >
        <Form
          form={form}
          layout="horizontal"
          onFinish={createGoal}
          {...formItemLayout}
          requiredMark={true}
          initialValues={{ unitsFactor: 1 }}
          onValuesChange={onValuesChange}
          disabled={loading}
        >
          <Form.Item name="devPlanLevel" label={currentLevelSingularName}>
            <span className="ant-form-text">{selectedNode?.title}</span>
          </Form.Item>
          {isActionPlanActivityMonitoring() && (
            <Form.Item name="actionPlanCode" label="Plan de Acción">
              <span className="ant-form-text">{currentGoal?.code}</span>
            </Form.Item>
          )}
          {isActionPlanActivityMonitoring() && (
            <Form.Item name="projectCode" label="Proyecto">
              <span className="ant-form-text">{currentGoal?.projectCode}</span>
            </Form.Item>
          )}
          {isActionPlanActivityMonitoring() && (
            <Form.Item name="entityName" label="Entidad">
              <span className="ant-form-text">{currentGoal?.entity?.name}</span>
            </Form.Item>
          )}
          <Form.Item
            name="code"
            label={`Código ${getLabel()}`}
            rules={[
              { required: true },
              ({ getFieldValue }) => ({
                validator: async (_, value) => {
                  if (value) {
                    const goals = isActionPlanActivityMonitoring()
                      ? await searchActionPlanGoalsByCode(currentGoal?.id, value)
                      : await searchGoalsByCode(value);
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
          {(isGoalMonitoring() || isActionPlanActivityMonitoring()) && (
            <Form.Item name="name" label="Nombre" rules={[{ required: true }]}>
              <Input.TextArea rows={2} />
            </Form.Item>
          )}
          {isActionPlanMonitoring() && (
            <Form.Item name="projectCode" label="Proyecto" rules={[{ required: true }]}>
              <ProjectSelect />
            </Form.Item>
          )}
          {isActionPlanActivityMonitoring() && (
            <Form.Item name="activityId" label="Actividad" rules={[{ required: false }]}>
              <ProjectActivitySelect project={currentGoal?.projectCode ?? ""} width={"100%"} />
            </Form.Item>
          )}
          {!isActionPlanActivityMonitoring() && (
            <Form.Item name="entityId" label="Entidad" rules={[{ required: true }]}>
              <EntitySelect />
            </Form.Item>
          )}
          {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && isGoalMonitoring() && (
            <Form.Item name="macroProjectId" label="Macro Proyecto">
              <SelectMacroProject />
            </Form.Item>
          )}
          {usedFor === MonitoringConfigUsedFor.PublicPolitics && (
            <Form.Item name="extraEntityIds" label="Corresponsables">
              <EntitySelect multiple excludeIds={selectedEntityId ? [selectedEntityId] : []} />
            </Form.Item>
          )}
          {isParentGoalTypeLevel &&
            usedFor === MonitoringConfigUsedFor.DevelopmentPlans &&
            isGoalMonitoring() && (
              <Form.Item name="parentGoalId" label="Meta padre">
                <SelectGoal
                  levelId={parseInt(selectedNode?.key as string)}
                  parentGoals
                  width="100%"
                />
              </Form.Item>
            )}
          {usedFor === MonitoringConfigUsedFor.PublicPolitics && isGoalMonitoring() && (
            <Form.Item name="publicPoliticComponentId" label="Componente">
              <SelectPublicPoliticComponents
                multiple={false}
                showIds={selectedPublicPolitic?.components?.map((component) => component.id)}
              />
            </Form.Item>
          )}
          {isGoalMonitoring() && (
            <>
              <Form.Item name="indicator" label="Indicador" rules={[{ required: true }]}>
                <Input.TextArea rows={2} />
              </Form.Item>
              <Form.Item name="formula" label="Fórmula">
                <Input.TextArea rows={2} />
              </Form.Item>
              <Form.Item
                name="description"
                label={MonitoringConfigUsedFor.DevelopmentPlans ? "Descripción" : "Resultado"}
              >
                <Input.TextArea rows={3} />
              </Form.Item>
              <Form.Item
                name="accumulationType"
                label="Tipo de acumulación"
                rules={[{ required: true }]}
              >
                <SelectAccumulationType />
              </Form.Item>
            </>
          )}
          {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && isGoalMonitoring() && (
            <>
              <Form.Item name="weighting" label="Ponderación">
                <InputNumber min={0} max={100} style={{ width: "40%" }} />
              </Form.Item>
              <Form.Item name="baseValue" label="Valor base">
                <Input style={{ width: "40%" }} />
              </Form.Item>
            </>
          )}
          {isGoalMonitoring() && (
            <>
              <Form.Item name="goalValue" label="Valor meta" rules={[{ required: true }]}>
                <Input style={{ width: "40%" }} />
              </Form.Item>
              <Form.Item name="unitsFactor" label="Factor meta" rules={[{ required: true }]}>
                <Input style={{ width: "25%" }} />
              </Form.Item>
              <Form.Item name="unitsName" label="Unidad medida">
                <SelectUnits />
              </Form.Item>
            </>
          )}
          {currentMonitoring?.supportProductMonitoring &&
            usedFor === MonitoringConfigUsedFor.DevelopmentPlans &&
            isGoalMonitoring() && (
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
            usedFor === MonitoringConfigUsedFor.DevelopmentPlans &&
            isGoalMonitoring() && (
              <Form.Item name="productCatalogId" label="Indicador de Producto">
                <SelectProductCatalog />
              </Form.Item>
            )}
          {usedFor === MonitoringConfigUsedFor.DevelopmentPlans && isGoalMonitoring() && (
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

export { GoalNew };
