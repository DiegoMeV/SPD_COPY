import { Action, action } from "easy-peasy";
import { EntityFragment } from "../../../graphql/gen/ops";
import { SearchEntity } from "../../../graphql/gen/schema";

type LoadingMap = {
  entities: boolean;
};

export type EntityModel = {
  data: EntityFragment[] | undefined;
  searchEntityVariables: SearchEntity;
  loading: LoadingMap;
  setLoading: Action<EntityModel, Partial<LoadingMap>>;
  setData: Action<EntityModel, EntityFragment[] | undefined>;
  setSearchEntityVariables: Action<EntityModel, SearchEntity>;
};

export const entityModel: EntityModel = {
  data: undefined,
  searchEntityVariables: {},
  loading: {
    entities: false,
  },
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  setData: action((state, entities) => {
    state.data = entities;
  }),
  setSearchEntityVariables: action((state, searchEntityVariables) => {
    state.searchEntityVariables = searchEntityVariables;
  }),
};
