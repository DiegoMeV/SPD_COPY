import React from "react";
import { Avatar, Typography } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { MonitoringStatus } from "../../../../graphql/gen/schema";
import { monitoringStatusMap } from "../../../utils/uiUtils";
import { faCalendarCheck } from "@fortawesome/free-solid-svg-icons";

type ButtonStatusProps = {
  title?: string;
  type: MonitoringStatus;
};

const MonitoringGoalStatus: React.FC<ButtonStatusProps> = ({ type, title }) => {
  return (
    <>
      <Avatar
        shape="circle"
        icon={
          <FontAwesomeIcon
            icon={monitoringStatusMap[type]?.icon ?? faCalendarCheck}
            color={monitoringStatusMap[type]?.color}
          />
        }
        style={{ backgroundColor: "#ffffff", border: "1px solid #f0f0f0" }}
        size={"small"}
      ></Avatar>
      <Typography.Text style={{ margin: "0 5px" }}>
        {title ?? monitoringStatusMap[type]?.tag}
      </Typography.Text>
    </>
  );
};

export { MonitoringGoalStatus };
