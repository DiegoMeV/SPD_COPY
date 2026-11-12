import { Action, action } from "easy-peasy";
import {
  SearchProyectosQuery,
  GetProyectoQuery,
  GetProyectosForScheduleQuery,
} from "../../../graphql/gen/ops";
import { SearchProyecto } from "../../../graphql/gen/schema";

export type ProyectoRecord = NonNullable<GetProyectoQuery["getProyecto"]>;
export type ProyectoForScheduleRecord = NonNullable<
  NonNullable<GetProyectosForScheduleQuery["getProyectosForSchedule"]>["items"]
>[number] & { totalResources?: number };

export type ProyectoModel = {
  selectedProyecto: ProyectoRecord | undefined;
  searchProyectosQueryVariables: SearchProyecto;
  setSelectedProyecto: Action<ProyectoModel, ProyectoRecord | undefined>;
  setSearchProyectoQueryVariables: Action<ProyectoModel, SearchProyecto>;
};

export const proyectoModel: ProyectoModel = {
  selectedProyecto: undefined,
  searchProyectosQueryVariables: {},
  setSelectedProyecto: action((state, proyecto) => {
    state.selectedProyecto = proyecto;
  }),
  setSearchProyectoQueryVariables: action((state, queryVariables) => {
    state.searchProyectosQueryVariables = queryVariables;
  }),
};
