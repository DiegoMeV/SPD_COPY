import React, { useEffect } from "react";
import { GoalsScheduleList } from "../../../../client/components/Goals/GoalsSchedule/GoalsScheduleList";
import { useStoreActions } from "../../../../client/store";

const GoalsSchedulePage: React.FC = () => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return <GoalsScheduleList />;
};

export default GoalsSchedulePage;
