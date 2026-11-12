import React, { useState, useRef, useEffect } from "react";
import { Form, Tabs, Tooltip, Modal, Typography, Alert, Space } from "antd";
import type { TabsProps } from "antd";
import { faPlus } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import { useGoal } from "../../Goals/hooks";
import { MonitoringTrackTargetEDForm } from "./MonitoringTrackTagetEDForm";
import { MonitoringTrackTargetOrgForm } from "./MonitoringTrackTargetOrgForm";
import { MonitoringTrackTargetREForm } from "./MonitoringTrackTargetREForm";

const { confirm } = Modal;
const { Text } = Typography;

const NEW_TAB_PREFIX = "localizationTab";

type TargetKey = React.MouseEvent | React.KeyboardEvent | string;

const defaultPanes: TabsProps["items"] = [];

type Props = {
  formItemPath: string[];
  tabChildrenComponent:
    | "MonitoringTrackTargetEDForm"
    | "MonitoringTrackTargetOrgForm"
    | "MonitoringTrackTargetREForm";
  description: string;
  disabled?: boolean;
};

const MonitoringTrackByLocalization: React.FC<Props> = ({
  formItemPath,
  tabChildrenComponent,
  description,
  disabled = false,
}) => {
  const [activeKey, setActiveKey] = useState(defaultPanes?.[0]?.key);
  const [activeLabel, setActiveLabel] = useState<string>();
  const [items, setItems] = useState(defaultPanes);
  const [formMatrixLoaded, setFormMatrixLoaded] = useState(false);
  const { currentGoal } = useGoal();
  const newTabIndex = useRef(0);

  const form = Form.useFormInstance();
  const localizationMatrixTabs: Record<string, any> = form.getFieldValue(formItemPath);

  const DummyComponent: React.FC<any> = () => {
    return <></>;
  };
  const ChildrenComponent =
    tabChildrenComponent === "MonitoringTrackTargetEDForm"
      ? MonitoringTrackTargetEDForm
      : tabChildrenComponent === "MonitoringTrackTargetOrgForm"
        ? MonitoringTrackTargetOrgForm
        : tabChildrenComponent === "MonitoringTrackTargetREForm"
          ? MonitoringTrackTargetREForm
          : DummyComponent;

  useEffect(() => {
    setActiveTabLabel(activeLabel ?? "");

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [activeLabel]);

  useEffect(() => {
    if (currentGoal?.id) setFormMatrixLoaded(false);
  }, [currentGoal?.id]);

  useEffect(() => {
    if (!formMatrixLoaded) {
      let maxIndex = 0;
      const newItems = Object.entries(localizationMatrixTabs ?? {}).map(([k, v]) => {
        const index = parseInt(k.replace(NEW_TAB_PREFIX, ""));

        if (index > maxIndex) maxIndex = index;
        return {
          key: k,
          label: v.localizationLabel ?? k,
          children: <ChildrenComponent id={k} onLocationChange={setTabLocation} />,
        };
      });

      newTabIndex.current = maxIndex + 1;
      setItems(newItems);
      setActiveKey(newItems?.[0]?.key);
      setFormMatrixLoaded(true);
    }
  }, [localizationMatrixTabs, formMatrixLoaded]);

  const onChange = (key: string) => {
    setActiveKey(key);
  };

  const setActiveTabLabel = (label: string) => {
    const tabIndex = items.findIndex((item) => item.key === activeKey);
    if (tabIndex >= 0) {
      setItems([
        ...items.slice(0, tabIndex),
        { ...items[tabIndex], label },
        ...items.slice(tabIndex + 1),
      ]);
      form.setFieldValue([...formItemPath, activeKey, "localizationLabel"], label);
    }
  };

  const setTabLocation = (ids?: number[], labels?: React.ReactNode[]) => {
    const locationsLabel = labels?.map((label) => label?.toString()).join(" - ") ?? "";
    setActiveLabel(locationsLabel ?? "");
  };

  const add = () => {
    const newActiveKey = `${NEW_TAB_PREFIX}${newTabIndex.current++}`;
    setItems([
      ...items,
      {
        label: "Localización?",
        children: <ChildrenComponent id={newActiveKey} onLocationChange={setTabLocation} />,
        key: newActiveKey,
      },
    ]);
    setActiveKey(newActiveKey);
  };

  const remove = (targetKey: TargetKey) => {
    const onOk = () => {
      const targetIndex = items.findIndex((pane) => pane.key === targetKey);
      const newPanes = items.filter((pane) => pane.key !== targetKey);
      if (newPanes.length && targetKey === activeKey) {
        const { key } = newPanes[targetIndex === newPanes.length ? targetIndex - 1 : targetIndex];
        setActiveKey(key);
      }
      setItems(newPanes);
    };

    const item = items.find((pane) => pane.key === targetKey);
    confirm({
      title: "Eliminar focalización",
      content: (
        <span>
          Está seguro(a) que desea eliminar los datos de {description} para{" "}
          <Text strong>{item?.label}?</Text>
        </span>
      ),
      icon: <ExclamationCircleOutlined />,
      okText: "Confirmar",
      okType: "primary",
      cancelText: "Cancelar",
      onOk: onOk,
    });
  };

  const onEdit = (targetKey: TargetKey, action: "add" | "remove") => {
    if (action === "add") {
      add();
    } else {
      remove(targetKey);
    }
  };

  return (
    <div style={{ minHeight: "400px" }}>
      {!disabled && (
        <Space direction="vertical" size="middle" style={{ display: "flex" }}>
          <Alert
            message="Por favor haga clic en el botón + para registrar los datos de focalización."
            description="Debe ingresar primero la localización (municipio, comuna, corregimiento, barrio o vereda) a la que pertenecen los datos a registrar."
            type="info"
            showIcon
            closable
          />
          <Tabs
            onChange={onChange}
            activeKey={activeKey}
            type="editable-card"
            onEdit={onEdit}
            items={items}
            addIcon={
              <Tooltip title={`Adicionar datos de ${description}`}>
                <FontAwesomeIcon icon={faPlus} style={{ height: "18px" }} color="#1677ff" />
              </Tooltip>
            }
          />
        </Space>
      )}
    </div>
  );
};

export { MonitoringTrackByLocalization };
