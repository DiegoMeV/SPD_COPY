import React from "react";
import { Collapse, Typography } from "antd";
import { GoalDetails } from "./";
import { Goal } from "../../types/goal";
import { useCurrentGoal } from "./hooks";

type Props = {
  goal: Goal;
};

const { Panel } = Collapse;
const { Text } = Typography;

export const GoalSummary: React.FC<Props> = ({ goal }) => {
  const { isProjectGoal, isActionPlanGoal } = useCurrentGoal();
  if (!goal) return null;

  const PanelHeader = () => (
    <>
      <Text strong>{goal.code}</Text>
      {!(isProjectGoal() || isActionPlanGoal()) && (
        <>
          <Text strong>: </Text>
          <Text>{goal.name ?? goal.indicator}</Text>
        </>
      )}
    </>
  );
  return (
    <Collapse>
      <Panel header={<PanelHeader />} key={`Goal${goal.id}`}>
        <GoalDetails goal={goal} mode="embed" />
      </Panel>
    </Collapse>
  );
};
