import { useState, useEffect } from "react";
import { GetGoalsQuery } from "../../../../graphql/gen/ops";
import { GetGoalsDocument } from "../../../../graphql/gen/hooks";
import { apolloClient } from "../../../lib/apollo";

export type UseGetGoalsProps = {
  devPlanLevelId: number;
};

const useGetGoals = async ({ devPlanLevelId }: UseGetGoalsProps) => {
  const [loading, setLoading] = useState<boolean>(false);
  const [data, setData] = useState<GetGoalsQuery["getGoals"]>();

  useEffect(() => {
    const getGoals = async () => {
      setLoading(true);
      const query = await apolloClient.query<GetGoalsQuery>({
        query: GetGoalsDocument,
        variables: {
          devPlanLevelId,
        },
      });
      setLoading(false);
      setData(query?.data?.getGoals ?? []);
    };

    if (devPlanLevelId) {
      getGoals();
    }
  }, [devPlanLevelId]);

  return { loading, data };
};

export default useGetGoals;
