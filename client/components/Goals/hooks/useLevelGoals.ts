import { useMemo, useState } from "react";
import { useStoreState } from "../../../store";
import { useGetGoalsQuery, useSearchGoalsQuery } from "../../../../graphql/gen/hooks";
import { GoalType } from "../../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";

const useLevelGoals = ({ goalTypes }: { goalTypes?: GoalType[] } = {}) => {
  const selectedNode = useStoreState((state) => state.devPlanTree.selectedNode);
  const { currentMonitoring } = useMonitoringConfig();
  const { isActionPlanMonitoring } = useMonitoring({ goalTypes });
  const [searchValue, setSearchValue] = useState("");

  const { data, loading, error } = useSearchGoalsQuery({
    variables: {
      data: {
        devPlanLevelId: parseInt((selectedNode?.key as string) ?? "-1"),
        goalTypes,
        monitoringConfigId: currentMonitoring?.id,
      },
    },
  });

  const onSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.target;
    setSearchValue(value);
  };

  const goalsData = useMemo(() => {
    const containsStr = (text: string | null = "", searchText: string | null = "") =>
      (text ?? "").toLocaleLowerCase().indexOf((searchText ?? "").toLocaleLowerCase()) > -1;
    return data?.searchGoals?.items
      ?.filter(
        (goal) =>
          containsStr(goal.code, searchValue) ||
          containsStr(goal.name, searchValue) ||
          containsStr(goal.indicator, searchValue),
      )
      ?.map((goal) => {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { children, ...goalData } = goal;
        return {
          ...goalData,
          ...(children?.length ? { children } : {}),
        };
      });
  }, [data, searchValue]);

  return { data: goalsData, loading, error, searchValue, setSearchValue, onSearchChange };
};

export default useLevelGoals;
