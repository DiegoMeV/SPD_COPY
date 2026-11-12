import { useEffect, useMemo, useState } from "react";
import { useStoreState } from "../../../store";
import { useGetPublicPoliticGoalsLazyQuery } from "../../../../graphql/gen/hooks";

const usePublicPoliticGoals = () => {
  const selectedPublicPolitic = useStoreState((state) => state.publicPolitic.selectedPublicPolitic);
  const [searchValue, setSearchValue] = useState("");

  const [getPublicPoliticGoals, { data, loading, error }] = useGetPublicPoliticGoalsLazyQuery({
    variables: {
      publicPoliticId: selectedPublicPolitic?.id as number,
    },
  });

  useEffect(() => {
    if (selectedPublicPolitic) getPublicPoliticGoals();
  }, [selectedPublicPolitic]);

  const onSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.target;
    setSearchValue(value);
  };

  const goalsData = useMemo(() => {
    const containsStr = (text: string | null = "", searchText: string | null = "") =>
      (text ?? "").toLocaleLowerCase().indexOf((searchText ?? "").toLocaleLowerCase()) > -1;
    return data?.getPublicPoliticGoals
      ?.filter(
        (goal) =>
          containsStr(goal.code, searchValue) ||
          containsStr(goal.name, searchValue) ||
          containsStr(goal.indicator, searchValue),
      )
      ?.map((goal) => {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { children, ...goalData } = goal;
        return goalData;
      });
  }, [data, searchValue]);

  return {
    data: goalsData,
    loading,
    error,
    searchValue,
    selectedPublicPolitic,
    setSearchValue,
    onSearchChange,
  };
};

export default usePublicPoliticGoals;
