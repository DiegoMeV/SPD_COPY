import { Action, action, Computed, computed } from 'easy-peasy';
import { GoalType } from '../../../graphql/gen/schema';
import { DataNode, DevPlanConfigLevel } from "../../types/devPlan";
import { goalTypeMap } from '../../utils/uiUtils';
import { RootModel } from './rootModel';

export type DevPlanTreeModel = {
    selectedNode: DataNode | undefined;
    expandedKeys: React.Key[];
    selectedKeys: React.Key[];
    autoExpandParent: boolean;
    setSelectedNode: Action<DevPlanTreeModel, DataNode | undefined>;
    setExpandedKeys: Action<DevPlanTreeModel, React.Key[]>;
    setSelectedKeys: Action<DevPlanTreeModel, React.Key[]>;
    setAutoExpandParent: Action<DevPlanTreeModel, boolean>;
    isGoalLevel: Computed<DevPlanTreeModel, boolean, RootModel>;
    currentGoalType: Computed<DevPlanTreeModel, GoalType | undefined, RootModel>;
    currentGoalTypeLabel: Computed<DevPlanTreeModel, string | undefined, RootModel>;
    selectedNodeId: Computed<DevPlanTreeModel, number>;
    hasParentLevel: Computed<DevPlanTreeModel, boolean, RootModel>;
    isParentGoalTypeLevel: Computed<DevPlanTreeModel, boolean, RootModel>;
    currentLevelSingularName: Computed<DevPlanTreeModel, string | undefined, RootModel>;
};

export const devPlanTreeModel: DevPlanTreeModel = {
    selectedNode: undefined,
    expandedKeys: [],
    selectedKeys: [],
    autoExpandParent: false,
    setSelectedNode: action((state, node) => {
        state.selectedNode = node;
    }),
    setExpandedKeys: action((state, expandedKeys) => {
        state.expandedKeys = expandedKeys;
    }),
    setSelectedKeys: action((state, selectedKeys) => {
        state.selectedKeys = selectedKeys;
    }),
    setAutoExpandParent: action((state, autoExpandParent) => {
        state.autoExpandParent = autoExpandParent;
    }),
    isGoalLevel: computed([(state) => state.selectedNode, (_, storeState) => storeState.devPlan.monitoringLevelNumbers], (selectedNode, monitoringLevelNumbers) => {
        const level = selectedNode?.level ?? -1;
        return monitoringLevelNumbers.includes(level);
    }),
    currentGoalType: computed([(state) => state.selectedNode, (_, storeState) => storeState.devPlan.selectedDevPlan], (selectedNode, selectedDevPlan) => {
        const configLevel: DevPlanConfigLevel | undefined = selectedDevPlan?.config?.levels?.find(
            (devPlanConfigLevel: DevPlanConfigLevel) => devPlanConfigLevel.number === selectedNode?.level,
        );
        return configLevel?.goalType as GoalType ?? undefined;
    }),
    currentGoalTypeLabel: computed([(state) => state.selectedNode, (_, storeState) => storeState.devPlan.selectedDevPlan], (selectedNode, selectedDevPlan) => {
        const configLevel: DevPlanConfigLevel | undefined = selectedDevPlan?.config?.levels?.find(
            (devPlanConfigLevel: DevPlanConfigLevel) => devPlanConfigLevel.number === selectedNode?.level,
        );
        return configLevel ? goalTypeMap[configLevel.goalType as GoalType]?.tag : undefined;
    }),
    selectedNodeId: computed((state) => parseInt(state.selectedNode?.key as string ?? -1)),
    hasParentLevel: computed([(state) => state.selectedNode, (_, storeState) => storeState.devPlan.monitoringLevelNumbers
    ], (selectedNode, monitoringLevelNumbers) => {
        return monitoringLevelNumbers?.includes((selectedNode?.level ?? 0) - 1);
    }),
    isParentGoalTypeLevel: computed([(state) => state.selectedNode, (_, storeState) => (
        {
            selectedDevPlan: storeState.devPlan.selectedDevPlan,
            monitoringLevelNumbers: storeState.devPlan.monitoringLevelNumbers
        })], (selectedNode, { selectedDevPlan, monitoringLevelNumbers }) => {
            const parentLevel: DevPlanConfigLevel | undefined = selectedDevPlan?.config?.levels?.find(
                (devPlanConfigLevel: DevPlanConfigLevel) => !!devPlanConfigLevel.goalType && devPlanConfigLevel.number === (selectedNode?.level ?? 0) - 1,
            );
            return !!parentLevel;
        }),
    currentLevelSingularName: computed([(state) => state.selectedNode, (_, storeState) => storeState.devPlan.selectedDevPlan], (selectedNode, selectedDevPlan) => {
        const configLevel: DevPlanConfigLevel | undefined = selectedDevPlan?.config?.levels?.find(
            (devPlanConfigLevel: DevPlanConfigLevel) => devPlanConfigLevel.number === selectedNode?.level,
        );
        return configLevel?.singularName;
    }),
};
