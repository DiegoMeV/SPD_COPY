import { useState, useEffect, useMemo } from "react";
import {
  SearchGoalsDocument,
  useSaveTrackingMonitoringRecordMutation,
  useSearchGoalsLazyQuery,
} from "../../../../graphql/gen/hooks";
import { useStoreState, useStoreActions } from "../../../store";
import { MonitoringRecordResourceFragment } from "../../../../graphql/gen/ops";
import { monitoringResourcesOriginCollection } from "../../../utils/uiUtils";
import {
  GoalType,
  MonitoringRecord,
  MonitoringRecordStatus,
  MonitoringResourcesOrigin,
  MonitoringResourceType,
  MonitoringStatus,
  SaveTrackingMonitoringRecord,
} from "../../../../graphql/gen/schema";
import { FormInstance } from "antd";
import _ from "lodash";
import {
  RESOURCES_FIELDS,
  SGP_RESOURCES_FIELDS,
  SPENT_DOC_TO_RESOURCE_TYPE,
} from "../../../../shared/const";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { SearchGoalItem } from "../../../types/goal";
import { UseTableProps } from "../../../hooks/useTable";
import { DEFAULT_PAGE_SIZE } from "../../../const";

export type UseGetParentLevelGoalsProps = {
  devPlanLevelId: number;
};

export type UseSearchGoalsByCodeProps = {
  devPlanId: number;
  code: string;
};

export type UseGetGoalsProps = {
  devPlanLevelId: number;
};

