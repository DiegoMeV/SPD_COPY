import { useEffect } from "react";
import { useStoreActions } from "../../../store";
import { useGetPlanesDesarrolloQuery } from "../../../../graphql/gen/hooks";

const usePlanesDesarrollo = () => {
  const { loading, data, error } = useGetPlanesDesarrolloQuery({
    fetchPolicy: "cache-and-network",
  });

  const setPlanesDesarrollo = useStoreActions((actions) => actions.planDesarrollo.setData);

  useEffect(() => {
    setPlanesDesarrollo(data?.getPlanesDesarrollo ?? []);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.getPlanesDesarrollo]);

  return {
    loading,
    error,
    data: data?.getPlanesDesarrollo ?? [],
    count: data?.getPlanesDesarrollo?.length ?? 0,
  };
};

export { usePlanesDesarrollo };
