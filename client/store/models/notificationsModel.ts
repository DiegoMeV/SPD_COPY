import { action, Thunk, Action, thunk } from "easy-peasy";
import _ from "lodash";
import type { NotificationType } from "../../types/common";

export type Notification = {
  id?: number;
  message: string;
  description: string;
  duration?: number | null;
  type?: NotificationType;
  promise?: Promise<any>;
  resolvePromise?: boolean;
};

const NOTIFICATION_TTL_MS = 4500;
let notificationId = 1;

export type NotificationsModel = {
  data: Notification[];
  sendNotification: Thunk<NotificationsModel, Notification>;
  _addNotification: Action<NotificationsModel, Notification>;
  clearNotification: Action<NotificationsModel, number>;
  closeNotification: Thunk<NotificationsModel, number>;
  getNotification: Thunk<NotificationsModel>;
  popNotification: Action<NotificationsModel>;
};

export const notificationsModel: NotificationsModel = {
  data: [],
  sendNotification: thunk(async (actions, notif, { getState }) => {
    const duration = notif.duration ?? NOTIFICATION_TTL_MS / 1000;
    actions._addNotification({
      ...notif,
      duration,
      id: ++notificationId,
    });

    if (notif.promise) {
      try {
        const result = await notif.promise;
        actions._addNotification({
          ...notif,
          id: ++notificationId,
          duration,
        });
        if (notif.resolvePromise) return result;
      } catch (e) {
        actions._addNotification({
          ...notif,
          duration,
          id: ++notificationId,
          type: "error",
          message: `Failed with error: '${e}'`,
        });
      }
    }
  }),

  _addNotification: action((state, notif) => {
    state.data.push(notif);
  }),

  clearNotification: action((state, notifId) => {
    state.data = state.data.filter((n) => n.id !== notifId);
  }),

  getNotification: thunk((actions, _, { getState }) => {
    const notification = { ...getState().data.pop() };
    actions.popNotification();

    return notification;
  }),

  popNotification: action((state) => {
    state.data.pop();
  }),

  closeNotification: thunk(async (actions, notifId, { getState }) => {
    _.delay(() => {
      actions.clearNotification(notifId);
    }, NOTIFICATION_TTL_MS);
  }),
};
