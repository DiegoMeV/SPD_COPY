import React from "react";
import { Tabs } from "antd";
import type { TabsProps } from "antd";
import { GoalsCatalogHierarchy } from "../GoalsCatalogHierarchy/GoalsCatalogHierarchy";
import { GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { GoalsScheduleList } from "../GoalsSchedule/GoalsScheduleList";
import { GoalsCatalogListForMonitoring } from "../GoalsCatalogList/GoalsCatalogListForMonitoring";
import { useStoreActions } from "../../../store";
import { GoalsCatalogListLoader } from "../GoalsCatalogList/GoalsCatalogListLoader";

type GoalsCatalogProps = {
  stage: MonitoringStatus;
  goalTypes: GoalType[];
};

const GoalsCatalog: React.FC<GoalsCatalogProps> = ({ stage, goalTypes }) => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  const items: TabsProps["items"] = [
    {
      key: "goals-list",
      label: "Listado",
      children:
        stage !== MonitoringStatus.Created ? (
          <GoalsCatalogListForMonitoring goalTypes={goalTypes} stage={stage} />
        ) : (
          <GoalsCatalogListLoader goalTypes={goalTypes} id="goals-catalog" />
        ),
    },
    {
      key: "goals-hierarchy",
      label: "Por Estructura del Plan",
      children:
        stage !== MonitoringStatus.Created ? (
          <GoalsScheduleList stage={stage} goalTypes={goalTypes} />
        ) : (
          <GoalsCatalogHierarchy stage={stage} goalTypes={goalTypes} />
        ),
    },
  ];

  return (
    <Tabs defaultActiveKey="goals-list" items={items} onChange={() => setCurrentGoal(undefined)} />
  );
};

export { GoalsCatalog };
