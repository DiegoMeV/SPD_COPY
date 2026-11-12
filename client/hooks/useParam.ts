import { useRouter } from "next/router";

export function useRouteParam(paramName: string): string | undefined {
  const router = useRouter();
  const value = router.query[paramName];

  if (Array.isArray(value)) {
    throw new Error(`Expected only a single value for route param '${paramName}'`);
  }

  return value;
}

export function useArrayRouteParam(paramName: string): string[] | undefined {
  const router = useRouter();
  const value = router.query[paramName];

  return !value ? undefined : Array.isArray(value) ? value : [value];
}