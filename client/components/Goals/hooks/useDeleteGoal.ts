import {
  GetGoalsDocument,
  GetPublicPoliticGoalsDocument,
  useDeleteGoalMutation,
} from "../../../../graphql/gen/hooks";
import { MonitoringConfigUsedFor } from "../../../../graphql/gen/schema";
import { useStoreState } from "../../../store";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
export type UseDeleteGoalProps = {
  usedFor?: MonitoringConfigUsedFor;
};

const useDeleteGoal = (props?: UseDeleteGoalProps) => {
  const { usedFor } = props ?? { usedFor: MonitoringConfigUsedFor.DevelopmentPlans };
  const { selectedNodeId } = useDevPlanTree();
  const selectedPublicPolitic = useStoreState((state) => state.publicPolitic.selectedPublicPolitic);

  const [deleteGoalMutation, { loading, data, error }] = useDeleteGoalMutation({
    refetchQueries: [
      usedFor === MonitoringConfigUsedFor.DevelopmentPlans
        ? { query: GetGoalsDocument, variables: { devPlanLevelId: selectedNodeId } }
        : {
            query: GetPublicPoliticGoalsDocument,
            variables: { publicPoliticId: selectedPublicPolitic?.id },
          },
    ],
  });
  const deleteGoal = async (id: number) => {
    const result = await deleteGoalMutation({
      variables: {
        id,
      },
    });
    return result;
  };

  return { deleteGoal, loading, data, error };
};

export default useDeleteGoal;
