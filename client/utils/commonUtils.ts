import _ from "lodash";

export function omitNulls(o: any) {
  return _.mapValues(o, (v, k) => v ?? 0);
}
