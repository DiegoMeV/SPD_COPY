import { useGetGoalQuery } from "../../../../graphql/gen/hooks";

const useGoalDetail = (id: number) => {
  const { loading, error, data } = useGetGoalQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  return {
    loading,
    error,
    data: data?.getGoal,
  };
};

export default useGoalDetail;
