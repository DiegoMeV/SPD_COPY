/* eslint-disable react-hooks/exhaustive-deps */
import React, { useMemo, useState, useEffect } from "react";
import { Tree, Spin, Result, Input, Badge, Tooltip, Space, Button, Typography, Flex } from "antd";
import { DownOutlined, SearchOutlined } from "@ant-design/icons";
import type { DataNode } from "../../types/devPlan";
import { DevPlanLevelFragment, GoalTypeCountFragment } from "../../../graphql/gen/ops";
import { goalTypeMap } from "../../utils/uiUtils";
import { CheckedKeys } from "../../types/common";
import { useDevPlanTree } from "./hooks";
import { ApolloError } from "@apollo/client";
import { GoalType } from "@prisma/client";

const { Search } = Input;
const { Text } = Typography;

type DataNodeList = Pick<DataNode, "key" | "code" | "title" | "level" | "productCatalogId">;

type DevPlanTreeNode = Pick<DevPlanLevelFragment, "id" | "code" | "key" | "name"> & {
  children?: DevPlanTreeNode[];
  goalCount?: GoalTypeCountFragment[] | undefined;
  productCatalogId?: number | null;
};
type DevPlanTreeData = Array<DevPlanTreeNode>;

type Props = {
  data?: DevPlanTreeData;
  loading?: boolean;
  error?: ApolloError;
  pExpandedKeys?: React.Key[];
  pSelectedKeys?: React.Key[];
  pCheckedKeys?: CheckedKeys;
  pAutoExpandParent?: boolean;
  checkable?: boolean;
  treeMode?: "normal" | "filter";
  showRootAsNode?: boolean;
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

const getParentKey = (key: React.Key, tree: DataNode[]): React.Key => {
  let parentKey: React.Key;
  for (let i = 0; i < tree.length; i++) {
    const node = tree[i];
    if (node.children) {
      if (node.children.some((item) => item.key === key)) {
        parentKey = node.key;
      } else if (getParentKey(key, node.children)) {
        parentKey = getParentKey(key, node.children);
      }
    }
  }
  return parentKey!;
};

export const DevPlanTree: React.FC<Props> = ({
  data,
  loading = false,
  error,
  pExpandedKeys,
  pSelectedKeys,
  pCheckedKeys,
  pAutoExpandParent,
  treeMode = "normal",
  checkable = false,
  showRootAsNode = false,
  goalTypes,
  onSelectNode,
  pSetExpandedKeys,
  pSetSelectedKeys,
  pSetAutoExpandParent,
  pSetCheckedKeys,
  pOnClose,
  pOnFilter,
  pOnClear,
}) => {
  const {
    expandedKeys,
    selectedKeys,
    autoExpandParent,
    setExpandedKeys,
    setSelectedKeys,
    setSelectedNode,
    setAutoExpandParent,
  } = useDevPlanTree();
  const [checkedKeys, setCheckedKeys] = useState<CheckedKeys>([]);
  const [searchValue, setSearchValue] = useState("");
  const [defaultTree, setDefaultTree] = useState<DataNode[]>([]);
  const [dataList, setDataList] = useState<DataNodeList[]>([]);

  // Root node expanded by default
  useEffect(() => {
    console.log("[DevPlanTree][useEffect] showRootAsNode, data", showRootAsNode, data);
    if (showRootAsNode && data) setExpandedKeys([data?.[0]?.key]);
  }, [showRootAsNode, data]);

  useEffect(() => {
    console.log("[DevPlanTree][useEffect] data, pExpandedKeys", data, pExpandedKeys);
    if (pExpandedKeys?.length && data) setExpandedKeys(pExpandedKeys);
  }, [data, pExpandedKeys]);

  useEffect(() => {
    console.log("[DevPlanTree][useEffect] data, pSelectedKeys", data, pSelectedKeys);
    if (pSelectedKeys?.length && data) setSelectedKeys(pSelectedKeys);
  }, [data, pSelectedKeys]);

  useEffect(() => {
    console.log("[DevPlanTree][useEffect] data, showRootAsNode", data, showRootAsNode);
    const generateTree = (data: DevPlanTreeData, level = showRootAsNode ? 0 : 1): DataNode[] => {
      return data.map((dataLevel) => ({
        title: dataLevel.name,
        code: dataLevel.code,
        key: `${dataLevel.id}`,
        level,
        productCatalogId: dataLevel.productCatalogId,
        isLeaf: !dataLevel.children?.length,
        goalCount: dataLevel.goalCount,
        ...(dataLevel.children ? { children: generateTree(dataLevel.children, level + 1) } : {}),
      }));
    };
    const nodesList: DataNodeList[] = [];
    const generateList = (data: DataNode[]) => {
      for (let i = 0; i < data.length; i++) {
        const node = data[i];
        const { key, code, title, level, productCatalogId } = node;
        nodesList.push({ key, code, title, level, productCatalogId });
        if (node.children) {
          generateList(node.children);
        }
      }
    };
    if (data) {
      const newDefaultTree = generateTree(data || []);
      setDefaultTree(newDefaultTree);
      generateList(newDefaultTree);
      setDataList(nodesList);
    }
  }, [data, showRootAsNode]);

  const _setExpandedKeys = (newExpandedKeys: React.Key[]) => {
    if (pSetExpandedKeys) {
      pSetExpandedKeys(newExpandedKeys);
    } else {
      setExpandedKeys(newExpandedKeys);
    }
  };

  const _setSelectedKeys = (newSelectedKeys: React.Key[]) => {
    if (pSetSelectedKeys) {
      pSetSelectedKeys(newSelectedKeys);
    } else {
      setSelectedKeys(newSelectedKeys);
    }
  };

  const _setCheckedKeys = (newCheckedKeys: CheckedKeys) => {
    if (pSetCheckedKeys) {
      pSetCheckedKeys(newCheckedKeys);
    } else {
      setCheckedKeys(newCheckedKeys);
    }
  };

  const _setAutoExpandParent = (expandParent: boolean) => {
    if (pSetAutoExpandParent) {
      pSetAutoExpandParent(expandParent);
    } else {
      setAutoExpandParent(expandParent);
    }
  };

  const _onExpand = (newExpandedKeys: React.Key[]) => {
    _setExpandedKeys(newExpandedKeys);
    // _setAutoExpandParent(false);
  };

  const _onCheck = (newCheckedKeys: CheckedKeys) => {
    _setCheckedKeys(newCheckedKeys);
  };

  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = e.target;
    const newExpandedKeys = dataList
      .map((item) => {
        if (
          `${item.code}${item.title}`.toLocaleLowerCase().indexOf(value.toLocaleLowerCase()) > -1
        ) {
          return getParentKey(item.key, defaultTree);
        }
        return null;
      })
      .filter((item, i, self) => item && self.indexOf(item) === i);
    _setExpandedKeys(newExpandedKeys as React.Key[]);
    setSearchValue(value);
    _setAutoExpandParent(true);
  };

  const onSelect = (selectedKeysValue: React.Key[], info: any) => {
    onSelectNode?.(info.node);
    setSelectedNode(info.node);
    _setSelectedKeys(selectedKeysValue);
  };

  const treeData = useMemo(() => {
    // sum goal count of children with node goal count
    const loopCount = (data: DataNode[]): GoalTypeCountFragment[] => {
      const goalCount: GoalTypeCountFragment[] = [];
      data.forEach((item) => {
        if (item.goalCount) {
          item.goalCount.forEach((goalCountItem) => {
            const index = goalCount.findIndex((gc) => gc.goalType === goalCountItem.goalType);
            if (index >= 0) {
              goalCount[index].count += goalCountItem.count;
            } else {
              goalCount.push({ ...goalCountItem });
            }
          });
        }
        if (item.children) {
          loopCount(item.children).forEach((goalCountItem) => {
            const index = goalCount.findIndex((gc) => gc.goalType === goalCountItem.goalType);
            if (index >= 0) {
              goalCount[index].count += goalCountItem.count;
            } else {
              goalCount.push({ ...goalCountItem });
            }
          });
        }
      });
      return goalCount;
    };

    const loop = (data: DataNode[]): DataNode[] =>
      data.map((item) => {
        const title = item.title;
        const strTitle = `${item.code} ${item.title}`;
        const index = strTitle.toLocaleLowerCase().indexOf(searchValue.toLocaleLowerCase());
        const beforeStr = strTitle.substring(0, index);
        const afterStr = strTitle.slice(index + searchValue.length);
        const htmlTitle =
          index > -1 ? (
            <span>
              {beforeStr}
              <span className="site-tree-search-value">{searchValue}</span>
              {afterStr}
            </span>
          ) : (
            <span>{strTitle}</span>
          );
        if (item.children) {
          return {
            title,
            htmlTitle,
            code: item.code,
            key: item.key,
            level: item.level,
            productCatalogId: item.productCatalogId,
            goalCount: item.goalCount?.length ? item.goalCount : loopCount(item.children),
            children: loop(item.children),
          };
        }

        return {
          title,
          htmlTitle,
          code: item.code,
          key: item.key,
          level: item.level,
          productCatalogId: item.productCatalogId,
          goalCount: item.goalCount,
        };
      });

    return loop(defaultTree);
  }, [searchValue, defaultTree]);

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
        subTitle={error.message}
      />
    );

  return (
    <>
      {!!treeData?.length && (
        <>
          {treeMode !== "filter" && (
            <Search style={{ marginBottom: 8 }} placeholder="Buscar" onChange={onChange} />
          )}
          <Tree
            autoExpandParent={
              pAutoExpandParent !== undefined ? pAutoExpandParent : autoExpandParent
            }
            showLine
            switcherIcon={<DownOutlined />}
            treeData={treeData}
            titleRender={(nodeData) => {
              const goalCount = nodeData.goalCount ?? [];
              return (
                <Flex justify="start">
                  <Text>{nodeData.htmlTitle ?? nodeData.title}</Text>
                  <Space>
                    {goalCount
                      .filter((goalCount) => !goalTypes || goalTypes.includes(goalCount.goalType))
                      .map((goalCount) => (
                        <Tooltip
                          key={goalCount.goalType}
                          title={
                            goalCount?.count
                              ? `${goalCount?.count} metas de ${goalTypeMap[goalCount?.goalType]?.tag}`
                              : "Sin metas"
                          }
                        >
                          <Badge
                            count={goalCount?.count ?? 0}
                            size="default"
                            style={{ padding: "0 3px" }}
                            color={goalTypeMap[goalCount?.goalType]?.color ?? "cyan"}
                            offset={[10, 0]}
                          />
                        </Tooltip>
                      ))}
                  </Space>
                </Flex>
              );
            }}
            onExpand={_onExpand}
            expandedKeys={pExpandedKeys?.length ? pExpandedKeys : expandedKeys}
            selectedKeys={pSelectedKeys?.length ? pSelectedKeys : selectedKeys}
            checkedKeys={
              ((Array.isArray(pCheckedKeys) ? pCheckedKeys : pCheckedKeys?.checked) ?? [])?.length
                ? pCheckedKeys
                : checkedKeys
            }
            onSelect={onSelect}
            checkable={checkable || !!pSetCheckedKeys}
            onCheck={_onCheck}
          />
        </>
      )}
      {treeMode === "filter" && (
        <Space>
          <Button
            type="primary"
            onClick={pOnFilter}
            icon={<SearchOutlined />}
            size="small"
            style={{ width: 90 }}
          >
            Buscar
          </Button>
          <Button onClick={pOnClear} size="small" style={{ width: 90 }}>
            Limpiar
          </Button>
          <Button
            type="link"
            size="small"
            onClick={() => {
              if (pOnClose) pOnClose();
            }}
          >
            Cerrar
          </Button>
        </Space>
      )}
    </>
  );
};
