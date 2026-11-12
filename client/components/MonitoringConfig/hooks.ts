import { useEffect } from "react";
import {
  GetMonitoringConfigsDocument,
  useCreateMonitoringConfigMutation,
  useGetActiveMonitoringConfigQuery,
  useGetMonitoringConfigQuery,
  useGetMonitoringConfigsLazyQuery,
  useUpdateMonitoringConfigMutation,
} from "../../../graphql/gen/hooks";
import { useStoreState, useStoreActions } from "../../store";
import { Form, FormInstance } from "antd";
import { MonitoringConfigUsedFor, SpentDoc } from "../../../graphql/gen/schema";
import { useRouter } from "next/router";
import { ColorsConfigItem, MonitoringConfig } from "../../types/monitoringConfig";
import dayjs from "dayjs";

type UseMonitoringConfigProps = {
  id?: number;
  usedFor?: MonitoringConfigUsedFor;
  form?: FormInstance<any>;
};

type UseCreateMonitoringConfig = {
  usedFor?: MonitoringConfigUsedFor;
};

const useMonitoringConfigs = ({
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
}: UseMonitoringConfigProps = {}) => {
  const monitoringConfigs = useStoreState((state) => state.monitoringConfig.monitoringConfigs);
  const setMonitoringConfigs = useStoreActions(
    (actions) => actions.monitoringConfig.setMonitoringConfigs,
  );

  const [fetchMonitoringConfigs, { loading, data, error }] = useGetMonitoringConfigsLazyQuery({
    variables: { data: { usedFor } },
    fetchPolicy: "cache-and-network",
  });

  useEffect(() => {
    if (!monitoringConfigs?.length) {
      fetchMonitoringConfigs();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [monitoringConfigs]);

  useEffect(() => {
    setMonitoringConfigs(data?.getMonitoringConfigs ?? []);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  const getMonitoringConfigs = () => {
    return monitoringConfigs;
  };

  return {
    loading: loading,
    data: monitoringConfigs,
    error,
    getMonitoringConfigs,
  };
};

const useMonitoringConfig = ({
  id,
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
}: UseMonitoringConfigProps = {}) => {
  const { data: monitoringConfigs } = useMonitoringConfigs({ usedFor });
  const activeMonitoring = useStoreState((state) => state.monitoringConfig.activeMonitoring);
  const setActiveMonitoring = useStoreActions(
    (state) => state.monitoringConfig.setActiveMonitoring,
  );
  const selectedMonitoringConfigId = useStoreState(
    (state) => state.monitoringConfig.selectedMonitoringConfigId,
  );
  const selectedMonitoringConfig = useStoreState(
    (state) => state.monitoringConfig.selectedMonitoringConfig,
  );
  const setSelectedMonitoringConfigId = useStoreActions(
    (actions) => actions.monitoringConfig.setSelectedMonitoringConfigId,
  );
  const isSgpDiscriminatedExpanded = useStoreState(
    (state) => state.monitoringConfig.sgpDiscriminatedExpanded,
  );
  const toggleIsSgpDiscriminatedExpanded = useStoreActions(
    (actions) => actions.monitoringConfig.toggleIsSgpDiscriminatedExpanded,
  );

  useEffect(() => {
    if (monitoringConfigs) {
      const activeMonitoringConfig = monitoringConfigs?.find(
        (monitoringConfig) => monitoringConfig.isActive,
      );
      if (activeMonitoringConfig) {
        setActiveMonitoring(activeMonitoringConfig);
      }
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [monitoringConfigs]);

  const getMonitoringConfig = (id: number) => {
    return monitoringConfigs?.find((monitoringConfig) => monitoringConfig.id === id);
  };

  const isDateEnabled = (monitoringConfig?: MonitoringConfig, datesObject?: string): boolean => {
    const monitoring = monitoringConfig ?? selectedMonitoringConfig ?? activeMonitoring;
    if (!monitoring) return false;
    const dates = monitoring.datesConfig[datesObject ?? "scheduling"] ?? [];
    const [startDate, endDate] = dates?.map((date: string) => new Date(date)) ?? [];
    const currentDate = new Date();

    return currentDate >= startDate && currentDate <= endDate;
  };

  const isScheduleDateEnabled = (monitoringConfig?: MonitoringConfig): boolean => {
    return isDateEnabled(
      monitoringConfig ?? selectedMonitoringConfig ?? activeMonitoring,
      "scheduling",
    );
  };

  const isReportDateEnabled = (monitoringConfig?: MonitoringConfig): boolean => {
    return isDateEnabled(
      monitoringConfig ?? selectedMonitoringConfig ?? activeMonitoring,
      "reporting",
    );
  };

  const isValidateDateEnabled = (monitoringConfig?: MonitoringConfig): boolean => {
    return isDateEnabled(
      monitoringConfig ?? selectedMonitoringConfig ?? activeMonitoring,
      "validating",
    );
  };

  const isReviewDateEnabled = (monitoringConfig?: MonitoringConfig): boolean => {
    return isDateEnabled(
      monitoringConfig ?? selectedMonitoringConfig ?? activeMonitoring,
      "reviewing",
    );
  };

  return {
    selectedMonitoringConfigId,
    setSelectedMonitoringConfigId,
    setActiveMonitoring,
    selectedMonitoringConfig: selectedMonitoringConfig,
    activeMonitoring,
    activeMonitoringConfig: activeMonitoring,
    isSgpDiscriminatedExpanded,
    getMonitoringConfig,
    toggleIsSgpDiscriminatedExpanded,
    currentMonitoring: selectedMonitoringConfig ?? activeMonitoring,
    currentMonitoringConfig: selectedMonitoringConfig ?? activeMonitoring,
    isScheduleDateEnabled,
    isReportDateEnabled,
    isValidateDateEnabled,
    isReviewDateEnabled,
  };
};

const useActiveMonitoring = (usedFor = MonitoringConfigUsedFor.DevelopmentPlans) => {
  const setActiveMonitoringConfig = useStoreActions(
    (actions) => actions.monitoringConfig.setActiveMonitoring,
  );
  const { data, loading, error } = useGetActiveMonitoringConfigQuery({
    variables: {
      data: {
        usedFor,
      },
    },
  });

  useEffect(() => {
    if (data) {
      setActiveMonitoringConfig(data?.getActiveMonitoringConfig ?? undefined);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  return { data: data?.getActiveMonitoringConfig, loading, error };
};

const useCreateMonitoringConfig = (props?: UseCreateMonitoringConfig) => {
  const router = useRouter();
  const [form] = Form.useForm();
  const { usedFor = MonitoringConfigUsedFor.DevelopmentPlans } = props ?? {};

  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [saveMonitoringConfig, { loading, data, error }] = useCreateMonitoringConfigMutation({
    refetchQueries: [
      {
        query: GetMonitoringConfigsDocument,
        variables: { data: { usedFor } },
        fetchPolicy: "network-only",
      },
    ],
  });

  useEffect(() => {
    if (form) {
      form.setFieldsValue({ isActive: true, spentDocs: [SpentDoc.Obligation] });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [form]);

  const createMonitoringConfig = async () => {
    const values = form.getFieldsValue();
    try {
      const colorsConfig = values.colorsConfig?.filter((config: any) => !!config) ?? [];
      const variables = {
        data: {
          usedFor,
          ...(usedFor === MonitoringConfigUsedFor.DevelopmentPlans
            ? {
                devPlanId: parseInt(values.devPlanId),
                spentDocs: values.spentDocs,
                weightingType: values.weightingType,
                monitoringResourcesOrigin: values.monitoringResourcesOrigin,
                supportProductMonitoring: values.supportProductMonitoring,
                sgpDiscriminated: values.sgpDiscriminated,
                copyGoals: values.copyGoals,
              }
            : {}),
          period: parseInt(values.period),
          subperiod: parseInt(values.subperiod),
          // TODO: Este debe ser un campo del formulario
          periodicity: usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? 3 : 12,
          datesConfig: {
            scheduling: values.scheduling,
            reviewing: values.reviewing,
            reporting: values.reporting,
            validating: values.validating,
          },
          colorsConfig: colorsConfig.length
            ? colorsConfig?.map((colorConfig: ColorsConfigItem) => ({
                fromValue: parseFloat(`${colorConfig.fromValue}`),
                toValue: parseFloat(`${colorConfig.toValue}`),
                includeFromValue: !!colorConfig.includeFromValue,
                includeToValue: !!colorConfig.includeToValue,
                color: colorConfig.color,
                label: colorConfig.label,
              }))
            : undefined,
          isActive: values.isActive,
          goalTypes: values.goalTypes,
        },
      };
      await saveMonitoringConfig({ variables });
      sendNotification({
        type: "success",
        message: "Parámetro de seguimiento creado",
        description: `Se ha creado correctamente el parámetro de seguimiento`,
      });
      router.back();
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Creando el parámetro de seguimiento",
        description: `${e}`,
      });
    }
  };

  return { createMonitoringConfig, form, loading, data, error };
};

const useEditMonitoringConfig = ({ id }: { id: number }) => {
  const router = useRouter();
  const [form] = Form.useForm();
  const { loading, error, data } = useGetMonitoringConfigQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [saveMonitoringConfig, { data: updateData, loading: updateLoading, error: updateError }] =
    useUpdateMonitoringConfigMutation();

  useEffect(() => {
    if (data?.getMonitoringConfig && form) {
      form.setFieldsValue(getFormEditValues());
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.getMonitoringConfig, form]);

  const getFormEditValues = () => {
    const configMonitoring = data?.getMonitoringConfig;
    const editData = {
      ...configMonitoring,
      scheduling: [
        dayjs(new Date(configMonitoring?.datesConfig?.scheduling?.[0])),
        dayjs(new Date(configMonitoring?.datesConfig?.scheduling?.[1])),
      ],
      reviewing: [
        dayjs(new Date(configMonitoring?.datesConfig?.reviewing?.[0])),
        dayjs(new Date(configMonitoring?.datesConfig?.reviewing?.[1])),
      ],
      reporting: [
        dayjs(new Date(configMonitoring?.datesConfig?.reporting?.[0])),
        dayjs(new Date(configMonitoring?.datesConfig?.reporting?.[1])),
      ],
      validating: [
        dayjs(new Date(configMonitoring?.datesConfig?.validating?.[0])),
        dayjs(new Date(configMonitoring?.datesConfig?.validating?.[1])),
      ],
    };
    return editData;
  };

  const updateMonitoringConfig = async () => {
    const values = form.getFieldsValue();
    try {
      const colorsConfig = values.colorsConfig?.filter((config: any) => !!config) ?? [];
      const usedFor = values.usedFor as MonitoringConfigUsedFor;
      const variables = {
        data: {
          id,
          usedFor,
          ...(usedFor === MonitoringConfigUsedFor.DevelopmentPlans
            ? {
                devPlanId: parseInt(values.devPlanId),
                spentDocs: values.spentDocs,
                weightingType: values.weightingType,
                monitoringResourcesOrigin: values.monitoringResourcesOrigin,
                supportProductMonitoring: values.supportProductMonitoring,
                sgpDiscriminated: values.sgpDiscriminated,
                copyGoals: values.copyGoals,
              }
            : {}),
          period: parseInt(values.period),
          subperiod: parseInt(values.subperiod),
          // TODO: Este debe ser un campo del formulario
          periodicity: usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? 3 : 12,
          datesConfig: {
            scheduling: values.scheduling,
            reviewing: values.reviewing,
            reporting: values.reporting,
            validating: values.validating,
          },
          colorsConfig: colorsConfig.length
            ? colorsConfig?.map((colorConfig: ColorsConfigItem) => ({
                fromValue: parseFloat(`${colorConfig.fromValue}`),
                toValue: parseFloat(`${colorConfig.toValue}`),
                includeFromValue: !!colorConfig.includeFromValue,
                includeToValue: !!colorConfig.includeToValue,
                color: colorConfig.color,
                label: colorConfig.label,
              }))
            : undefined,
          isActive: values.isActive,
          goalTypes: values.goalTypes,
        },
      };
      const result = await saveMonitoringConfig({ variables });
      sendNotification({
        type: "success",
        message: "Parámetros de seguimiento actualizados",
        description: `Se ha actualizado correctamente los parámetros de seguimiento para ${result?.data?.updateMonitoringConfig?.period}-${result?.data?.updateMonitoringConfig?.subperiod}`,
      });
      router.back();
    } catch (e) {
      console.error(e);
    }
  };

  return {
    updateMonitoringConfig,
    getFormEditValues,
    form,
    loading,
    error,
    data: data?.getMonitoringConfig,
    updateLoading,
    updateError,
    updateData,
  };
};

export {
  useMonitoringConfigs,
  useMonitoringConfig,
  useActiveMonitoring,
  useCreateMonitoringConfig,
  useEditMonitoringConfig,
};
