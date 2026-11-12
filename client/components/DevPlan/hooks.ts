import { useEffect } from "react";
import {
  GetDevPlansDocument,
  useGetDevPlansQuery,
  useDeleteDevPlanMutation,
  useGetDevPlansLazyQuery,
  useCreateDevPlanMutation,
  useGetDevPlanQuery,
  useUpdateDevPlanMutation,
  GetDevPlanByCodeDocument,
} from "../../../graphql/gen/hooks";
import { apolloClient } from "../../lib/apollo";
import { useStoreState, useStoreActions } from "../../store";
import { GetDevPlanByCodeQuery, GetDevPlansQuery } from "../../../graphql/gen/ops";
import { DataNode, DevPlanConfigLevel } from "../../types/devPlan";
import { Form, FormInstance } from "antd";
import { useTable } from "../../hooks/useTable";
import { useRouter } from "next/router";
import dayjs from "dayjs";
import { goalTypeMap } from "../../utils/uiUtils";

type UseDevPlanProps = {
  id?: number | null;
  form?: FormInstance<any>;
};

const useDevPlans = () => {
  const { pagination, sorter, setTotal, handleTableChange, getColumnRender } = useTable({
    pagination: { pageSize: 10 },
    sorter: { field: "endDate", order: "desc" },
  });

  const { loading, data, error } = useGetDevPlansQuery({
    fetchPolicy: "cache-and-network",
  });

  const setDevPlans = useStoreActions((actions) => actions.devPlan.setData);

  useEffect(() => {
    setTotal(data?.getDevPlans?.length ?? 0);
    setDevPlans(data?.getDevPlans);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.getDevPlans]);

  return {
    loading,
    error,
    data: data?.getDevPlans ?? [],
    count: data?.getDevPlans?.length ?? 0,
    pagination,
    sorter,
    setTotal,
    handleTableChange,
    getColumnRender,
  };
};

