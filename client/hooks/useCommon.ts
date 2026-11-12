import { apolloClient } from "../lib/apollo";
import { useStoreState, useStoreActions } from "../store";
import {
  GetOdssQuery,
  GetUnitsQuery,
  GetPublicPoliticsQuery,
  GetProductIndicatorsQuery,
  GetProductSectorsQuery,
  GetPublicPoliticComponentsQuery,
  GetMacroProjectsQuery,
  GetGeoLocationsTreeQuery,
} from "../../graphql/gen/ops";
import {
  GetOdssDocument,
  GetUnitsDocument,
  GetPublicPoliticsDocument,
  GetProductIndicatorsDocument,
  GetProductSectorsDocument,
  GetPublicPoliticComponentsDocument,
  GetMacroProjectsDocument,
  GetGeoLocationsTreeDocument,
} from "../../graphql/gen/hooks";

const useCommonData = () => {
  const ods = useStoreState((state) => state.common.ods);
  const units = useStoreState((state) => state.common.units);
  const productsCatalog = useStoreState((state) => state.common.productsCatalog);
  const productSectors = useStoreState((state) => state.common.productSectors);
  const publicPolitics = useStoreState((state) => state.common.publicPolitics);
  const publicPoliticComponents = useStoreState((state) => state.common.publicPoliticComponents);
  const macroProjects = useStoreState((state) => state.common.macroProjects);
  const geoLocations = useStoreState((state) => state.common.geoLocations);
  const setOds = useStoreActions((actions) => actions.common.setOds);
  const setUnits = useStoreActions((actions) => actions.common.setUnits);
  const setProductCatalog = useStoreActions((actions) => actions.common.setProductCatalog);
  const setProductSectors = useStoreActions((actions) => actions.common.setProductSectors);
  const setPublicPolitics = useStoreActions((actions) => actions.common.setPublicPolitics);
  const setPublicPoliticComponents = useStoreActions(
    (actions) => actions.common.setPublicPoliticComponents,
  );
  const setMacroProjects = useStoreActions((actions) => actions.common.setMacroProjects);
  const setGeoLocations = useStoreActions((actions) => actions.common.setGeoLocations);
  const setLoading = useStoreActions((actions) => actions.common.setLoading);

  const getOds = async () => {
    if (ods) return ods;
    setLoading({ ods: true });
    const query = await apolloClient.query<GetOdssQuery>({
      query: GetOdssDocument,
    });
    setLoading({ ods: false });
    setOds(query?.data?.getOdss ?? undefined);
  };

  const getUnits = async () => {
    if (units) return units;
    setLoading({ units: true });
    const query = await apolloClient.query<GetUnitsQuery>({
      query: GetUnitsDocument,
    });
    setLoading({ units: false });
    setUnits(query?.data?.getUnits ?? undefined);
  };
  const getProductsCatalog = async () => {
    if (productsCatalog) return productsCatalog;
    setLoading({ productCatalog: true });
    const query = await apolloClient.query<GetProductIndicatorsQuery>({
      query: GetProductIndicatorsDocument,
    });
    setLoading({ productCatalog: false });
    setProductCatalog(query?.data?.getProductIndicators?.items);
  };
  const getProductSectors = async () => {
    if (productSectors) return productSectors;
    setLoading({ productSectors: true });
    const query = await apolloClient.query<GetProductSectorsQuery>({
      query: GetProductSectorsDocument,
    });
    setLoading({ productSectors: false });
    setProductSectors(query?.data?.getProductSectors?.items);
  };
  const getPublicPolitics = async () => {
    if (publicPolitics) return publicPolitics;
    setLoading({ publicPolitics });
    const query = await apolloClient.query<GetPublicPoliticsQuery>({
      query: GetPublicPoliticsDocument,
    });
    setLoading({ publicPolitics: false });
    setPublicPolitics(query?.data?.getPublicPolitics ?? undefined);
  };
  const getPublicPoliticComponents = async () => {
    if (publicPoliticComponents) return publicPoliticComponents;
    setLoading({ publicPoliticComponents });
    const query = await apolloClient.query<GetPublicPoliticComponentsQuery>({
      query: GetPublicPoliticComponentsDocument,
    });
    setLoading({ publicPoliticComponents: false });
    setPublicPoliticComponents(query?.data?.getPublicPoliticComponents ?? undefined);
  };
  const getMacroProjects = async () => {
    if (macroProjects) return macroProjects;
    setLoading({ macroProjects });
    const query = await apolloClient.query<GetMacroProjectsQuery>({
      query: GetMacroProjectsDocument,
    });
    setLoading({ macroProjects: false });
    setMacroProjects(query?.data?.getMacroProjects ?? undefined);
  };
  const getGeoLocations = async () => {
    if (geoLocations) return geoLocations;
    setLoading({ geoLocations });
    const query = await apolloClient.query<GetGeoLocationsTreeQuery>({
      query: GetGeoLocationsTreeDocument,
    });
    setLoading({ geoLocations: false });
    setGeoLocations(query?.data?.getGeoLocationsTree ?? undefined);
  };

  return {
    getOds,
    getUnits,
    getPublicPolitics,
    getProductsCatalog,
    getProductSectors,
    getPublicPoliticComponents,
    getMacroProjects,
    getGeoLocations,
  };
};

export { useCommonData };
