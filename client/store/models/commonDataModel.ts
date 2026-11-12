import { Action, action } from "easy-peasy";
import {
  GetGeoLocationsTreeQuery,
  MacroProjectFragment,
  OdsFragment,
  ProductCatalogFragment,
  PublicPoliticComponentFragment,
  PublicPoliticFragment,
  UnitFragment,
} from "../../../graphql/gen/ops";

type LoadingMap = {
  ods: boolean;
  units: boolean;
  publicPolitics: boolean;
  publicPoliticComponents: boolean;
  macroProjects: boolean;
  productCatalog: boolean;
  productSectors: boolean;
  geoLocations: boolean;
};

export type CommonDataModel = {
  ods: OdsFragment[] | undefined;
  units: UnitFragment[] | undefined;
  publicPolitics: PublicPoliticFragment[] | undefined;
  publicPoliticComponents: PublicPoliticComponentFragment[] | undefined;
  macroProjects: MacroProjectFragment[] | undefined;
  productsCatalog: Partial<ProductCatalogFragment>[] | undefined;
  productSectors: Partial<ProductCatalogFragment>[] | undefined;
  geoLocations: GetGeoLocationsTreeQuery["getGeoLocationsTree"] | undefined;
  loading: LoadingMap;
  setLoading: Action<CommonDataModel, Partial<LoadingMap>>;
  setOds: Action<CommonDataModel, OdsFragment[] | undefined>;
  setUnits: Action<CommonDataModel, UnitFragment[] | undefined>;
  setProductCatalog: Action<CommonDataModel, Partial<ProductCatalogFragment>[] | undefined>;
  setProductSectors: Action<CommonDataModel, Partial<ProductCatalogFragment>[] | undefined>;
  setPublicPolitics: Action<CommonDataModel, PublicPoliticFragment[] | undefined>;
  setPublicPoliticComponents: Action<CommonDataModel, PublicPoliticComponentFragment[] | undefined>;
  setMacroProjects: Action<CommonDataModel, MacroProjectFragment[] | undefined>;
  setGeoLocations: Action<
    CommonDataModel,
    GetGeoLocationsTreeQuery["getGeoLocationsTree"] | undefined
  >;
};

export const commonDataModel: CommonDataModel = {
  ods: undefined,
  units: undefined,
  publicPolitics: undefined,
  publicPoliticComponents: undefined,
  macroProjects: undefined,
  productsCatalog: undefined,
  productSectors: undefined,
  geoLocations: undefined,
  loading: {
    ods: false,
    units: false,
    publicPolitics: false,
    publicPoliticComponents: false,
    macroProjects: false,
    productCatalog: false,
    productSectors: false,
    geoLocations: false,
  },
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  setOds: action((state, ods) => {
    state.ods = ods;
  }),
  setUnits: action((state, units) => {
    state.units = units;
  }),
  setProductCatalog: action((state, productCatalog) => {
    state.productsCatalog = productCatalog;
  }),
  setProductSectors: action((state, productSectors) => {
    state.productSectors = productSectors;
  }),
  setPublicPolitics: action((state, publicPolitics) => {
    state.publicPolitics = publicPolitics;
  }),
  setPublicPoliticComponents: action((state, publicPoliticComponents) => {
    state.publicPoliticComponents = publicPoliticComponents;
  }),
  setMacroProjects: action((state, macroProjects) => {
    state.macroProjects = macroProjects;
  }),
  setGeoLocations: action((state, geoLocations) => {
    state.geoLocations = geoLocations;
  }),
};