const useDevPlan = ({ id }: UseDevPlanProps = {}) => {
  const monitoringLevelNumbers = useStoreState((state) => state.devPlan.monitoringLevelNumbers);
  const devPlans = useStoreState((state) => state.devPlan.data);
  const selectedDevPlanId = useStoreState((state) => state.devPlan.selectedDevPlanId);
  const selectedDevPlan = useStoreState((state) => state.devPlan.selectedDevPlan);
  const selectedDevPlanCode = useStoreState((state) => state.devPlan.selectedDevPlanCode);
  const setDevPlans = useStoreActions((actions) => actions.devPlan.setData);
  const setSelectedDevPlanId = useStoreActions((actions) => actions.devPlan.setSelectedDevPlanId);

  const [getDevPlansQuery, { loading, data, error }] = useGetDevPlansLazyQuery({
    fetchPolicy: "cache-first",
  });

  useEffect(() => {
    if (!devPlans) {
      getDevPlansQuery();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [devPlans]);

  useEffect(() => {
    if (data) {
      setDevPlans(data?.getDevPlans);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  const fetchDevPlans = async () => {
    const result = await apolloClient.query<GetDevPlansQuery>({
      query: GetDevPlansDocument,
    });
    if (result) setDevPlans(result?.data?.getDevPlans);
  };

  const getDevPlans = () => {
    return devPlans;
  };

  const getDevPlan = (id: number) => {
    return devPlans?.find((devPlan) => devPlan.id === id);
  };

  const getSelectedDevPlan = () => {
    return selectedDevPlan;
  };

  const getConfigLevel = ({
    level,
    devPlanId,
  }: {
    level: number;
    devPlanId?: number;
  }): DevPlanConfigLevel | undefined => {
    if (devPlanId || selectedDevPlanId) {
      const devPlan = selectedDevPlanId ? getSelectedDevPlan() : getDevPlan(devPlanId as number);
      return devPlan?.config?.levels?.find(
        (devPlanConfigLevel: DevPlanConfigLevel) => devPlanConfigLevel.number === level,
      );
    }
    return undefined;
  };

  const isGoalLevel = (levelNumber?: number): boolean => {
    const monitoringLevels = monitoringLevelNumbers;
    return levelNumber !== undefined && monitoringLevels?.includes(levelNumber);
  };

  const hasParentLevel = (levelNumber: number): boolean => {
    const monitoringLevels = monitoringLevelNumbers;
    return monitoringLevels.includes(levelNumber - 1);
  };

  return {
    loading,
    data: data?.getDevPlans,
    count: data?.getDevPlans?.length ?? 0,
    error,
    selectedDevPlanId,
    selectedDevPlanCode,
    setSelectedDevPlanId,
    getDevPlans,
    getDevPlan,
    getConfigLevel,
    fetchDevPlans,
    isGoalLevel,
    hasParentLevel,
  };
};

const useDeleteDevPlan = () => {
  const [deleteDevPlanMutation, { loading, data, error }] = useDeleteDevPlanMutation({
    refetchQueries: [{ query: GetDevPlansDocument }],
  });
  const { sendNotification } = useStoreActions((actions) => actions.notifications);

  const deleteDevPlan = async (id: number) => {
    try {
      const result = await deleteDevPlanMutation({
        variables: {
          id,
        },
      });
      sendNotification({
        type: "success",
        message: "Plan de desarrollo eliminado",
        description: `Se ha eliminado correctamente el plan de desarrollo código ${result.data?.deleteDevPlan.code}`,
      });
    } catch (e) {
      console.error(e);
    }
  };

  return { deleteDevPlan, loading, data, error };
};

const useCreateDevPlan = () => {
  const router = useRouter();
  const [form] = Form.useForm();

  const { sendNotification } = useStoreActions((actions) => actions.notifications);

  const searchPlanByCode = async (code: string) => {
    const query = await apolloClient.query<GetDevPlanByCodeQuery>({
      query: GetDevPlanByCodeDocument,
      variables: {
        code,
      },
      fetchPolicy: "network-only",
    });
    return query?.data?.getDevPlanByCode;
  };

  const [saveDevPlan, { loading, data, error }] = useCreateDevPlanMutation({
    refetchQueries: [
      {
        query: GetDevPlansDocument,
        fetchPolicy: "network-only",
      },
    ],
  });

  const createDevPlan = async () => {
    const values = form.getFieldsValue();
    try {
      const variables = {
        data: {
          code: values.code,
          name: values.name,
          startDate: values.startEndDates[0],
          endDate: values.startEndDates[1],
          governmentName: values.governmentName,
          governmentStartDate: values.governmentStartEndDates[0],
          governmentEndDate: values.governmentStartEndDates[1],
          config:
            values?.levels?.length && values?.levels?.filter((level: any) => !!level).length
              ? {
                  levels: values.levels?.map(
                    (level: Partial<DevPlanConfigLevel>, index: number) => ({
                      ...level,
                      number: level.number ?? index + 1,
                    }),
                  ),
                }
              : undefined,
          goalActivitySource: values.goalActivitySource,
        },
      };
      const result = await saveDevPlan({ variables });
      sendNotification({
        type: "success",
        message: "Plan de desarrollo creado",
        description: `Se ha creado correctamente el plan de desarrollo código ${result.data?.createDevPlan.code}`,
      });
      router.push("/config/dev-plans/");
    } catch (e) {
      console.error(e);
    }
  };

  return { createDevPlan, searchPlanByCode, form, loading, data, error };
};

const useEditDevPlan = ({ id }: { id: number }) => {
  const router = useRouter();
  const [form] = Form.useForm();
  const { loading, error, data } = useGetDevPlanQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [saveDevPlan, { data: updateData, loading: updateLoading, error: updateError }] =
    useUpdateDevPlanMutation();

  useEffect(() => {
    if (data?.getDevPlan && form) {
      form.setFieldsValue(getFormEditValues());
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.getDevPlan, form]);

  const getFormEditValues = () => {
    const devPlan = data?.getDevPlan;
    const editData = {
      code: devPlan?.code,
      name: devPlan?.name,
      startEndDates: [dayjs(new Date(devPlan?.startDate)), dayjs(new Date(devPlan?.endDate))],
      governmentName: devPlan?.governmentName,
      governmentStartEndDates: [
        dayjs(new Date(devPlan?.governmentStartDate)),
        dayjs(new Date(devPlan?.governmentEndDate)),
      ],
      levels: devPlan?.config?.levels,
      goalActivitySource: devPlan?.goalActivitySource,
    };
    return editData;
  };

  const updateDevPlan = async () => {
    const values = form.getFieldsValue();
    try {
      const variables = {
        data: {
          id,
          code: values.code,
          name: values.name,
          startDate: values.startEndDates[0],
          endDate: values.startEndDates[1],
          governmentName: values.governmentName,
          governmentStartDate: values.governmentStartEndDates[0],
          governmentEndDate: values.governmentStartEndDates[1],
          config:
            values?.levels?.length && values?.levels?.filter((level: any) => !!level).length
              ? {
                  levels: values.levels
                    ?.filter((level: any) => !!level)
                    ?.map((level: Partial<DevPlanConfigLevel>, index: number) => ({
                      ...level,
                      number: level.number ?? index + 1,
                    })),
                }
              : undefined,
          goalActivitySource: values.goalActivitySource,
        },
      };
      const result = await saveDevPlan({ variables });
      sendNotification({
        type: "success",
        message: "Plan de desarrollo editado",
        description: `Se ha editado correctamente el plan de desarrollo código ${result.data?.updateDevPlan.code}`,
      });
      router.push("/config/dev-plans/");
    } catch (e) {
      console.error(e);
    }
  };

  return {
    updateDevPlan,
    getFormEditValues,
    form,
    loading,
    error,
    data: data?.getDevPlan,
    updateLoading,
    updateError,
    updateData,
  };
};

const useDevPlanDetail = (id: number) => {
  const { loading, error, data } = useGetDevPlanQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  const getTree = (levels: Array<DevPlanConfigLevel>): DataNode => {
    if (!levels.length) return {} as DataNode;
    const children = getTree(levels.slice(1));
    return {
      title: `${levels[0].pluralName} ${
        levels[0].goalType ? `(Metas de ${goalTypeMap[levels[0].goalType]?.tag})` : ""
      }`,
      code: "",
      key: `${levels[0].number}`,
      ...(Object.keys(children).length ? { children: [children] } : {}),
    };
  };

  const children = [getTree(data?.getDevPlan?.config?.levels ?? [])];
  const levels: DataNode[] = children
    ? [
        {
          title: `${data?.getDevPlan?.name}`,
          code: "",
          key: "name",
          children: children,
        },
      ]
    : [];

  return {
    loading,
    error,
    data: data?.getDevPlan,
    treeLevels: levels,
  };
};

export {
  useDevPlans,
  useDevPlan,
  useCreateDevPlan,
  useDeleteDevPlan,
  useEditDevPlan,
  useDevPlanDetail,
};
