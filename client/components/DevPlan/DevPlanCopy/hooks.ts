import { useMemo } from "react";
import { useGetPlanDesarrolloByCodeQuery } from "../../../../graphql/gen/hooks";
import { useStoreState, useStoreActions } from "../../../store";

const useCopyDevPlan = () => {
  const selectedDevPlanCode = useStoreState((state) => state.devPlan.selectedDevPlanCode);
  const selectedDevPlanId = useStoreState((state) => state.devPlan.selectedDevPlanId);
  const selectedDevPlan = useStoreState((state) => state.devPlan.selectedDevPlan);
  const setSelectedDevPlanId = useStoreActions((actions) => actions.devPlan.setSelectedDevPlanId);
  const selectedPlanDesarrolloCode = useStoreState(
    (state) => state.planDesarrollo.selectedPlanDesarrolloCode,
  );
  const selectedPlanDesarrollo = useStoreState(
    (state) => state.planDesarrollo.selectedPlanDesarrollo,
  );
  const setSelectedPlanDesarrolloCode = useStoreActions(
    (actions) => actions.planDesarrollo.setSelectedDevPlanCode,
  );

  return {
    selectedDevPlanCode,
    selectedDevPlan,
    selectedDevPlanId,
    setSelectedDevPlanId,
    selectedPlanDesarrolloCode,
    selectedPlanDesarrollo,
    setSelectedPlanDesarrolloCode,
  };
};

const usePreviewPlanDesarrollo = ({ code }: { code: string }) => {
  const { data, loading, error } = useGetPlanDesarrolloByCodeQuery({
    variables: {
      code,
    },
  });

  const treeData = useMemo(() => {
    if (data?.getPlanDesarrolloByCode) {
      return [
        {
          id: data.getPlanDesarrolloByCode.id ?? 0,
          name: data.getPlanDesarrolloByCode.nombre,
          code: `${data.getPlanDesarrolloByCode.plan}`,
          key: `${data.getPlanDesarrolloByCode.plan}`,
          goalCount: [],
          children: (data?.getPlanDesarrolloByCode?.ejes ?? []).map((eje) => ({
            id: eje.id ?? 0,
            name: eje.nombre,
            code: `${eje.codigo ?? eje.eje}`,
            key: `${eje.eje}`,
            goalCount: [],
            children: (eje?.sectores ?? []).map((sector) => ({
              id: sector.id ?? 0,
              name: sector.nombre,
              code: `${sector.codigo ?? sector.sector}`,
              key: `${sector.sector}`,
              goalCount: [],
              children: (sector?.programas ?? []).map((programa) => ({
                id: programa.id ?? 0,
                name: programa.nombre,
                code: `${programa.codigo ?? programa.programa}`,
                key: `${programa.programa}`,
                goalCount: [],
                children: (programa?.subprogramas ?? []).map((subprograma) => ({
                  id: subprograma.id ?? 0,
                  name: subprograma.nombre,
                  code: `${subprograma.codigo ?? subprograma.subprograma}`,
                  key: `${subprograma.subprograma}`,
                  goalCount: [],
                })),
              })),
            })),
          })),
        },
      ];
    }
    return [];
  }, [data?.getPlanDesarrolloByCode]);

  return { data: treeData, loading, error };
};

export { useCopyDevPlan, usePreviewPlanDesarrollo };
