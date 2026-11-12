import React from "react";
import { Flex, Progress } from "antd";
import { ColorsConfigType } from "../../types/monitoringConfig";

type Props = {
  colorsConfig: ColorsConfigType;
};

const MonitoringConfigColors: React.FC<Props> = ({ colorsConfig }) => {
  const strokeColor: Record<string, string> = {};
  const colorsConfigNotNull = colorsConfig?.filter((colorConfig) => colorConfig.toValue != null);
  if ((colorsConfigNotNull ?? []).length === 0) return <></>;
  return (
    <Flex vertical gap="small">
      <Flex>
        {colorsConfig?.map((colorConfig, index) => {
          strokeColor[`${colorConfig.fromValue + (colorConfig.includeFromValue ? 0 : 0.01)}%`] =
            colorConfig.color;
          strokeColor[`${colorConfig.toValue}%`] = colorConfig.color;
          return (
            <div
              key={index}
              style={{
                width: `${colorConfig.toValue - colorConfig.fromValue}%`,
                textAlign: "center",
              }}
            >
              {colorConfig.label}:{" "}
              {`${colorConfig.includeFromValue ? "[" : "("}${colorConfig.fromValue}-${
                colorConfig.toValue
              }]`}
            </div>
          );
        })}
      </Flex>
      <Progress strokeWidth={25} percent={100} showInfo={false} strokeColor={strokeColor} />
    </Flex>
  );
};

export { MonitoringConfigColors };
