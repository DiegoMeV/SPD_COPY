import { Action, action } from "easy-peasy";
import { GetSiifActividadMetasQuery, GetSiifActividadesQuery, SearchSiifProyectosQuery } from "../../../graphql/gen/ops";
import { SearchSiifProyecto } from "../../../graphql/gen/schema";

export type SiifProyectoRecord = NonNullable<SearchSiifProyectosQuery["searchSiifProyectos"]>["items"][number];
export type SiifActividadRecord = NonNullable<NonNullable<GetSiifActividadesQuery["getSiifActividades"]>>[number];
export type SiifActividadMetaRecord = NonNullable<NonNullable<GetSiifActividadMetasQuery["getSiifActividadMetas"]>>[number];
export type SiifActividadMetaAccionRecord = NonNullable<NonNullable<GetSiifActividadMetasQuery["getSiifActividadMetas"]>>[number]["acciones"];

export type SiifProyectoModel = {
    selectedSiifProyecto: SiifProyectoRecord | undefined;
    searchSiifProyectoQueryVariables: SearchSiifProyecto;
    setSelectedSiifProyecto: Action<SiifProyectoModel, SiifProyectoRecord | undefined>;
    selectedSiifActividad: SiifActividadRecord | undefined;
    selectedSiifActividadMeta: SiifActividadMetaRecord | undefined;
    setSelectedSiifActividad: Action<SiifProyectoModel, SiifActividadRecord | undefined>;
    setSelectedSiifActividadMeta: Action<SiifProyectoModel, SiifActividadMetaRecord | undefined>;
    setSearchSiifProyectoQueryVariables: Action<SiifProyectoModel, SearchSiifProyecto>;
};

export const siifProyectoModel: SiifProyectoModel = {
    selectedSiifProyecto: undefined,
    searchSiifProyectoQueryVariables: {},
    setSelectedSiifProyecto: action((state, siifProyecto) => {
        state.selectedSiifProyecto = siifProyecto;
    }),
    selectedSiifActividad: undefined,
    selectedSiifActividadMeta: undefined,
    setSelectedSiifActividad: action((state, siifActividad) => {
        state.selectedSiifActividad = siifActividad;
    }),
    setSelectedSiifActividadMeta: action((state, siifActividadMeta) => {
        state.selectedSiifActividadMeta = siifActividadMeta;
    }),
    setSearchSiifProyectoQueryVariables: action((state, queryVariables) => {
        state.searchSiifProyectoQueryVariables = queryVariables;
    }),
};
