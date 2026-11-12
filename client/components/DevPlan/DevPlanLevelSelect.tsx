import React, { useState, useEffect } from "react";
import { Select, Spin } from "antd";
import { useDevPlan } from "./hooks";
import { useStoreState } from "../../store";
import { DevPlanConfigLevel } from "../../types/devPlan";

const { Option } = Select;

type Props = {
  devPlanId: number;
  value?: number;
  labelKey?: "plural" | "singular";
  onChange?: (value?: number) => void;
  disabled?: boolean;
  width?: number | string;
};

const DevPlanLevelSelect: React.FC<Props> = ({
  devPlanId,
  value,
  labelKey = "plural",
  onChange,
  disabled = false,
  width = 400,
}) => {
  const devPlans = useStoreState((state) => state.devPlan.data);
  const loadingDevPlan = useStoreState((state) => state.devPlan.loading);
  const { getDevPlans } = useDevPlan();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!devPlans) {
      getDevPlans();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [devPlans]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onWeightingTypeChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loadingDevPlan.devPlans) return <Spin />;

  return (
    <span>
      <Select style={{ width }} onChange={onWeightingTypeChange} value={value} disabled={disabled}>
        {devPlans
          ?.find((devPlan) => devPlan.id === devPlanId)
          ?.config?.levels?.map((level: DevPlanConfigLevel) => (
            <Option value={level.number} key={`devPlanLevel${level.number}`}>
              {level[`${labelKey}Name`]}
            </Option>
          ))}
      </Select>
    </span>
  );
};

export { DevPlanLevelSelect };
