import React from "react";
import { useGetDevPlanLevelsTreeQuery } from "../../../graphql/gen/hooks";
import { DevPlanTree } from "./DevPlanTree";
import type { DataNode } from "../../types/devPlan";
import { CheckedKeys } from "../../types/common";
import { GoalType } from "@prisma/client";

type Props = {
  devPlanId: number;
  showRootAsNode?: boolean;
  pExpandedKeys?: React.Key[];
  pSelectedKeys?: React.Key[];
  pCheckedKeys?: CheckedKeys;
  pAutoExpandParent?: boolean;
  checkable?: boolean;
  treeMode?: "normal" | "filter";
  goalTypes: GoalType[];
  onSelectNode?: (node: DataNode) => void;
  pSetExpandedKeys?: (expandedKeys: React.Key[]) => void;
  pSetSelectedKeys?: (selectedKeys: React.Key[]) => void;
  pSetAutoExpandParent?: (autoExpandParent: boolean) => void;
  pSetCheckedKeys?: (checkedKeys: CheckedKeys) => void;
  pOnClose?: () => void;
  pOnFilter?: () => void;
  pOnClear?: () => void;
};

export const DevPlanTreeLoader: React.FC<Props> = ({
  devPlanId,
  showRootAsNode = false,
  ...props
}) => {
  const {
    loading: loadingLevels,
    error: errorLevels,
    data: dataLevels,
  } = useGetDevPlanLevelsTreeQuery({
    variables: {
      devPlanId,
      getRootAsNode: showRootAsNode,
    },
  });

  return (
    <DevPlanTree
      data={dataLevels?.getDevPlanLevelsTree}
      loading={loadingLevels}
      error={errorLevels}
      {...props}
    />
  );
};
