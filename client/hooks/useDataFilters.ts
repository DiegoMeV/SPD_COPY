import { useEntities } from "../components/Entities/hooks";
import { useCurrentUser } from "../components/Users/hooks";
import { UseFiltersProps } from "./useTable";

const useEntitiesFilter = (props?: UseFiltersProps) => {
  const { data: dataEntities } = useEntities();

  const entitiesFilter = dataEntities?.map((entity) => ({
    text: `${entity?.code} - ${entity?.name}`,
    value: entity?.id,
  }));

  return { entitiesFilter };
};

const useEntitiesByCodeFilter = (props?: UseFiltersProps) => {
  const { data: dataEntities } = useEntities();
  const { isOperator, isValidator, user } = useCurrentUser();

  const entitiesByCodeFilter =
    dataEntities
      ?.filter?.((entity) => (isOperator() || isValidator() ? entity.id === user?.entityId : true))
      ?.map((entity) => ({
        text: `${entity?.name} (${entity?.code})`,
        value: entity?.code,
      })) ?? [];

  return { entitiesByCodeFilter };
};

export { useEntitiesFilter, useEntitiesByCodeFilter };
