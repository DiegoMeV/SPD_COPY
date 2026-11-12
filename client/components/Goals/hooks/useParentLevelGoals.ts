import { useGetParentLevelGoalsQuery } from "../../../../graphql/gen/hooks";
import { useStoreState } from "../../../store";

const useParentLevelGoals = () => {
  const selectedNode = useStoreState((state) => state.devPlanTree.selectedNode);

  const { data, loading, error } = useGetParentLevelGoalsQuery({
    variables: {
      devPlanLevelId: parseInt((selectedNode?.key as string) ?? "-1"),
    },
  });

  return { data: data?.getParentLevelGoals, loading, error };
};

export default useParentLevelGoals;
