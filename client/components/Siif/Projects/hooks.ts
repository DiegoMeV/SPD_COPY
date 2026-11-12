import { useEffect, useMemo, useState } from "react";
import {
  GetSiifActividadesDocument,
  SearchProyectosDocument,
  useDeleteSiifActividadMetaAccionesMutation,
  useDeleteSiifActividadMetasMutation,
  useGetActividadesQuery,
  useGetProyectoQuery,
  useGetProyectosForScheduleLazyQuery,
  useGetProyectosForScheduleQuery,
  useGetSiifActividadesQuery,
  useSaveSiifActividadMetaAccionMutation,
  useSaveSiifActividadMetaMutation,
  useSearchProyectosLazyQuery,
  useSearchProyectosQuery,
} from "../../../../graphql/gen/hooks";
import { useTable, UseTableProps } from "../../../hooks/useTable";
import { DEFAULT_PAGE_SIZE } from "../../../const";
import { useStoreActions, useStoreState } from "../../../store";
import { Form, FormInstance } from "antd";
import { ProyectoRecord, ProyectoForScheduleRecord } from "../../../store/models/proyecto";
import { DataNode } from "../../../types/devPlan";
import { useDevPlan } from "../../DevPlan/hooks";
import { GetProyectosForScheduleQueryVariables } from "../../../../graphql/gen/ops";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useCurrentUser } from "../../Users/hooks";

type UseEditMetasProps = {
  nitCompania?: string;
  proyecto?: string;
  codigoAct?: number;
  form?: FormInstance<any>;
};

