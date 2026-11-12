import { useState, useEffect, useMemo } from "react";
import {
  SearchGoalsDocument,
  useSearchGoalsQuery,
  useSaveTrackingMonitoringRecordMutation,
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
  SaveTrackingMonitoringRecord,
} from "../../../../graphql/gen/schema";
import { FormInstance } from "antd";
import _ from "lodash";
import { RESOURCES_FIELDS, SGP_RESOURCES_FIELDS } from "../../../../shared/const";
import { useCurrentUser } from "../../Users/hooks";
import { UseTableProps } from "../../../hooks/useTable";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import { DEFAULT_PAGE_SIZE } from "../../../const";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { SearchGoalItem } from "../../../types/goal";

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

const useGoalReview = ({
  form,
  pagination,
  goalTypes,
  filters,
}: UseTableProps & {
  form?: FormInstance<any>;
  goalTypes?: GoalType[];
  filters?: Record<string, any>;
}) => {
  const { selectedNodeId } = useDevPlanTree();
  const [searchValue, setSearchValue] = useState("");
  const currentGoal = useStoreState((state) => state.goal.currentGoal);
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);
  const setCurrentGoalTracking = useStoreActions((actions) => actions.goal.setCurrentGoalTracking);
  const { currentMonitoring } = useMonitoringConfig();

  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const { user } = useCurrentUser();

  const [saveTrackingMonitoringRecord, { data: saveData, loading: saveLoading, error: saveError }] =
    useSaveTrackingMonitoringRecordMutation({
      refetchQueries: [
        { query: SearchGoalsDocument, variables: { data: { id: currentGoal?.id } } },
      ],
    });
  const { data, error, loading } = useSearchGoalsQuery({
    variables: {
      data: {
        ...(filters?.entity ? { entityIds: filters.entity } : {}),
        monitoringConfigId: currentMonitoring?.id,
        goalTypes,
        isValidated: true,
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
          isReviewed: [MonitoringRecordStatus.Reviewed].includes(trackingData.recordStatus),
          reviewStatus: [MonitoringRecordStatus.Reviewed].includes(trackingData.recordStatus),
          monitoringConfigId: currentMonitoring?.id,
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

  const onReviewFormChange = (changedValues: any) => {
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
        isReviewed: [MonitoringRecordStatus.Reviewed].includes(trackingData.recordStatus),
        monitoringResources: [...(scheduleResources ?? []), ...(trackingResources ?? [])],
      };
    }
  };

  const saveReview = async () => {
    const values = form?.getFieldsValue();

    const { reviewStatus, reviewNotes, ...formValues } = values;
    try {
      const variables = {
        data: {
          id: formValues.id,
          monitoringConfigId: currentMonitoring?.id,
          goalAchievedValue: formValues.goalAchievedValue ?? 0,
          period: currentMonitoring?.period,
          reviewNotes,
          recordStatus:
            (reviewStatus ?? true)
              ? MonitoringRecordStatus.Reviewed
              : MonitoringRecordStatus.Rejected,
        } as SaveTrackingMonitoringRecord,
      };
      console.log("variables", variables);
      const result = await saveTrackingMonitoringRecord({ variables });
      setCurrentGoalTracking(result?.data?.saveTrackingMonitoringRecord);
      sendNotification({
        type: "success",
        message: "Revisión guardada",
        description: `Se ha actualizado correctamente revisión de la meta ${currentGoal?.code}`,
      });
    } catch (e) {
      sendNotification({
        type: "error",
        message: `Guardando revisión de la meta ${currentGoal?.code}`,
        description: `${e}`,
      });
    }
  };

  const goalsData = useMemo(() => {
    const containsStr = (text: string | null = "", searchText: string | null = "") =>
      (text ?? "").toLocaleLowerCase().indexOf((searchText ?? "").toLocaleLowerCase()) > -1;
    const isValidated = (goal: SearchGoalItem): boolean => {
      return (goal.monitoringRecords ?? []).some(
        (record) =>
          record.monitoringConfigId === currentMonitoring?.id &&
          record.recordStatus === MonitoringRecordStatus.Validated,
      );
    };
    const isReviewed = (goal: SearchGoalItem): boolean => {
      return (goal.monitoringRecords ?? []).some(
        (record) =>
          record.monitoringConfigId === currentMonitoring?.id &&
          (record.recordStatus === MonitoringRecordStatus.Rejected ||
            record.recordStatus === MonitoringRecordStatus.Reviewed),
      );
    };
    return data?.searchGoals?.items
      ?.filter((goal) => {
        const resourcesRecords = goal?.tracking?.find(
          (trackingRecord) =>
            [
              MonitoringRecordStatus.Validated,
              MonitoringRecordStatus.Reviewed,
              MonitoringRecordStatus.Rejected,
            ].includes(trackingRecord.recordStatus) &&
            trackingRecord.monitoringConfigId === (currentMonitoring?.id ?? currentMonitoring?.id),
        )?.resources;
        return (
          (resourcesRecords?.length ?? 0) >=
          ((currentMonitoring?.monitoringResourcesOrigin ??
            currentMonitoring?.monitoringResourcesOrigin) ===
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
        return isValidated(goal) || isReviewed(goal);
      })
      ?.map((goal) => {
        const { children, ...goalData } = goal;
        return {
          ...goalData,
          ...(children?.length
            ? {
                children: children.filter((goal) => {
                  return isValidated(goal) || isReviewed(goal);
                }),
              }
            : {}),
        };
      });
  }, [
    currentMonitoring?.id,
    currentMonitoring?.monitoringResourcesOrigin,
    data?.searchGoals?.items,
    searchValue,
    currentMonitoring?.monitoringResourcesOrigin,
    currentMonitoring?.id,
  ]);

  return {
    saveReview,
    onReviewFormChange,
    getFormEditValues,
    saveData,
    saveLoading,
    saveError,
    data: goalsData,
    count: data?.searchGoals?.count,
    countByType: data?.searchGoals?.countByType,
    error,
    loading,
    searchValue,
    onSearchChange,
  };
};

export default useGoalReview;
