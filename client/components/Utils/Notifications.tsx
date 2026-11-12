import React, { useEffect } from "react";
import { notification } from "antd";
import { useStoreState, useStoreActions } from "../../store";
import { Notification } from "../../store/models/notificationsModel";

export const Notifications = () => {
  const notifications = useStoreState((state) => state.notifications.data);
  const getNotification = useStoreActions((actiions) => actiions.notifications.getNotification);

  useEffect(() => {
    for (let i = 1; i <= notifications?.length; i++) {
      const not: Notification = getNotification();
      notification[not.type || "info"]({
        message: not.message,
        description: not.description,
        duration: not.duration,
      });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [notifications]);

  return <></>;
};
