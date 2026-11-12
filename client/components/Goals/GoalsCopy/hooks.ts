import { useGetGoalsToCopyFromSiifQuery } from "../../../../graphql/gen/hooks";
import { VSpdMetaFragment } from "../../../../graphql/gen/ops";
import { useTable } from "../../../hooks/useTable";
import { useStoreState, useStoreActions } from "../../../store";
import { ColumnsType } from "antd/lib/table";

const useCopyGoals = () => {
  const selectedDevPlanCode = useStoreState((state) => state.devPlan.selectedDevPlanCode);
  const selectedDevPlanId = useStoreState((state) => state.devPlan.selectedDevPlanId);
  const selectedDevPlan = useStoreState((state) => state.devPlan.selectedDevPlan);
  const setSelectedDevPlanId = useStoreActions((actions) => actions.devPlan.setSelectedDevPlanId);

  return {
    selectedDevPlanCode,
    selectedDevPlan,
    selectedDevPlanId,
    setSelectedDevPlanId,
  };
};

const useCopyGoalsPreview = ({ devPlanId }: { devPlanId: number }) => {
  const { data, loading, error } = useGetGoalsToCopyFromSiifQuery({
    variables: {
      devPlanId,
    },
    fetchPolicy: "network-only",
  });

  const { getColumnRender, handleTableChange, pagination } = useTable();

  const columns: ColumnsType<VSpdMetaFragment> = [
    getColumnRender("codigo", "Código"),
    getColumnRender("nombre", "Nombre"),
  ];

  return {
    data: data?.getGoalsToCopyFromSIIF,
    loading,
    error,
    columns,
    handleTableChange,
    pagination,
  };
};

export { useCopyGoals, useCopyGoalsPreview };
