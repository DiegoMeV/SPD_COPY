import { useState, useEffect, useMemo, act } from "react";
import {
  useSavePlannedMonitoringRecordMutation,
  useSearchGoalsQuery,
  SearchGoalsDocument,
} from "../../../../graphql/gen/hooks";
import { useStoreState, useStoreActions } from "../../../store";
import { MonitoringRecordResourceFragment } from "../../../../graphql/gen/ops";
import {
  GoalType,
  MonitoringResourcesOrigin,
  MonitoringResourceType,
} from "../../../../graphql/gen/schema";
import { FormInstance } from "antd";
import _ from "lodash";
import { RESOURCES_FIELDS, SGP_RESOURCES_FIELDS } from "../../../../shared/const";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { UseTableProps } from "../../../hooks/useTable";
import { DEFAULT_PAGE_SIZE } from "../../../const";

const useGoalSchedule = (form: FormInstance<any>) => {
  const currentGoal = useStoreState((state) => state.goal.currentGoal);
  const hasSchedule = useStoreState((state) => state.goal.hasSchedule);
  const setCurrentGoalSchedule = useStoreActions((actions) => actions.goal.setCurrentGoalSchedule);
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);
  const { currentMonitoring } = useMonitoringConfig();
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const { getMonitoringLabels } = useMonitoring();

  const [savePlannedMonitoringRecord, { data: saveData, loading: saveLoading, error: saveError }] =
    useSavePlannedMonitoringRecordMutation({
      refetchQueries: [
        {
          query: SearchGoalsDocument,
          variables: {
            data: {
              monitoringConfigId: currentMonitoring?.id,
              goalTypes: [currentGoal?.goalType],
            },
          },
        },
      ],
    });

  useEffect(() => {
    form?.resetFields();
    if (currentGoal && currentMonitoring?.id) {
      const currentSchedule = currentGoal?.schedule?.find(
        (goalSchedule) => goalSchedule.monitoringConfigId === currentMonitoring?.id,
      );
      if (currentSchedule) {
        const { resources, ...scheduleData } = currentSchedule ?? {};
        const userResources = resources?.find(
          (resource) => resource.resourceType === MonitoringResourceType.Manual,
        );
        const financialResources = resources?.find(
          (resource) => resource.resourceType === MonitoringResourceType.Definitive,
        );
        const formValues = {
          ...scheduleData,
          monitoringConfigId: currentMonitoring?.id,
          monitoringResources: {
            [MonitoringResourcesOrigin.User]: userResources,
            [MonitoringResourcesOrigin.Financial]: financialResources,
          },
        };
        form?.setFieldsValue(formValues);
      }
    }
  }, [currentGoal, currentMonitoring?.id]);

  const calculateSGP = () => {
    const monitoringResources: MonitoringRecordResourceFragment[] =
      form.getFieldValue("monitoringResources");
    const sgp: Partial<Record<MonitoringResourcesOrigin, number>> = {};
    Object.entries(monitoringResources).map(([origin, v]) => {
      Object.entries(v).map(([field, value]) => {
        if (SGP_RESOURCES_FIELDS.includes(field))
          sgp[origin as MonitoringResourcesOrigin] =
            (sgp[origin as MonitoringResourcesOrigin] ?? 0) + (value ?? 0);
      });
    });
    form.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.User, "sgp"],
      sgp[MonitoringResourcesOrigin.User] ?? 0,
    );
    form.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.Financial, "sgp"],
      sgp[MonitoringResourcesOrigin.Financial] ?? 0,
    );
  };

  const calculateTotals = () => {
    if (currentMonitoring?.sgpDiscriminated) {
      calculateSGP();
    }
    const monitoringResources: MonitoringRecordResourceFragment[] =
      form.getFieldValue("monitoringResources");
    const totals: Partial<Record<MonitoringResourcesOrigin, number>> = {};
    Object.entries(monitoringResources).map(([origin, v]) => {
      Object.entries(v).map(([field, value]) => {
        if (RESOURCES_FIELDS.includes(field))
          totals[origin as MonitoringResourcesOrigin] =
            (totals[origin as MonitoringResourcesOrigin] ?? 0) + (value ?? 0);
      });
    });
    form.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.User, "resourcesTotal"],
      totals[MonitoringResourcesOrigin.User] ?? 0,
    );
    form.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.Financial, "resourcesTotal"],
      totals[MonitoringResourcesOrigin.Financial] ?? 0,
    );
  };

  const onScheduleFormChange = (changedValues: any) => {
    validateMonthConsistency(changedValues);
    if (Object.hasOwnProperty.call(changedValues, "monitoringResources")) {
      calculateTotals();
    }
  };

  const validateMonthConsistency = (changedValues: any) => {
    if (Object.hasOwnProperty.call(changedValues, "fromMonth")) {
      const fromMonth = changedValues["fromMonth"];
      const toMonth = form.getFieldValue("toMonth");
      if (fromMonth > toMonth) {
        form.setFieldsValue({ toMonth: fromMonth });
      }
    }
    if (Object.hasOwnProperty.call(changedValues, "toMonth")) {
      const toMonth = changedValues["toMonth"];
      const fromMonth = form.getFieldValue("fromMonth");
      if (fromMonth > toMonth) {
        form.setFieldsValue({ fromMonth: toMonth });
      }
    }
  };

  const getFormEditValues = () => {
    const currentSchedule = currentGoal?.schedule?.find(
      (goalSchedule) => goalSchedule.monitoringConfigId === currentMonitoring?.id,
    );
    if (currentSchedule) {
      const { resources: monitoringResources, ...scheduleData } = currentSchedule ?? {};
      return { ...scheduleData, monitoringResources };
    }
  };

  const saveSchedule = async () => {
    const values = form?.getFieldsValue();
    const { monitoringResources: formMonitoringResources, ...formValues } = values;
    const monitoringResources = [
      ...(!_.isEmpty(formMonitoringResources?.[MonitoringResourcesOrigin.User])
        ? [
            _.omit(
              {
                ...formMonitoringResources?.[MonitoringResourcesOrigin.User],
                resourceType: MonitoringResourceType.Manual,
              },
              ["resourcesTotal"],
            ),
          ]
        : []),
      ...(!_.isEmpty(formMonitoringResources?.[MonitoringResourcesOrigin.Financial])
        ? [
            _.omit(
              {
                ...formMonitoringResources?.[MonitoringResourcesOrigin.Financial],
                resourceType: MonitoringResourceType.Definitive,
              },
              ["resourcesTotal"],
            ),
          ]
        : []),
    ];
    try {
      const variables = {
        data: {
          ...formValues,
          monitoringConfigId: currentMonitoring?.id,
          monitoringResources,
          goalId: currentGoal?.id,
          period: currentMonitoring?.period,
        },
      };
      const result = await savePlannedMonitoringRecord({ variables });
      if (result?.data) {
        const { goal, ...scheduleData } = result?.data?.savePlannedMonitoringRecord;
        setCurrentGoalSchedule(scheduleData);
        setCurrentGoal(goal);
        sendNotification({
          type: "success",
          message: "Programación guardada",
          description: `Se ha guardado correctamente la programación de ${getMonitoringLabels([currentGoal?.goalType ?? GoalType.Product]).singular}
          ${currentGoal?.code}`,
        });
      }
    } catch (e) {
      sendNotification({
        type: "error",
        message: `Guardando programación de ${getMonitoringLabels([currentGoal?.goalType ?? GoalType.Product]).singular}
         ${currentGoal?.code}`,
        description: `${e}`,
      });
    }
  };

  return {
    saveSchedule,
    onScheduleFormChange,
    getFormEditValues,
    saveData,
    saveLoading,
    saveError,
    hasSchedule,
  };
};

const useGoalsForSchedule = ({
  form,
  pagination,
  goalTypes,
  filters,
}: UseTableProps & {
  form?: FormInstance<any>;
  goalTypes?: GoalType[];
  filters?: Record<string, any>;
}) => {
  const [searchValue, setSearchValue] = useState("");
  const { currentMonitoring } = useMonitoringConfig();

  const { data, loading, error } = useSearchGoalsQuery({
    variables: {
      data: {
        goalTypes,
        monitoringConfigId: currentMonitoring?.id,
        ...(filters?.entity ? { entityIds: filters.entity } : {}),
        limit: pagination?.pageSize ?? DEFAULT_PAGE_SIZE,
        offset: ((pagination?.current ?? 1) - 1) * (pagination?.pageSize ?? DEFAULT_PAGE_SIZE),
      },
    },
    fetchPolicy: "network-only",
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
        const { children, ...goalData } = goal;
        return {
          ...goalData,
          ...(children?.length ? { children } : {}),
        };
      });
  }, [data, searchValue]);

  return {
    data: goalsData,
    count: data?.searchGoals?.count,
    loading,
    error,
    searchValue,
    setSearchValue,
    onSearchChange,
  };
};

export default useGoalSchedule;

export { useGoalsForSchedule };
