import React, { useEffect } from "react";
import { useStoreActions } from "../../client/store";

const NotificationPage: React.FC = () => {
  const sendNotification = useStoreActions((actions) => actions.notifications.sendNotification);

  useEffect(() => {
    const tId = setTimeout(() => {
      sendNotification({
        type: "info",
        message: "Notification",
        description: "This is a notification",
        promise: new Promise((resolve, reject) => {
          setTimeout(() => {
            resolve("Success...!!!!");
          }, 3000);
        }),
      });
    }, 2000);
    return () => clearTimeout(tId);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  return <></>;
};

export default NotificationPage;
