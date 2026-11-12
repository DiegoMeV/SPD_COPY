import { FormInstance } from "antd";
import {
  AccumulationType,
  GoalType,
  MonitoringConfigUsedFor,
} from "../../../../graphql/gen/schema";
import { useStoreActions, useStoreState } from "../../../store";
import { useState } from "react";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import {
  GetGoalsDocument,
  GetPublicPoliticGoalsDocument,
  SearchGoalsDocument,
  useCreateGoalMutation,
} from "../../../../graphql/gen/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import useGoal from "./useGoal";

export type UseCreateGoalProps = {
  form: FormInstance<any>;
  usedFor?: MonitoringConfigUsedFor;
  goalTypes?: GoalType[];
};

const useCreateGoal = ({
  form,
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
  goalTypes,
}: UseCreateGoalProps) => {
  const selectedPublicPolitic = useStoreState((state) => state.publicPolitic.selectedPublicPolitic);
  const { selectedNodeId, currentGoalType } = useDevPlanTree();
  const { currentGoal, setCurrentGoal } = useGoal();
  const [open, setOpen] = useState(false);
  const [selectedEntityId, setSelectedEntityId] = useState<number | undefined>();
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [createGoalMutation, { loading, data, error }] = useCreateGoalMutation({
    refetchQueries:
      usedFor === MonitoringConfigUsedFor.DevelopmentPlans
        ? [
            { query: GetGoalsDocument, variables: { devPlanLevelId: selectedNodeId } },
            "SearchGoals",
            "GetDevPlanLevelsTree",
          ]
        : [
            {
              query: GetPublicPoliticGoalsDocument,
              variables: { publicPoliticId: selectedPublicPolitic?.id },
            },
          ],
  });
  const { isActionPlanMonitoring, isGoalMonitoring, isActionPlanActivityMonitoring } =
    useMonitoring({
      goalTypes,
    });

  const getGoalType = (): GoalType => {
    if (usedFor === MonitoringConfigUsedFor.PublicPolitics) return GoalType.PublicPolitic;
    else {
      if (isActionPlanMonitoring()) return GoalType.ActionPlan;
      if (isActionPlanActivityMonitoring()) return GoalType.ActionPlanActivity;
      else return currentGoalType?.[0] as GoalType;
    }
  };

  const getGoalLabel = () => {
    const goalType = getGoalType();
    if (goalType === GoalType.ActionPlan) return "Plan de acción";
    if (goalType === GoalType.ActionPlanActivity) return "Meta de plan de acción";
    if (goalType === GoalType.PublicPolitic) return "Política Pública";
    return "Meta";
  };

  const getGoalGenre = () => {
    const goalType = getGoalType();
    if (goalType === GoalType.ActionPlan) return "M";
    if (goalType === GoalType.ActionPlanActivity) return "F";
    if (goalType === GoalType.PublicPolitic) return "F";
    return "M";
  };

  const createGoal = async () => {
    const values: Record<string, string> = form.getFieldsValue();

    if (currentGoalType || selectedPublicPolitic || isActionPlanMonitoring()) {
      try {
        const variables = {
          data: {
            ...(usedFor === MonitoringConfigUsedFor.DevelopmentPlans
              ? { devPlanLevelId: selectedNodeId }
              : {}),
            code: values.code,
            name: values.name,
            entityId: parseInt(values.entityId),
            ...(usedFor === MonitoringConfigUsedFor.PublicPolitics
              ? { extraEntityIds: values.extraEntityIds ?? undefined }
              : {}),
            goalType: getGoalType(),
            parentGoalId: parseInt(values.parentGoalId),
            indicator: values.indicator,
            description: values.description,
            accumulationType: values.accumulationType
              ? (values.accumulationType as AccumulationType)
              : AccumulationType.Accumulated,
            weighting: parseFloat(values.weighting),
            baseValue: parseFloat(values.baseValue),
            goalValue: parseFloat(values.goalValue),
            unitsFactor: values.unitsFactor ? parseFloat(values.unitsFactor) : undefined,
            unitsName: values.unitsName,
            odsIds: values.odsIds ?? [],
            piBaseValue: parseFloat(values.piBaseValue),
            piGoalValue: parseFloat(values.piGoalValue),
            piUnitsFactor: parseFloat(values.piUnitsFactor),
            piUnitsName: values.piUnitsName,
            publicPoliticId:
              usedFor === MonitoringConfigUsedFor.PublicPolitics
                ? selectedPublicPolitic?.id
                : undefined,
            publicPoliticComponentId: values.publicPoliticComponentId
              ? parseInt(values.publicPoliticComponentId)
              : undefined,
            peacePoliticId: parseInt(values.peacePoliticId),
            victimsPoliticId: parseInt(values.victimsPoliticId),
            productCatalogId: parseInt(values.productCatalogId),
            formula: values.formula,
            macroProjectId: values.macroProjectId ? parseInt(values.macroProjectId) : undefined,
            projectCode: values.projectCode,
            ...(isActionPlanActivityMonitoring()
              ? {
                  activityId: parseInt(values.activityId),
                  parentGoalId: currentGoal?.id,
                  entityId: currentGoal?.entityId,
                  projectCode: currentGoal?.projectCode,
                }
              : {}),
          },
        };
        const result = await createGoalMutation({ variables });
        sendNotification({
          type: "success",
          message: `${getGoalLabel()} ${getGoalGenre() === "M" ? "creado" : "creada"}`,
          description: `Se ha creado correctamente ${getGoalGenre() === "M" ? "el" : "la"} ${getGoalLabel()} ${result.data?.createGoal?.code}`,
        });
        form.resetFields();
        setOpen(false);
        // For action plans, add the new goal to the children of the current goal
        if (isActionPlanActivityMonitoring() && currentGoal && result.data?.createGoal) {
          setCurrentGoal({
            ...currentGoal,
            children: [...(currentGoal?.children ?? []), result.data?.createGoal],
          });
        }
      } catch (e) {
        sendNotification({
          type: "error",
          message: `Creando ${getGoalGenre() === "M" ? "el" : "la"} ${getGoalLabel()}`,
          description: `${e}`,
        });
      }
    }
  };

  const onValuesChange = (values: any) => {
    if (Object.hasOwn(values, "entityId")) {
      const entityId = values.entityId ? parseInt(values.entityId) : undefined;
      setSelectedEntityId(entityId);
    }
  };

  return {
    open,
    loading,
    data,
    error,
    selectedEntityId,
    selectedPublicPolitic,
    setOpen,
    createGoal,
    onValuesChange,
  };
};

export default useCreateGoal;