const useGoalValidating = ({
  form,
  goalTypes,
  filters,
  pagination,
}: UseTableProps & {
  form?: FormInstance<any>;
  goalTypes?: GoalType[];
  filters?: Record<string, any>;
} = {}) => {
  const [searchValue, setSearchValue] = useState("");
  const currentGoal = useStoreState((state) => state.goal.currentGoal);
  const hasValidation = useStoreState((state) => state.goal.hasTracking);
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);
  const { currentMonitoring } = useMonitoringConfig();
  const { sendNotification } = useStoreActions((actions) => actions.notifications);

  const [saveTrackingMonitoringRecord, { data: saveData, loading: saveLoading, error: saveError }] =
    useSaveTrackingMonitoringRecordMutation({
      refetchQueries: [
        {
          query: SearchGoalsDocument,
          variables: {
            data: {
              ...(filters?.entity ? { entityIds: filters.entity } : {}),
              monitoringConfigId: currentMonitoring?.id,
              goalTypes,
              isReported: true,
              limit: pagination?.pageSize ?? DEFAULT_PAGE_SIZE,
              offset:
                ((pagination?.current ?? 1) - 1) * (pagination?.pageSize ?? DEFAULT_PAGE_SIZE),
            },
          },
        },
      ],
    });
  const [searchGoals, { data, error, loading }] = useSearchGoalsLazyQuery({
    variables: {
      data: {
        ...(filters?.entity ? { entityIds: filters.entity } : {}),
        monitoringConfigId: currentMonitoring?.id,
        goalTypes,
        stage: MonitoringStatus.Reporting,
        isReported: true,
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

  useEffect(() => {
    if (currentMonitoring?.id) {
      searchGoals();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentMonitoring?.id]);

  useEffect(() => {
    // update current goal with new data
    const goal = data?.searchGoals?.items?.find((goal) => goal.id === currentGoal?.id);
    if (goal) setCurrentGoal(goal);
  }, [currentGoal, data]);

  useEffect(() => {
    form?.resetFields();
    if (currentGoal && currentMonitoring?.id) {
      const currentSchedule = currentGoal?.schedule?.find(
        (goalSchedule) => goalSchedule.monitoringConfigId === currentMonitoring?.id,
      );
      const currentTracking = currentGoal?.tracking?.find(
        (goalTracking) => goalTracking.monitoringConfigId === currentMonitoring?.id,
      );
      if (currentSchedule || currentTracking) {
        const { resources: scheduleResources, ...scheduleData } =
          currentSchedule ?? ({} as MonitoringRecord);
        const { resources: trackingResources, ...trackingData } =
          currentTracking ?? ({} as MonitoringRecord);
        const userResources = scheduleResources?.find(
          (resource) => resource.resourceType === MonitoringResourceType.Manual,
        );
        const financialResources = scheduleResources?.find(
          (resource) => resource.resourceType === MonitoringResourceType.Definitive,
        );
        const commitmentResources = trackingResources?.find(
          (resource) => resource.resourceType === MonitoringResourceType.Commitment,
        );
        const obligationResources = trackingResources?.find(
          (resource) => resource.resourceType === MonitoringResourceType.Obligation,
        );
        const formValues = {
          ...trackingData,
          isValidated: [MonitoringRecordStatus.Validated, MonitoringRecordStatus.Reviewed].includes(
            trackingData.recordStatus,
          ),
          monitoringConfigId: currentMonitoring,
          monitoringResources: {
            [MonitoringResourcesOrigin.User]: userResources,
            [MonitoringResourcesOrigin.Financial]: financialResources,
            [MonitoringResourceType.Commitment]: commitmentResources,
            [MonitoringResourceType.Obligation]: obligationResources,
          },
        };
        form?.setFieldsValue(formValues);
      }
    }
  }, [currentGoal, currentMonitoring?.id]);

  const calculateSGP = () => {
    const monitoringResources: MonitoringRecordResourceFragment[] =
      form?.getFieldValue("monitoringResources");
    const sgp: Partial<Record<MonitoringResourcesOrigin | MonitoringResourceType, number>> = {};
    Object.entries(monitoringResources)?.map(([originOrResource, v]) => {
      Object.entries(v ?? {})?.map(([field, value]) => {
        if (SGP_RESOURCES_FIELDS.includes(field)) {
          if (
            monitoringResourcesOriginCollection.includes(
              originOrResource as MonitoringResourcesOrigin,
            )
          ) {
            sgp[originOrResource as MonitoringResourcesOrigin] =
              (sgp[originOrResource as MonitoringResourcesOrigin] ?? 0) + (value ?? 0);
          } else {
            sgp[originOrResource as MonitoringResourceType] =
              (sgp[originOrResource as MonitoringResourceType] ?? 0) + (value ?? 0);
          }
        }
      });
    });
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.User, "sgp"],
      sgp[MonitoringResourcesOrigin.User] ?? 0,
    );
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.Financial, "sgp"],
      sgp[MonitoringResourcesOrigin.Financial] ?? 0,
    );
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourceType.Commitment, "sgp"],
      sgp[MonitoringResourceType.Commitment] ?? 0,
    );
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourceType.Obligation, "sgp"],
      sgp[MonitoringResourceType.Obligation] ?? 0,
    );
  };

  const calculateTotals = () => {
    if (currentMonitoring?.sgpDiscriminated) {
      calculateSGP();
    }
    const monitoringResources: MonitoringRecordResourceFragment[] =
      form?.getFieldValue("monitoringResources");
    const totals: Partial<Record<MonitoringResourcesOrigin | MonitoringResourceType, number>> = {};
    Object.entries(monitoringResources)?.map(([originOrResource, v]) => {
      Object.entries(v ?? {})?.map(([field, value]) => {
        if (RESOURCES_FIELDS.includes(field)) {
          if (
            monitoringResourcesOriginCollection.includes(
              originOrResource as MonitoringResourcesOrigin,
            )
          ) {
            totals[originOrResource as MonitoringResourcesOrigin] =
              (totals[originOrResource as MonitoringResourcesOrigin] ?? 0) + (value ?? 0);
          } else {
            totals[originOrResource as MonitoringResourceType] =
              (totals[originOrResource as MonitoringResourceType] ?? 0) + (value ?? 0);
          }
        }
      });
    });
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.User, "resourcesTotal"],
      totals[MonitoringResourcesOrigin.User] ?? 0,
    );
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourcesOrigin.Financial, "resourcesTotal"],
      totals[MonitoringResourcesOrigin.Financial] ?? 0,
    );
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourceType.Commitment, "resourcesTotal"],
      totals[MonitoringResourceType.Commitment] ?? 0,
    );
    form?.setFieldValue(
      ["monitoringResources", MonitoringResourceType.Obligation, "resourcesTotal"],
      totals[MonitoringResourceType.Obligation] ?? 0,
    );
  };

  const onValidateFormChange = (changedValues: any) => {
    if (Object.hasOwnProperty.call(changedValues, "monitoringResources")) {
      calculateTotals();
    }
  };

  const getFormEditValues = () => {
    const currentSchedule = currentGoal?.schedule?.find(
      (goalSchedule) => goalSchedule.monitoringConfigId === currentMonitoring?.id,
    );
    const currentTracking = currentGoal?.tracking?.find(
      (goalTracking) => goalTracking.monitoringConfigId === currentMonitoring?.id,
    );
    if (currentSchedule || currentTracking) {
      const { resources: scheduleResources, ...scheduleData } =
        currentSchedule ?? ({} as MonitoringRecord);
      const { resources: trackingResources, ...trackingData } =
        currentTracking ?? ({} as MonitoringRecord);
      return {
        ...trackingData,
        isValidated: [MonitoringRecordStatus.Validated, MonitoringRecordStatus.Reviewed].includes(
          trackingData.recordStatus,
        ),
        monitoringResources: [...(scheduleResources ?? []), ...(trackingResources ?? [])],
      };
    }
  };

  const saveValidation = async () => {
    const values = form?.getFieldsValue();
    const { monitoringResources: formMonitoringResources, isValidated, ...formValues } = values;
    const monitoringResources = currentMonitoring?.spentDocs?.map((spentDoc) => {
      return _.omit(
        {
          ...formMonitoringResources?.[spentDoc],
          resourceType: SPENT_DOC_TO_RESOURCE_TYPE[spentDoc],
        },
        ["resourcesTotal"],
      );
    });
    try {
      const variables = {
        data: {
          ..._.omit(formValues, [
            "goalId",
            "goalValue",
            "piGoalValue",
            "weighting",
            "fromMonth",
            "toMonth",
          ]),
          goalAchievedValue: formValues.goalAchievedValue ?? 0,
          monitoringResources,
          period: currentMonitoring?.period,
          recordStatus: isValidated
            ? MonitoringRecordStatus.Validated
            : MonitoringRecordStatus.Reported,
          monitoringConfigId: currentMonitoring?.id,
        } as SaveTrackingMonitoringRecord,
      };
      await saveTrackingMonitoringRecord({ variables });
      sendNotification({
        type: "success",
        message: "Validación guardada",
        description: `Se ha actualizado correctamente validación de la meta ${currentGoal?.code}`,
      });
    } catch (e) {
      sendNotification({
        type: "error",
        message: `Guardando validación de la meta ${currentGoal?.code}`,
        description: `${e}`,
      });
    }
  };

  const goalsData = useMemo(() => {
    const containsStr = (text: string | null = "", searchText: string | null = "") =>
      (text ?? "").toLocaleLowerCase().indexOf((searchText ?? "").toLocaleLowerCase()) > -1;
    const isReported = (goal: SearchGoalItem): boolean => {
      return (goal.monitoringRecords ?? []).some(
        (record) =>
          record.monitoringConfigId === currentMonitoring?.id &&
          record.recordStatus === MonitoringRecordStatus.Reported,
      );
    };
    const isScheduledForSubperiod = (goal: SearchGoalItem): boolean => {
      return (goal.monitoringRecords ?? []).some(
        (record) =>
          (record.monitoringConfigId === currentMonitoring?.id &&
            (record.recordStatus === MonitoringRecordStatus.Planned ||
              record.recordStatus === MonitoringRecordStatus.Copied) &&
            record.fromMonth <= currentMonitoring?.subperiod * 3) ||
          !(
            record.recordStatus === MonitoringRecordStatus.Planned ||
            record.recordStatus === MonitoringRecordStatus.Copied
          ),
      );
    };
    return data?.searchGoals?.items
      ?.filter((goal) => {
        const resourcesRecords = goal?.tracking?.find(
          (trackingRecord) =>
            [
              MonitoringRecordStatus.Reported,
              MonitoringRecordStatus.Validated,
              MonitoringRecordStatus.Reviewed,
              MonitoringRecordStatus.Rejected,
            ].includes(trackingRecord.recordStatus) &&
            trackingRecord.monitoringConfigId === currentMonitoring?.id,
        )?.resources;
        return (
          (resourcesRecords?.length ?? 0) >=
          (currentMonitoring?.monitoringResourcesOrigin ===
          MonitoringResourcesOrigin.UserAndFinancial
            ? 2
            : 1)
        );
      })
      ?.filter(
        (goal) =>
          containsStr(goal.code, searchValue) ||
          containsStr(goal.name, searchValue) ||
          containsStr(goal.indicator, searchValue),
      )
      ?.filter((goal) => {
        return isReported(goal) || isScheduledForSubperiod(goal);
      })
      ?.map((goal) => {
        const { children, ...goalData } = goal;
        return {
          ...goalData,
          ...(children?.length
            ? {
                children: children.filter((goal) => {
                  return isReported(goal) || isScheduledForSubperiod(goal);
                }),
              }
            : {}),
        };
      });
  }, [
    data?.searchGoals?.items,
    searchValue,
    currentMonitoring?.monitoringResourcesOrigin,
    currentMonitoring?.id,
  ]);

  return {
    saveValidation,
    onValidateFormChange,
    getFormEditValues,
    saveData,
    saveLoading,
    saveError,
    hasValidation,
    data: goalsData,
    count: data?.searchGoals?.count,
    countByType: data?.searchGoals?.countByType,
    error,
    loading,
    searchValue,
    onSearchChange,
  };
};

export default useGoalValidating;
