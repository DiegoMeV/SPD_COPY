import { DateTime } from "luxon";

export function round2dp(num: number, dp = 2) {
  return Math.round((num + Number.EPSILON) * Math.pow(10, dp)) / Math.pow(10, dp);
}

export function ratio2percent(num: number) {
  return round2dp((num || 0) * 100);
}

export function date2Str(date: any, format?: string) {
  return DateTime.fromJSDate(date).toLocaleString();
}

export function date2FormattedStr(date: string) {
  const luxonDate = DateTime.fromJSDate(new Date(date));
  return luxonDate.toFormat("yyyy-MM-dd HH:mm:ss");
}

export function dateFromStr(date: string, options?: any) {
  return DateTime.fromISO(date).setLocale("es").toLocaleString(options);
}

export function dateFromFormat(date: string, format: string, options?: any) {
  return DateTime.fromFormat(date, format).toJSDate();
}

export function num2Str(num: number) {
  return num?.toLocaleString("en-US");
}

export function str2Money(value: string) {
  return `$ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

export function str2Number(value: string): number {
  return parseFloat(`${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ","));
}

export function num2Money(value: number) {
  return str2Money(`${value}`);
}

export function lastDayOfSubperiod(period: number, subperiod: number, periodicity?: number) {
  const date = DateTime.fromObject({ year: period, month: subperiod * (periodicity ?? 3), day: 1 });
  return date.endOf("month").toFormat("ddMMyyyy");
}
