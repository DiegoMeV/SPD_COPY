import { useEffect, useState } from "react";
import { useStoreActions, useStoreState } from "../../../store";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import {
  GetGoalsDocument,
  GetPublicPoliticGoalsDocument,
  useUpdateGoalMutation,
} from "../../../../graphql/gen/hooks";
import { AccumulationType, MonitoringConfigUsedFor } from "../../../../graphql/gen/schema";
import { FormInstance } from "antd";

export type UseEditGoalProps = {
  id: number;
  form: FormInstance<any>;
  usedFor?: MonitoringConfigUsedFor;
};

const useEditGoal = ({ id, form, usedFor }: UseEditGoalProps) => {
  const selectedPublicPolitic = useStoreState((state) => state.publicPolitic.selectedPublicPolitic);
  const { selectedNodeId } = useDevPlanTree();
  const [selectedEntityId, setSelectedEntityId] = useState<number | undefined>();
  const currentGoal = useStoreState((state) => state.goal.currentGoal);
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);
  const [open, setOpen] = useState(false);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [updateGoalMutation, { loading: updateLoading, error: updateError, data: updateData }] =
    useUpdateGoalMutation({
      refetchQueries: [
        usedFor === MonitoringConfigUsedFor.DevelopmentPlans
          ? { query: GetGoalsDocument, variables: { devPlanLevelId: selectedNodeId } }
          : {
              query: GetPublicPoliticGoalsDocument,
              variables: { publicPoliticId: selectedPublicPolitic?.id },
            },
      ],
    });

  useEffect(() => {
    if (currentGoal && form) {
      form.setFieldsValue(getFormEditValues());
      onValuesChange(currentGoal);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentGoal, form]);

  const getFormEditValues = () => {
    return {
      ...currentGoal,
    };
  };

  const updateGoal = async () => {
    const values: Record<string, string> = form.getFieldsValue();
    try {
      const variables = {
        data: {
          id,
          ...(usedFor === MonitoringConfigUsedFor.DevelopmentPlans
            ? { devPlanLevelId: selectedNodeId }
            : {}),
          code: values.code,
          name: values.name,
          entityId: parseInt(values.entityId),
          ...(usedFor === MonitoringConfigUsedFor.PublicPolitics
            ? { extraEntityIds: values.extraEntityIds ?? undefined }
            : {}),
          parentGoalId: parseInt(values.parentGoalId),
          indicator: values.indicator,
          description: values.description,
          accumulationType: values.accumulationType as AccumulationType,
          weighting: parseFloat(values.weighting),
          baseValue: parseFloat(values.baseValue),
          goalValue: parseFloat(values.goalValue),
          unitsFactor: parseFloat(values.unitsFactor),
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
        },
      };
      const result = await updateGoalMutation({ variables });
      sendNotification({
        type: "success",
        message: `${
          usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? "Meta" : "Acción"
        } actualizada`,
        description: `Se ha actualizado correctamente la ${
          usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? "meta" : "acción"
        } ${result.data?.updateGoal?.code}`,
      });
      setOpen(false);
    } catch (e) {
      sendNotification({
        type: "error",
        message: `Actualizando la ${
          usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? "meta" : "acción"
        }`,
        description: `${e}`,
      });
    } finally {
      setOpen(false);
    }
  };

  const onValuesChange = (values: any) => {
    if (Object.hasOwn(values, "entityId")) {
      const entityId = values.entityId ? parseInt(values.entityId) : undefined;
      setSelectedEntityId(entityId);
    }
  };

  return {
    updateGoal,
    getFormEditValues,
    setOpen,
    onValuesChange,
    setCurrentGoal,
    open,
    currentGoal,
    updateLoading,
    updateError,
    updateData: updateData?.updateGoal,
    selectedEntityId,
    selectedPublicPolitic,
  };
};

export default useEditGoal;
