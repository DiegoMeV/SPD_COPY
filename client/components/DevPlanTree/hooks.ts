import { useStoreState, useStoreActions } from "../../store";

const useDevPlanTree = () => {
    const isGoalLevel = useStoreState((state) => state.devPlanTree.isGoalLevel);
    const isParentGoalTypeLevel = useStoreState((state) => state.devPlanTree.isParentGoalTypeLevel);
    const currentGoalType = useStoreState((state) => state.devPlanTree.currentGoalType);
    const currentGoalTypeLabel = useStoreState((state) => state.devPlanTree.currentGoalTypeLabel);
    const currentLevelSingularName = useStoreState((state) => state.devPlanTree.currentLevelSingularName);
    const selectedNode = useStoreState((state) => state.devPlanTree.selectedNode);
    const selectedNodeId = useStoreState((state) => state.devPlanTree.selectedNodeId);
    const expandedKeys = useStoreState((state) => state.devPlanTree.expandedKeys);
    const selectedKeys = useStoreState((state) => state.devPlanTree.selectedKeys);
    const autoExpandParent = useStoreState((state) => state.devPlanTree.autoExpandParent);
    const setSelectedNode = useStoreActions((actions) => actions.devPlanTree.setSelectedNode);
    const setExpandedKeys = useStoreActions((actions) => actions.devPlanTree.setExpandedKeys);
    const setSelectedKeys = useStoreActions((actions) => actions.devPlanTree.setSelectedKeys);
    const setAutoExpandParent = useStoreActions((actions) => actions.devPlanTree.setAutoExpandParent);

    return {
        selectedNode,
        selectedNodeId,
        expandedKeys,
        selectedKeys,
        autoExpandParent,
        isGoalLevel,
        isParentGoalTypeLevel,
        currentGoalType,
        currentGoalTypeLabel,
        currentLevelSingularName,
        setSelectedNode,
        setExpandedKeys,
        setSelectedKeys,
        setAutoExpandParent
    };
};

export { useDevPlanTree };