const useProjects = () => {
  const [form] = Form.useForm();
  const { selectedDevPlanCode } = useDevPlan();
  const { isOperator, isValidator, user } = useCurrentUser();

  const setSearchProyectosQueryVariables = useStoreActions(
    (actions) => actions.proyecto.setSearchProyectoQueryVariables,
  );

  const {
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setTotal,
    handleTableChange,
    setSearch,
    getColumnRender,
    setPagination,
    setFilters,
  } = useTable({
    pagination: { pageSize: 20 },
    sorter: { field: "proyecto", order: "asc" },
    filters: {
      isActive: [true],
      ...(isOperator() || isValidator() ? { entity: [user?.entity?.code] } : {}),
    },
  });

  const getQueryVariables = () => {
    return {
      ...(search?.searchedColumn ? { [search.searchedColumn]: search.searchText } : {}),
      limit: pagination?.pageSize,
      offset: ((pagination?.current ?? 1) - 1) * (pagination?.pageSize ?? DEFAULT_PAGE_SIZE),
      ...(filters?.entity ? { codigosEntPry: filters.entity } : {}),
      ...(selectedDevPlanCode ? { plan: parseInt(selectedDevPlanCode) } : {}),
      sort: sorter,
    };
  };

  useEffect(() => {
    setPagination({ ...pagination, current: 1 });
    setSearchProyectosQueryVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search, selectedDevPlanCode]);

  useEffect(() => {
    setSearchProyectosQueryVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const { loading, data, error, refetch } = useSearchProyectosQuery({
    variables: { data: getQueryVariables() },
    fetchPolicy: "cache-and-network",
  });

  useEffect(() => {
    setTotal(data?.searchProyectos?.count ?? 0);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.searchProyectos?.count]);

  return {
    form,
    loading,
    error,
    data: data?.searchProyectos?.items ?? [],
    count: data?.searchProyectos?.count ?? 0,
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setTotal,
    handleTableChange,
    setSearch,
    getColumnRender,
    setFilters,
    refetch,
  };
};

const useProjectsSchedule = () => {
  const [form] = Form.useForm();
  const { selectedDevPlanCode } = useDevPlan();

  const setSearchProyectosQueryVariables = useStoreActions(
    (actions) => actions.proyecto.setSearchProyectoQueryVariables,
  );
  const { currentMonitoring } = useMonitoringConfig();

  const {
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setTotal,
    handleTableChange,
    setSearch,
    getColumnRender,
    setPagination,
    setFilters,
  } = useTable({
    pagination: { pageSize: 20 },
    sorter: { field: "proyecto", order: "asc" },
    filters: {
      isActive: [true],
    },
  });

  const getQueryVariables = () => {
    return {
      monitoringConfigId: currentMonitoring?.id,
      plan: parseInt(currentMonitoring?.devPlan?.code ?? "0"),
      ...(search?.searchedColumn ? { [search.searchedColumn]: search.searchText } : {}),
      limit: pagination?.pageSize,
      offset: ((pagination?.current ?? 1) - 1) * (pagination?.pageSize ?? DEFAULT_PAGE_SIZE),
      ...(filters?.entity ? { codigosEntPry: filters.entity } : {}),
      ...(selectedDevPlanCode ? { plan: parseInt(selectedDevPlanCode) } : {}),
      sort: sorter,
    };
  };

  useEffect(() => {
    setPagination({ ...pagination, current: 1 });
    setSearchProyectosQueryVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search, selectedDevPlanCode]);

  useEffect(() => {
    setSearchProyectosQueryVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const [queryProyectosForSchedule, { loading, data, error, refetch }] =
    useGetProyectosForScheduleLazyQuery({
      // variables: { data: getQueryVariables() },
      fetchPolicy: "cache-and-network",
    });

  useEffect(() => {
    if (currentMonitoring)
      queryProyectosForSchedule({
        variables: { data: getQueryVariables() } as GetProyectosForScheduleQueryVariables,
      });
  }, [currentMonitoring, pagination?.pageSize, pagination?.current, sorter]);

  useEffect(() => {
    setTotal(data?.getProyectosForSchedule?.count ?? 0);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.getProyectosForSchedule?.count]);

  const projectsData = useMemo(() => {
    return (
      data?.getProyectosForSchedule?.items?.map((project) => {
        let totalResources = 0;
        project?.actividades?.forEach((activity) => {
          activity?.goal?.schedule?.forEach((schedule) =>
            schedule?.resources?.forEach((resource) => {
              totalResources += resource?.resourcesTotal ?? 0;
            }),
          );
        });
        return {
          ...project,
          totalResources,
        };
      }) ?? []
    );
  }, [data]);

  return {
    form,
    loading,
    error,
    data: projectsData,
    count: data?.getProyectosForSchedule?.count ?? 0,
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setTotal,
    handleTableChange,
    setSearch,
    getColumnRender,
    setFilters,
    refetch,
  };
};

const useEditActivity = ({ nitCompania, proyecto, codigoAct, form }: UseEditMetasProps) => {
  const searchProyectosQueryVariables = useStoreState(
    (state) => state.proyecto.searchProyectosQueryVariables,
  );
  const { sendNotification } = useStoreActions((actions) => actions.notifications);

  const [
    saveSiifActividadMetasMutation,
    { loading: updateLoading, error: updateError, data: updateData },
  ] = useSaveSiifActividadMetaMutation({
    refetchQueries: [
      {
        query: SearchProyectosDocument,
        variables: { data: searchProyectosQueryVariables },
      },
    ],
  });

  const [
    saveSiifActividadMetaAccionesMutation,
    { loading: updateActionLoading, error: updateActionError, data: updateActionData },
  ] = useSaveSiifActividadMetaAccionMutation({
    refetchQueries: [
      {
        query: SearchProyectosDocument,
        variables: { data: searchProyectosQueryVariables },
      },
    ],
  });

  const [
    deleteSiifActividadMetasMutation,
    { loading: deleteLoading, error: deleteError, data: deleteData },
  ] = useDeleteSiifActividadMetasMutation({
    refetchQueries: [
      {
        query: SearchProyectosDocument,
        variables: { data: searchProyectosQueryVariables },
      },
    ],
  });

  const [
    deleteSiifActividadMetaAccionesMutation,
    { loading: deleteActionsLoading, error: deleteActionsError, data: deleteActionsData },
  ] = useDeleteSiifActividadMetaAccionesMutation({
    refetchQueries: [
      {
        query: SearchProyectosDocument,
        variables: { data: searchProyectosQueryVariables },
      },
    ],
  });

  // const getFormEditValues = () => {
  //   return {
  //     docNumber: currentUser?.docNumber,
  //     email: currentUser?.email,
  //     firstName: currentUser?.firstName,
  //     lastName: currentUser?.lastName,
  //     entityId: currentUser?.entityId,
  //     phone: currentUser?.phone,
  //     role: currentUser?.role as SpdRole,
  //     isActive: currentUser?.isActive,
  //   };
  // }

  const saveSiifActividadMetas = async (values: Record<string, any>) => {
    try {
      if (values.goals?.length && values.goals?.[0]) {
        const variables = {
          data: values.goals.map((goal: any) => ({
            id: goal.id,
            goalId: goal.goalId,
            weighting: goal.weighting,
            nitCompania,
            proyecto,
            codigoAct,
          })),
        };
        const result = await saveSiifActividadMetasMutation({
          variables,
          refetchQueries: [
            {
              query: GetSiifActividadesDocument,
              variables: {
                proyecto,
              },
            },
          ],
        });
        if (result?.data?.saveSiifActividadMeta) {
          sendNotification({
            type: "success",
            message: "Actividad actualizada",
            description: `Se ha actualizado correctamente la actividad`,
          });
        }
      } else {
        const variables = {
          data: {
            nitCompania: nitCompania as string,
            proyecto: proyecto as string,
            codigoAct: codigoAct as number,
          },
        };
        const result = await deleteSiifActividadMetasMutation({
          variables,
          refetchQueries: [
            {
              query: GetSiifActividadesDocument,
              variables: {
                proyecto,
              },
            },
          ],
        });
        if (result?.data?.deleteSiifActividadMetas) {
          sendNotification({
            type: "success",
            message: "Actividad actualizada",
            description: `Se ha actualizado correctamente la actividad`,
          });
        }
      }
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Editando actividad",
        description: `${e}`,
      });
    }
  };

  const saveSiifActividadMetaAcciones = async (
    actividadMetaId: number,
    values: Record<string, any>,
  ) => {
    try {
      if (values.actions?.length && values.actions?.[0]) {
        const variables = {
          data: values.actions.map((action: any) => ({
            id: action.id,
            descripcion: action.descripcion,
            actividadMetaId,
          })),
        };
        const result = await saveSiifActividadMetaAccionesMutation({
          variables,
          refetchQueries: [
            {
              query: GetSiifActividadesDocument,
              variables: {
                proyecto,
              },
            },
          ],
        });
        if (result?.data?.saveSiifActividadMetaAccion) {
          sendNotification({
            type: "success",
            message: "Acciones guardadas",
            description: `Se han guardado correctamente las acciones`,
          });
        }
      } else {
        const variables = {
          data: {
            actividadMetaId,
          },
        };
        const result = await deleteSiifActividadMetaAccionesMutation({
          variables,
          refetchQueries: [
            {
              query: GetSiifActividadesDocument,
              variables: {
                proyecto,
              },
            },
          ],
        });
        if (result?.data?.deleteSiifActividadMetaAcciones) {
          sendNotification({
            type: "success",
            message: "Acciones guardadas",
            description: `Se han guardado correctamente las acciones`,
          });
        }
      }
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Editando acciones",
        description: `${e}`,
      });
    }
  };

  return {
    updateLoading,
    updateError,
    updateData: updateData?.saveSiifActividadMeta,
    updateActionLoading,
    updateActionError,
    updateActionData: updateActionData?.saveSiifActividadMetaAccion,
    saveSiifActividadMetas,
    saveSiifActividadMetaAcciones,
  };
};

