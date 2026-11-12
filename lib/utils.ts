export function flattenObject(obj: any, prefix = ""): any {
  return Object.keys(obj).reduce((acc: Record<string, any>, key) => {
    const pre = prefix.length ? `${prefix}.` : "";
    if (typeof obj[key] === "object" && obj[key] !== null) {
      Object.assign(acc, flattenObject(obj[key], pre + key));
    } else {
      acc[pre + key] = obj[key];
    }
    return acc;
  }, {});
}

export function getRestApiUrlOrRaise(tenantKey: string): string | undefined {
  if (!process.env?.[`SIIF_REST_API_URL_${tenantKey}`])
    throw new Error(`Variable de entorno SIIF_REST_API_URL_${tenantKey} no se ha definido`);
  return process.env?.[`SIIF_REST_API_URL_${tenantKey}`];
}

export const toCamelCase = (str: string): string => {
  return str.toLowerCase().replace(/_([a-z]|[0-9])/g, (_, letter) => letter.toUpperCase());
};

export const toClassName = (str: string): string => {
  return str
    .split("_")
    .map((s) => s.charAt(0).toUpperCase() + s.slice(1))
    .join("");
};

export const objKeysToCamelCase = (obj: Record<string, any>): Record<string, any> => {
  const acc: Record<string, any> = {};
  Object.entries(obj).forEach(([k, v]) => {
    acc[toCamelCase(k)] = v;
  });
  return acc;
};

export function toSnakeCase(camelCaseString: string): string {
  return camelCaseString
    .replace(/([A-Z])/g, "_$1") // Insert underscore before each uppercase letter
    .toLowerCase(); // Convert the entire string to lowercase
}

export function lpad(value: string, length: number, fill: string): string {
  if (value.length >= length) {
    return value;
  }
  return fill.repeat(length - value.length) + value;
}
