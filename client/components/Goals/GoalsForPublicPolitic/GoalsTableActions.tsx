import { Button, Space, Typography } from "antd";
import React from "react";
import { ButtonDelete } from "../../Buttons";
import { useDeleteGoal, useGoal } from "../hooks";
import { Goal, SchedulingGoal } from "../../../types/goal";
import { GoalEdit } from "../GoalEdit";
import { SPDRole } from "@prisma/client";
import { useStoreState } from "../../../store";
import { MonitoringConfigUsedFor } from "../../../../graphql/gen/schema";

type Props = {
  goal: Goal;
  supportScheduling?: boolean;
  onClickScheduling?: (goal: SchedulingGoal) => void;
  onSelectRow?: () => void;
};

const { Title } = Typography;

const GoalsTableActions: React.FC<Props> = ({
  goal,
  supportScheduling,
  onSelectRow,
}) => {
  const { deleteGoal, loading } = useDeleteGoal({ usedFor: MonitoringConfigUsedFor.PublicPolitics });
  const { setCurrentGoal } = useGoal();
  const currentUser = useStoreState((state) => state.user.data);

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      {!supportScheduling && <GoalEdit goal={goal} usedFor={MonitoringConfigUsedFor.PublicPolitics} />}
      {supportScheduling && (
        <Button
          onClick={() => {
            setCurrentGoal(goal);
            onSelectRow?.();
          }}
          disabled={
            !(
              currentUser?.entityId === goal.entityId ||
              currentUser?.role === SPDRole.AUDITOR ||
              currentUser?.role === SPDRole.ADMIN
            )
          }
        >
          Programación
        </Button>
      )}
      {!supportScheduling && (
        <ButtonDelete
          message="Está seguro de eliminar esta acción?"
          description={
            <span>
              La acción{" "}
              <Title style={{ display: "inline" }} level={5}>
                {goal.code} {goal.name}
              </Title>{" "}
              se eliminará de forma permanente, desea continuar?
            </span>
          }
          onDelete={() => {
            deleteGoal(goal.id);
          }}
          loading={loading}
        />
      )}
    </Space>
  );
};

export { GoalsTableActions };