const useActivities = ({ project }: { project: string }) => {
  const { data, loading, error } = useGetActividadesQuery({
    variables: {
      proyecto: project,
    },
  });

  return {
    data: data?.getActividades ?? [],
    count: data?.getActividades?.length ?? 0,
    loading,
    error,
  };
};

const useProyectoDetail = (projectNumber: string) => {
  const [tree, setTreeLevels] = useState<DataNode[]>([]);
  const [treeKeys, setTreeKeys] = useState<string[]>([]);
  const { data, loading, error } = useGetProyectoQuery({
    variables: {
      codigo: projectNumber,
    },
    fetchPolicy: "cache-and-network",
  });

  useEffect(() => {
    if (data?.getProyecto) {
      const proyecto = data.getProyecto as ProyectoRecord;
      const tree = [
        {
          title: proyecto.devPlan?.name ?? "",
          code: `${proyecto.plan}`,
          key: `${proyecto.plan}`,
          children: [
            {
              title: proyecto.nombreEje,
              code: `${proyecto.eje}`,
              key: `${proyecto.plan}.${proyecto.eje}`,
              children: [
                {
                  title: proyecto.nombreSector,
                  code: `${proyecto.sector}`,
                  key: `${proyecto.plan}.${proyecto.eje}.${proyecto.sector}`,
                  children: [
                    {
                      title: proyecto.nombrePrograma,
                      code: `${proyecto.programa}`,
                      key: `${proyecto.plan}.${proyecto.eje}.${proyecto.sector}.${proyecto.programa}`,
                    },
                  ],
                },
              ],
            },
          ],
        },
      ];
      const treeKeys = [
        `${proyecto.plan}`,
        `${proyecto.plan}.${proyecto.eje}`,
        `${proyecto.plan}.${proyecto.eje}.${proyecto.sector}`,
        `${proyecto.plan}.${proyecto.eje}.${proyecto.sector}.${proyecto.programa}`,
      ];
      setTreeLevels(tree);
      setTreeKeys(treeKeys);
    }
  }, [data]);

  const proyecto = data?.getProyecto as ProyectoRecord;

  return {
    loading,
    error,
    data: proyecto,
    treeLevels: tree,
    treeKeys,
  };
};

export { useProjects, useActivities, useEditActivity, useProyectoDetail, useProjectsSchedule };

export type { ProyectoRecord, ProyectoForScheduleRecord };
