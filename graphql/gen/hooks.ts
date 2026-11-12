import * as Types from "./ops";

import { gql } from "@apollo/client";
import * as Apollo from "@apollo/client";
const defaultOptions = {} as const;
export const MonitoringConfigFragmentDoc = gql`
  fragment MonitoringConfig on MonitoringConfig {
    id
    createdAt
    updatedAt
    devPlanId
    isActive
    period
    subperiod
    periodicity
    spentDocs
    weightingType
    status
    statusDates
    datesConfig
    colorsConfig
    monitoringResourcesOrigin
    supportProductMonitoring
    sgpDiscriminated
    usedFor
    goalTypes
  }
`;
export const OdsFragmentDoc = gql`
  fragment Ods on Ods {
    id
    name
  }
`;
export const UnitFragmentDoc = gql`
  fragment Unit on Unit {
    id
    name
    initials
  }
`;
export const GoalTypeCountFragmentDoc = gql`
  fragment GoalTypeCount on GoalTypeCount {
    goalType
    count
  }
`;
export const PublicPoliticComponentFragmentDoc = gql`
  fragment PublicPoliticComponent on PublicPoliticComponent {
    id
    code
    name
    description
    isActive
    createdAt
    updatedAt
  }
`;
export const PublicPoliticFragmentDoc = gql`
  fragment PublicPolitic on PublicPolitic {
    id
    createdAt
    updatedAt
    category
    code
    name
    description
    isActive
    fromYear
    toYear
  }
`;
export const ProductCatalogFragmentDoc = gql`
  fragment ProductCatalog on ProductCatalog {
    id
    createdAt
    updatedAt
    isActive
    code
    name
    description
    unitsName
    parentId
    isPrincipal
    isNational
    isTerritorial
    isLeaf
  }
`;
export const UserLoggedInFragmentDoc = gql`
  fragment UserLoggedIn on UserLoggedIn {
    id
    createdAt
    updatedAt
    tenantId
    email
    docNumber
    firstName
    lastName
    phone
    isActive
    entityId
    role
    token
    tenant {
      key
      name
    }
    entity {
      hasManualBudget
      name
      code
    }
  }
`;
export const GetGoalTypeStatsResponseFragmentDoc = gql`
  fragment GetGoalTypeStatsResponse on GetGoalTypeStatsResponse {
    goalType
    total
    scheduled
    noScheduled
    reported
    noReported
  }
`;
export const SiifProyectoFragmentDoc = gql`
  fragment SiifProyecto on SiifProyecto {
    id
    createdAt
    updatedAt
    plan
    programa
    sector
    eje
    nitCompania
    proyecto
    nombre
    fechaRegistro
    objetivos
    descripcion
    presentadoPor
    fechaEvaluacion
    evaluadoPor
    valor
    verDesde
    estado
    codigoEntPry
    vialibilizadoPor
    fechaViabilidad
    estadoProceso
    usuario
    fechaCreacion
    observacion
    subprograma
    idEntidadPresenta
  }
`;
export const GoalFragmentDoc = gql`
  fragment Goal on Goal {
    id
    createdAt
    updatedAt
    devPlanLevelId
    parentGoalId
    code
    name
    isActive
    entityId
    extraEntityIds
    goalType
    indicator
    description
    accumulationType
    baseValue
    goalValue
    unitsFactor
    unitsName
    piBaseValue
    piGoalValue
    piUnitsFactor
    piUnitsName
    isBaseValueNotAvailable
    odsIds
    publicPoliticId
    publicPoliticComponentId
    peacePoliticId
    victimsPoliticId
    productCatalogId
    startDate
    endDate
    weighting
    macroProjectId
    formula
    projectCode
  }
`;
export const EntityFragmentDoc = gql`
  fragment Entity on Entity {
    id
    createdAt
    updatedAt
    code
    name
    isActive
    hasManualBudget
    startDate
    endDate
    parentId
  }
`;
export const VActividadesPryWithGoalsFragmentDoc = gql`
  fragment VActividadesPryWithGoals on VActividadesPryWithGoals {
    nitCompania
    plan
    proyecto
    nombreProyecto
    codigoAct
    descripcion
    etapa
    componente
    codigoUnd
    cantidad
    activa
    id
    idMeta
    idProducto
    descripcionTxt
    nombreMeta
    codigoMeta
    nombreProducto
    codigoProducto
    goal {
      ...Goal
      entity {
        ...Entity
      }
    }
    linkedGoalId
    linkedGoal {
      ...Goal
      entity {
        ...Entity
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
`;
export const DevPlanLevelFragmentDoc = gql`
  fragment DevPlanLevel on DevPlanLevel {
    id
    key
    createdAt
    updatedAt
    devPlanId
    code
    name
    isActive
    parentId
    weighting
    level
    productCatalogId
  }
`;
export const DevPlanFragmentDoc = gql`
  fragment DevPlan on DevPlan {
    id
    createdAt
    updatedAt
    code
    name
    isActive
    startDate
    endDate
    governmentName
    governmentStartDate
    governmentEndDate
    config
    goalActivitySource
  }
`;
export const GoalHistoryFragmentDoc = gql`
  fragment GoalHistory on GoalHistory {
    id
    goalId
    monitoringRecordId
    event
    description
    createdAt
    createdBy
  }
`;
export const MonitoringRecordFragmentDoc = gql`
  fragment MonitoringRecord on MonitoringRecord {
    id
    createdAt
    updatedAt
    monitoringConfigId
    goalId
    period
    goalValue
    piGoalValue
    fromMonth
    toMonth
    goalAchievedValue
    piGoalAchievedValue
    recordStatus
    weighting
    notes
    questionHow
    questionResult
    questionEvidence
    questionProblem
    physicalIndicator
    totalPeople
    targetMatrix
    createdAt
    createdBy
    updatedAt
    updatedBy
  }
`;
export const UserAccountFragmentDoc = gql`
  fragment UserAccount on UserAccount {
    id
    createdAt
    updatedAt
    tenantId
    email
    docNumber
    firstName
    lastName
    phone
    isActive
    entityId
    role
  }
`;
export const MonitoringRecordResourceFragmentDoc = gql`
  fragment MonitoringRecordResource on MonitoringRecordResource {
    id
    monitoringRecordId
    resourceType
    capital
    cd
    cn
    credit
    de
    operation
    management
    monopoly
    others
    rp
    sgp
    sgpEducation
    sgpHealt
    sgpWater
    sgpCulture
    sgpSport
    sgpFreeInvestment
    sgpFreeDestination
    sgpSchoolFeeding
    sgpMagdalenaRiver
    sgpEarlyChildhood
    sgr
    resourcesTotal
    financialIndicator
    createdAt
    createdBy
    updatedAt
    updatedBy
  }
`;
export const SiifActividadMetaFragmentDoc = gql`
  fragment SiifActividadMeta on SiifActividadMeta {
    id
    createdAt
    updatedAt
    nitCompania
    proyecto
    codigoAct
    goalId
    weighting
  }
`;
export const MonitoringRecordWithStatusFragmentDoc = gql`
  fragment MonitoringRecordWithStatus on MonitoringRecordWithStatus {
    id
    createdAt
    updatedAt
    monitoringConfigId
    goalId
    period
    goalValue
    piGoalValue
    fromMonth
    toMonth
    goalAchievedValue
    piGoalAchievedValue
    recordStatus
    goalStatus
    weighting
    notes
    questionHow
    questionResult
    questionEvidence
    questionProblem
    physicalIndicator
    createdAt
    createdBy
    updatedAt
    updatedBy
  }
`;
export const MonitoringRecordAttachmentFragmentDoc = gql`
  fragment MonitoringRecordAttachment on MonitoringRecordAttachment {
    id
    createdAt
    updatedAt
    monitoringRecordId
    s3Path
    name
    description
    createdBy
    updatedBy
  }
`;
export const VActividadesPryFragmentDoc = gql`
  fragment VActividadesPry on VActividadesPry {
    nitCompania
    plan
    proyecto
    nombreProyecto
    codigoAct
    descripcion
    etapa
    componente
    codigoUnd
    cantidad
    activa
    id
    idMeta
    idProducto
    descripcionTxt
    nombreMeta
    codigoMeta
    nombreProducto
    codigoProducto
  }
`;
export const ProyectoFragmentDoc = gql`
  fragment Proyecto on Proyecto {
    item
    plan
    programa
    sector
    eje
    nitCompania
    proyecto
    nombre
    avanceCualitativo
    rubroFut
    ano
    codigo
    fechaRegistro
    objetivos
    descripcion
    presentadoPor
    formuladoPor
    fechaEvaluacion
    evaluadoPor
    valor
    verDesde
    estado
    codigoEntPry
    codPrograma
    codSector
    subprogramaPry
    migrado
    codigoEntPryPresen
    recurso1
    recurso2
    valRec1
    valRec2
    metaProducto
    recurso3
    valRec3
    ficticio
    estadoProceso
    usuario
    fechaCreacion
    observacion
    subprograma
    fechaViabilidad
    viabilizadoPor
    idSesion
    idEntidadPresenta
    viableTecnicamente
    viableEconomicamente
    viableFinancieramente
    viableInstitucionalmente
    viableAmbientalmente
    viableSostenibilidad
    nombreProyecto
    idPlan
    descPlan
    diaRegistro
    mesRegistro
    txtMesRegistro
    nombreMesRegistro
    anoRegistro
    vigencia
    fechaRadicacion
    fechaRadicacionFmt
    idSubprograma
    descSubprograma
    descSubprogramaCap
    nombreSubprograma
    descPrograma
    descProgramaCap
    nombrePrograma
    nombreSector
    descSector
    descSectorCap
    codigoSectorFut
    nombreSectorFut
    descSectorFut
    descSectorFutCap
    descEje
    nombreEje
    descEjeCap
    valorProyecto
    valorProyectoFmt
    valorVigencia
    valorVigenciaFmt
    idEntidad
    nombreEntPry
    nombreentidad
    nombreEntidad
    nombresecretaria
    nombreSecretaria
    fechaDev
    fechaAct
    presupuestoDef
    presupuestoDefFmt
    solicitudAcum
    solicitudAcumFmt
    saldoPpto
    saldoPptoFmt
    viableTecnicamenteTxt
    viableEconomicamenteTxt
    viableFinancieramenteTxt
    viableInstitucionalmenteTxt
    viableAmbientalmenteTxt
    viableSostenibilidadTxt
    firmaUsuario
    codigoEntidadPresenta
    nombreEntidadPresenta
    vigenciaInicial
    vigenciaFinal
    emailDestinatarios
  }
`;
export const GoalDataFragmentDoc = gql`
  fragment GoalData on Goal {
    ...Goal
    entity {
      ...Entity
    }
    devPlanLevel {
      ...DevPlanLevel
      devPlan {
        ...DevPlan
      }
    }
    history {
      ...GoalHistory
      monitoringRecord {
        ...MonitoringRecord
      }
      createdByAccount {
        ...UserAccount
      }
    }
    schedule {
      ...MonitoringRecord
      resources {
        ...MonitoringRecordResource
      }
    }
    tracking {
      ...MonitoringRecord
      resources {
        ...MonitoringRecordResource
      }
    }
    activities {
      ...SiifActividadMeta
    }
    monitoringRecords {
      ...MonitoringRecordWithStatus
      attachments {
        ...MonitoringRecordAttachment
        downloadLink
      }
    }
    actividad {
      ...VActividadesPry
    }
    proyecto {
      ...Proyecto
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanLevelFragmentDoc}
  ${DevPlanFragmentDoc}
  ${GoalHistoryFragmentDoc}
  ${MonitoringRecordFragmentDoc}
  ${UserAccountFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
  ${SiifActividadMetaFragmentDoc}
  ${MonitoringRecordWithStatusFragmentDoc}
  ${MonitoringRecordAttachmentFragmentDoc}
  ${VActividadesPryFragmentDoc}
  ${ProyectoFragmentDoc}
`;
export const InsumoFragmentDoc = gql`
  fragment Insumo on InsumosPry {
    nitCompania
    proyecto
    codigoAct
    codigoIns
    tipoInsumo
    subtipoInsumo
    nombreSubtipo
    codigoUnd
    valor1995
    valor1996
    valor1997
    valor1998
    valor1999
    valor2000
    valor2001
    valor2002
    valor2003
    valor2004
    valor2005
    valor2006
    valor2007
    valor2008
    valor2009
    valor2010
    valor2011
    valor2012
    valor2013
    valor2014
    valor2015
    valor2016
    valor2017
    valor2018
    valor2019
    valor2020
    valor2021
    valor2022
    valor2023
    valor2024
    valor2025
    valor2026
    valor2027
    valor2028
    valor2029
    valor2030
    valorTotal
    id
    idTipoinsumoMgaweb
  }
`;
export const SiifActividadFragmentDoc = gql`
  fragment SiifActividad on SiifActividad {
    id
    createdAt
    updatedAt
    nitCompania
    proyecto
    codigoAct
    descripcion
    etapa
    componente
    codigoUnd
    cantidad
    codSubact
    activa
    codigo
    idMeta
    idProducto
  }
`;
export const SiifActividadMetaAccionFragmentDoc = gql`
  fragment SiifActividadMetaAccion on SiifActividadMetaAccion {
    id
    actividadMetaId
    descripcion
  }
`;
export const GetGoalResourcesResponseFragmentDoc = gql`
  fragment GetGoalResourcesResponse on GetGoalResourcesResponse {
    resourceType
    capital
    cd
    cn
    credit
    de
    operation
    management
    monopoly
    others
    rp
    sgp
    sgpEducation
    sgpHealt
    sgpWater
    sgpCulture
    sgpSport
    sgpFreeInvestment
    sgpFreeDestination
    sgpSchoolFeeding
    sgpMagdalenaRiver
    sgpEarlyChildhood
    sgr
  }
`;
export const MacroProjectFragmentDoc = gql`
  fragment MacroProject on MacroProject {
    id
    code
    name
    description
    isActive
    createdAt
    updatedAt
  }
`;
export const GeoLocationFragmentDoc = gql`
  fragment GeoLocation on GeoLocation {
    id
    code
    name
    locationType
  }
`;
export const CreateMonitoringRecordAttachmentLinkResponseFragmentDoc = gql`
  fragment CreateMonitoringRecordAttachmentLinkResponse on CreateMonitoringRecordAttachmentLinkResponse {
    id
    createdAt
    updatedAt
    monitoringRecordId
    s3Path
    name
    description
    createdBy
    updatedBy
    uploadURL
  }
`;
export const PlanDesarrolloFragmentDoc = gql`
  fragment PlanDesarrollo on PlanDesarrollo {
    nitCompania
    plan
    nombre
    fechaInicio
    fechaFin
    objetivo
    gobernante
    id
    etiquetaEjeSingular
    etiquetaEjePlural
    etiquetaSectorSingular
    etiquetaSectorPlural
    etiquetaProgramaSingular
    etiquetaProgramaPlural
    etiquetaSubprogramaSingular
    etiquetaSubprogramaPlural
    manejaSector
    nivelMr
    nivelMp
  }
`;
export const EjeEstructuranteFragmentDoc = gql`
  fragment EjeEstructurante on EjeEstructurante {
    plan
    nitCompania
    eje
    nombre
    id
    codigo
    activo
  }
`;
export const SectorFragmentDoc = gql`
  fragment Sector on Sector {
    plan
    eje
    nitCompania
    sector
    nombre
    id
    codigo
    activo
    sectorDnp
  }
`;
export const ProgramaPryFragmentDoc = gql`
  fragment ProgramaPry on ProgramaPry {
    plan
    eje
    sector
    nitCompania
    programa
    nombre
    id
    codigo
    activo
  }
`;
export const SubprogramaPryFragmentDoc = gql`
  fragment SubprogramaPry on SubprogramaPry {
    plan
    eje
    sector
    nitCompania
    programa
    nombre
    subprogramaPry
    id
    subprograma
    codigo
    codigoAlt
    activo
    idSectorFut
  }
`;
export const VSpdMetaFragmentDoc = gql`
  fragment VSpdMeta on VSpdMeta {
    id
    nitCompania
    idPlan
    idEntidad
    codigo
    tipo
    nombre
    descripcion
    ponderacion
    indicador
    unidad
    periodo
    valorBase
    factorBase
    comparador
    valorMeta
    factorMeta
    valorProgramado
    mesInicio
    mesFin
    accion
    idFut
    idPlanAccion
    proyecto
    idPadre
    idPlanDesarrollo
    codigoPlanDesarrollo
    codigoNivelPlan
    nombreNivelPlan
  }
`;
export const GoalToActivityFragmentDoc = gql`
  fragment GoalToActivity on GoalToActivity {
    id
    goalId
    activityId
    createdAt
  }
`;
export const GetEntitiesDocument = gql`
  query GetEntities {
    getEntities {
      ...Entity
    }
  }
  ${EntityFragmentDoc}
`;

/**
 * __useGetEntitiesQuery__
 *
 * To run a query within a React component, call `useGetEntitiesQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetEntitiesQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetEntitiesQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetEntitiesQuery(
  baseOptions?: Apollo.QueryHookOptions<Types.GetEntitiesQuery, Types.GetEntitiesQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetEntitiesQuery, Types.GetEntitiesQueryVariables>(
    GetEntitiesDocument,
    options,
  );
}
export function useGetEntitiesLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetEntitiesQuery,
    Types.GetEntitiesQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetEntitiesQuery, Types.GetEntitiesQueryVariables>(
    GetEntitiesDocument,
    options,
  );
}
export function useGetEntitiesSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetEntitiesQuery, Types.GetEntitiesQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetEntitiesQuery, Types.GetEntitiesQueryVariables>(
    GetEntitiesDocument,
    options,
  );
}
export type GetEntitiesQueryHookResult = ReturnType<typeof useGetEntitiesQuery>;
export type GetEntitiesLazyQueryHookResult = ReturnType<typeof useGetEntitiesLazyQuery>;
export type GetEntitiesSuspenseQueryHookResult = ReturnType<typeof useGetEntitiesSuspenseQuery>;
export type GetEntitiesQueryResult = Apollo.QueryResult<
  Types.GetEntitiesQuery,
  Types.GetEntitiesQueryVariables
>;
export const SearchEntitiesDocument = gql`
  query SearchEntities($data: SearchEntity!) {
    searchEntities(data: $data) {
      count
      items {
        ...Entity
      }
    }
  }
  ${EntityFragmentDoc}
`;

/**
 * __useSearchEntitiesQuery__
 *
 * To run a query within a React component, call `useSearchEntitiesQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchEntitiesQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchEntitiesQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchEntitiesQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchEntitiesQuery,
    Types.SearchEntitiesQueryVariables
  > &
    ({ variables: Types.SearchEntitiesQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchEntitiesQuery, Types.SearchEntitiesQueryVariables>(
    SearchEntitiesDocument,
    options,
  );
}
export function useSearchEntitiesLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchEntitiesQuery,
    Types.SearchEntitiesQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.SearchEntitiesQuery, Types.SearchEntitiesQueryVariables>(
    SearchEntitiesDocument,
    options,
  );
}
export function useSearchEntitiesSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchEntitiesQuery,
        Types.SearchEntitiesQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.SearchEntitiesQuery, Types.SearchEntitiesQueryVariables>(
    SearchEntitiesDocument,
    options,
  );
}
export type SearchEntitiesQueryHookResult = ReturnType<typeof useSearchEntitiesQuery>;
export type SearchEntitiesLazyQueryHookResult = ReturnType<typeof useSearchEntitiesLazyQuery>;
export type SearchEntitiesSuspenseQueryHookResult = ReturnType<
  typeof useSearchEntitiesSuspenseQuery
>;
export type SearchEntitiesQueryResult = Apollo.QueryResult<
  Types.SearchEntitiesQuery,
  Types.SearchEntitiesQueryVariables
>;
export const GetEntityDocument = gql`
  query GetEntity($id: Int!) {
    getEntity(id: $id) {
      ...Entity
    }
  }
  ${EntityFragmentDoc}
`;

/**
 * __useGetEntityQuery__
 *
 * To run a query within a React component, call `useGetEntityQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetEntityQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetEntityQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetEntityQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetEntityQuery, Types.GetEntityQueryVariables> &
    ({ variables: Types.GetEntityQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetEntityQuery, Types.GetEntityQueryVariables>(
    GetEntityDocument,
    options,
  );
}
export function useGetEntityLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetEntityQuery, Types.GetEntityQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetEntityQuery, Types.GetEntityQueryVariables>(
    GetEntityDocument,
    options,
  );
}
export function useGetEntitySuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetEntityQuery, Types.GetEntityQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetEntityQuery, Types.GetEntityQueryVariables>(
    GetEntityDocument,
    options,
  );
}
export type GetEntityQueryHookResult = ReturnType<typeof useGetEntityQuery>;
export type GetEntityLazyQueryHookResult = ReturnType<typeof useGetEntityLazyQuery>;
export type GetEntitySuspenseQueryHookResult = ReturnType<typeof useGetEntitySuspenseQuery>;
export type GetEntityQueryResult = Apollo.QueryResult<
  Types.GetEntityQuery,
  Types.GetEntityQueryVariables
>;
export const CreateEntityDocument = gql`
  mutation CreateEntity($data: CreateEntity!) {
    createEntity(data: $data) {
      ...Entity
    }
  }
  ${EntityFragmentDoc}
`;
export type CreateEntityMutationFn = Apollo.MutationFunction<
  Types.CreateEntityMutation,
  Types.CreateEntityMutationVariables
>;

/**
 * __useCreateEntityMutation__
 *
 * To run a mutation, you first call `useCreateEntityMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateEntityMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createEntityMutation, { data, loading, error }] = useCreateEntityMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateEntityMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateEntityMutation,
    Types.CreateEntityMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.CreateEntityMutation, Types.CreateEntityMutationVariables>(
    CreateEntityDocument,
    options,
  );
}
export type CreateEntityMutationHookResult = ReturnType<typeof useCreateEntityMutation>;
export type CreateEntityMutationResult = Apollo.MutationResult<Types.CreateEntityMutation>;
export type CreateEntityMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateEntityMutation,
  Types.CreateEntityMutationVariables
>;
export const UpdateEntityDocument = gql`
  mutation UpdateEntity($data: UpdateEntity!) {
    updateEntity(data: $data) {
      ...Entity
    }
  }
  ${EntityFragmentDoc}
`;
export type UpdateEntityMutationFn = Apollo.MutationFunction<
  Types.UpdateEntityMutation,
  Types.UpdateEntityMutationVariables
>;

/**
 * __useUpdateEntityMutation__
 *
 * To run a mutation, you first call `useUpdateEntityMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateEntityMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateEntityMutation, { data, loading, error }] = useUpdateEntityMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateEntityMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateEntityMutation,
    Types.UpdateEntityMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.UpdateEntityMutation, Types.UpdateEntityMutationVariables>(
    UpdateEntityDocument,
    options,
  );
}
export type UpdateEntityMutationHookResult = ReturnType<typeof useUpdateEntityMutation>;
export type UpdateEntityMutationResult = Apollo.MutationResult<Types.UpdateEntityMutation>;
export type UpdateEntityMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateEntityMutation,
  Types.UpdateEntityMutationVariables
>;
export const DeleteEntityDocument = gql`
  mutation DeleteEntity($id: Int!) {
    deleteEntity(id: $id)
  }
`;
export type DeleteEntityMutationFn = Apollo.MutationFunction<
  Types.DeleteEntityMutation,
  Types.DeleteEntityMutationVariables
>;

/**
 * __useDeleteEntityMutation__
 *
 * To run a mutation, you first call `useDeleteEntityMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteEntityMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteEntityMutation, { data, loading, error }] = useDeleteEntityMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteEntityMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteEntityMutation,
    Types.DeleteEntityMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.DeleteEntityMutation, Types.DeleteEntityMutationVariables>(
    DeleteEntityDocument,
    options,
  );
}
export type DeleteEntityMutationHookResult = ReturnType<typeof useDeleteEntityMutation>;
export type DeleteEntityMutationResult = Apollo.MutationResult<Types.DeleteEntityMutation>;
export type DeleteEntityMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteEntityMutation,
  Types.DeleteEntityMutationVariables
>;
export const GetDevPlansDocument = gql`
  query GetDevPlans {
    getDevPlans {
      ...DevPlan
      levels {
        ...DevPlanLevel
      }
    }
  }
  ${DevPlanFragmentDoc}
  ${DevPlanLevelFragmentDoc}
`;

/**
 * __useGetDevPlansQuery__
 *
 * To run a query within a React component, call `useGetDevPlansQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetDevPlansQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetDevPlansQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetDevPlansQuery(
  baseOptions?: Apollo.QueryHookOptions<Types.GetDevPlansQuery, Types.GetDevPlansQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetDevPlansQuery, Types.GetDevPlansQueryVariables>(
    GetDevPlansDocument,
    options,
  );
}
export function useGetDevPlansLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetDevPlansQuery,
    Types.GetDevPlansQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetDevPlansQuery, Types.GetDevPlansQueryVariables>(
    GetDevPlansDocument,
    options,
  );
}
export function useGetDevPlansSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetDevPlansQuery, Types.GetDevPlansQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetDevPlansQuery, Types.GetDevPlansQueryVariables>(
    GetDevPlansDocument,
    options,
  );
}
export type GetDevPlansQueryHookResult = ReturnType<typeof useGetDevPlansQuery>;
export type GetDevPlansLazyQueryHookResult = ReturnType<typeof useGetDevPlansLazyQuery>;
export type GetDevPlansSuspenseQueryHookResult = ReturnType<typeof useGetDevPlansSuspenseQuery>;
export type GetDevPlansQueryResult = Apollo.QueryResult<
  Types.GetDevPlansQuery,
  Types.GetDevPlansQueryVariables
>;
export const GetDevPlanDocument = gql`
  query GetDevPlan($id: Int!) {
    getDevPlan(id: $id) {
      ...DevPlan
      levels {
        ...DevPlanLevel
      }
    }
  }
  ${DevPlanFragmentDoc}
  ${DevPlanLevelFragmentDoc}
`;

/**
 * __useGetDevPlanQuery__
 *
 * To run a query within a React component, call `useGetDevPlanQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetDevPlanQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetDevPlanQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetDevPlanQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetDevPlanQuery, Types.GetDevPlanQueryVariables> &
    ({ variables: Types.GetDevPlanQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetDevPlanQuery, Types.GetDevPlanQueryVariables>(
    GetDevPlanDocument,
    options,
  );
}
export function useGetDevPlanLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetDevPlanQuery, Types.GetDevPlanQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetDevPlanQuery, Types.GetDevPlanQueryVariables>(
    GetDevPlanDocument,
    options,
  );
}
export function useGetDevPlanSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetDevPlanQuery, Types.GetDevPlanQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetDevPlanQuery, Types.GetDevPlanQueryVariables>(
    GetDevPlanDocument,
    options,
  );
}
export type GetDevPlanQueryHookResult = ReturnType<typeof useGetDevPlanQuery>;
export type GetDevPlanLazyQueryHookResult = ReturnType<typeof useGetDevPlanLazyQuery>;
export type GetDevPlanSuspenseQueryHookResult = ReturnType<typeof useGetDevPlanSuspenseQuery>;
export type GetDevPlanQueryResult = Apollo.QueryResult<
  Types.GetDevPlanQuery,
  Types.GetDevPlanQueryVariables
>;
export const GetDevPlanByCodeDocument = gql`
  query GetDevPlanByCode($code: String!) {
    getDevPlanByCode(code: $code) {
      ...DevPlan
      levels {
        ...DevPlanLevel
      }
    }
  }
  ${DevPlanFragmentDoc}
  ${DevPlanLevelFragmentDoc}
`;

/**
 * __useGetDevPlanByCodeQuery__
 *
 * To run a query within a React component, call `useGetDevPlanByCodeQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetDevPlanByCodeQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetDevPlanByCodeQuery({
 *   variables: {
 *      code: // value for 'code'
 *   },
 * });
 */
export function useGetDevPlanByCodeQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetDevPlanByCodeQuery,
    Types.GetDevPlanByCodeQueryVariables
  > &
    ({ variables: Types.GetDevPlanByCodeQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetDevPlanByCodeQuery, Types.GetDevPlanByCodeQueryVariables>(
    GetDevPlanByCodeDocument,
    options,
  );
}
export function useGetDevPlanByCodeLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetDevPlanByCodeQuery,
    Types.GetDevPlanByCodeQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetDevPlanByCodeQuery, Types.GetDevPlanByCodeQueryVariables>(
    GetDevPlanByCodeDocument,
    options,
  );
}
export function useGetDevPlanByCodeSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetDevPlanByCodeQuery,
        Types.GetDevPlanByCodeQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetDevPlanByCodeQuery, Types.GetDevPlanByCodeQueryVariables>(
    GetDevPlanByCodeDocument,
    options,
  );
}
export type GetDevPlanByCodeQueryHookResult = ReturnType<typeof useGetDevPlanByCodeQuery>;
export type GetDevPlanByCodeLazyQueryHookResult = ReturnType<typeof useGetDevPlanByCodeLazyQuery>;
export type GetDevPlanByCodeSuspenseQueryHookResult = ReturnType<
  typeof useGetDevPlanByCodeSuspenseQuery
>;
export type GetDevPlanByCodeQueryResult = Apollo.QueryResult<
  Types.GetDevPlanByCodeQuery,
  Types.GetDevPlanByCodeQueryVariables
>;
export const CreateDevPlanDocument = gql`
  mutation CreateDevPlan($data: CreateDevPlan!) {
    createDevPlan(data: $data) {
      ...DevPlan
    }
  }
  ${DevPlanFragmentDoc}
`;
export type CreateDevPlanMutationFn = Apollo.MutationFunction<
  Types.CreateDevPlanMutation,
  Types.CreateDevPlanMutationVariables
>;

/**
 * __useCreateDevPlanMutation__
 *
 * To run a mutation, you first call `useCreateDevPlanMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateDevPlanMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createDevPlanMutation, { data, loading, error }] = useCreateDevPlanMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateDevPlanMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateDevPlanMutation,
    Types.CreateDevPlanMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.CreateDevPlanMutation, Types.CreateDevPlanMutationVariables>(
    CreateDevPlanDocument,
    options,
  );
}
export type CreateDevPlanMutationHookResult = ReturnType<typeof useCreateDevPlanMutation>;
export type CreateDevPlanMutationResult = Apollo.MutationResult<Types.CreateDevPlanMutation>;
export type CreateDevPlanMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateDevPlanMutation,
  Types.CreateDevPlanMutationVariables
>;
export const UpdateDevPlanDocument = gql`
  mutation UpdateDevPlan($data: UpdateDevPlan!) {
    updateDevPlan(data: $data) {
      ...DevPlan
    }
  }
  ${DevPlanFragmentDoc}
`;
export type UpdateDevPlanMutationFn = Apollo.MutationFunction<
  Types.UpdateDevPlanMutation,
  Types.UpdateDevPlanMutationVariables
>;

/**
 * __useUpdateDevPlanMutation__
 *
 * To run a mutation, you first call `useUpdateDevPlanMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateDevPlanMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateDevPlanMutation, { data, loading, error }] = useUpdateDevPlanMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateDevPlanMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateDevPlanMutation,
    Types.UpdateDevPlanMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.UpdateDevPlanMutation, Types.UpdateDevPlanMutationVariables>(
    UpdateDevPlanDocument,
    options,
  );
}
export type UpdateDevPlanMutationHookResult = ReturnType<typeof useUpdateDevPlanMutation>;
export type UpdateDevPlanMutationResult = Apollo.MutationResult<Types.UpdateDevPlanMutation>;
export type UpdateDevPlanMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateDevPlanMutation,
  Types.UpdateDevPlanMutationVariables
>;
export const DeleteDevPlanDocument = gql`
  mutation DeleteDevPlan($id: Int!) {
    deleteDevPlan(id: $id) {
      ...DevPlan
    }
  }
  ${DevPlanFragmentDoc}
`;
export type DeleteDevPlanMutationFn = Apollo.MutationFunction<
  Types.DeleteDevPlanMutation,
  Types.DeleteDevPlanMutationVariables
>;

/**
 * __useDeleteDevPlanMutation__
 *
 * To run a mutation, you first call `useDeleteDevPlanMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteDevPlanMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteDevPlanMutation, { data, loading, error }] = useDeleteDevPlanMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteDevPlanMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteDevPlanMutation,
    Types.DeleteDevPlanMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.DeleteDevPlanMutation, Types.DeleteDevPlanMutationVariables>(
    DeleteDevPlanDocument,
    options,
  );
}
export type DeleteDevPlanMutationHookResult = ReturnType<typeof useDeleteDevPlanMutation>;
export type DeleteDevPlanMutationResult = Apollo.MutationResult<Types.DeleteDevPlanMutation>;
export type DeleteDevPlanMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteDevPlanMutation,
  Types.DeleteDevPlanMutationVariables
>;
export const CopyDevPlanDocument = gql`
  mutation CopyDevPlan($data: CopyDevPlan!) {
    copyDevPlan(data: $data) {
      ...DevPlan
      levels {
        ...DevPlanLevel
      }
    }
  }
  ${DevPlanFragmentDoc}
  ${DevPlanLevelFragmentDoc}
`;
export type CopyDevPlanMutationFn = Apollo.MutationFunction<
  Types.CopyDevPlanMutation,
  Types.CopyDevPlanMutationVariables
>;

/**
 * __useCopyDevPlanMutation__
 *
 * To run a mutation, you first call `useCopyDevPlanMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCopyDevPlanMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [copyDevPlanMutation, { data, loading, error }] = useCopyDevPlanMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCopyDevPlanMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CopyDevPlanMutation,
    Types.CopyDevPlanMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.CopyDevPlanMutation, Types.CopyDevPlanMutationVariables>(
    CopyDevPlanDocument,
    options,
  );
}
export type CopyDevPlanMutationHookResult = ReturnType<typeof useCopyDevPlanMutation>;
export type CopyDevPlanMutationResult = Apollo.MutationResult<Types.CopyDevPlanMutation>;
export type CopyDevPlanMutationOptions = Apollo.BaseMutationOptions<
  Types.CopyDevPlanMutation,
  Types.CopyDevPlanMutationVariables
>;
export const CreateDevPlanLevelDocument = gql`
  mutation CreateDevPlanLevel($data: CreateDevPlanLevel!) {
    createDevPlanLevel(data: $data) {
      ...DevPlanLevel
    }
  }
  ${DevPlanLevelFragmentDoc}
`;
export type CreateDevPlanLevelMutationFn = Apollo.MutationFunction<
  Types.CreateDevPlanLevelMutation,
  Types.CreateDevPlanLevelMutationVariables
>;

/**
 * __useCreateDevPlanLevelMutation__
 *
 * To run a mutation, you first call `useCreateDevPlanLevelMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateDevPlanLevelMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createDevPlanLevelMutation, { data, loading, error }] = useCreateDevPlanLevelMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateDevPlanLevelMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateDevPlanLevelMutation,
    Types.CreateDevPlanLevelMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreateDevPlanLevelMutation,
    Types.CreateDevPlanLevelMutationVariables
  >(CreateDevPlanLevelDocument, options);
}
export type CreateDevPlanLevelMutationHookResult = ReturnType<typeof useCreateDevPlanLevelMutation>;
export type CreateDevPlanLevelMutationResult =
  Apollo.MutationResult<Types.CreateDevPlanLevelMutation>;
export type CreateDevPlanLevelMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateDevPlanLevelMutation,
  Types.CreateDevPlanLevelMutationVariables
>;
export const GetDevPlanLevelsDocument = gql`
  query GetDevPlanLevels($devPlanId: Int!) {
    getDevPlanLevels(devPlanId: $devPlanId) {
      ...DevPlanLevel
      goalCount {
        ...GoalTypeCount
      }
    }
  }
  ${DevPlanLevelFragmentDoc}
  ${GoalTypeCountFragmentDoc}
`;

/**
 * __useGetDevPlanLevelsQuery__
 *
 * To run a query within a React component, call `useGetDevPlanLevelsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetDevPlanLevelsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetDevPlanLevelsQuery({
 *   variables: {
 *      devPlanId: // value for 'devPlanId'
 *   },
 * });
 */
export function useGetDevPlanLevelsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetDevPlanLevelsQuery,
    Types.GetDevPlanLevelsQueryVariables
  > &
    ({ variables: Types.GetDevPlanLevelsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetDevPlanLevelsQuery, Types.GetDevPlanLevelsQueryVariables>(
    GetDevPlanLevelsDocument,
    options,
  );
}
export function useGetDevPlanLevelsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetDevPlanLevelsQuery,
    Types.GetDevPlanLevelsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetDevPlanLevelsQuery, Types.GetDevPlanLevelsQueryVariables>(
    GetDevPlanLevelsDocument,
    options,
  );
}
export function useGetDevPlanLevelsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetDevPlanLevelsQuery,
        Types.GetDevPlanLevelsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetDevPlanLevelsQuery, Types.GetDevPlanLevelsQueryVariables>(
    GetDevPlanLevelsDocument,
    options,
  );
}
export type GetDevPlanLevelsQueryHookResult = ReturnType<typeof useGetDevPlanLevelsQuery>;
export type GetDevPlanLevelsLazyQueryHookResult = ReturnType<typeof useGetDevPlanLevelsLazyQuery>;
export type GetDevPlanLevelsSuspenseQueryHookResult = ReturnType<
  typeof useGetDevPlanLevelsSuspenseQuery
>;
export type GetDevPlanLevelsQueryResult = Apollo.QueryResult<
  Types.GetDevPlanLevelsQuery,
  Types.GetDevPlanLevelsQueryVariables
>;
export const UpdateDevPlanLevelDocument = gql`
  mutation UpdateDevPlanLevel($data: UpdateDevPlanLevel!) {
    updateDevPlanLevel(data: $data) {
      ...DevPlanLevel
      goalCount {
        ...GoalTypeCount
      }
    }
  }
  ${DevPlanLevelFragmentDoc}
  ${GoalTypeCountFragmentDoc}
`;
export type UpdateDevPlanLevelMutationFn = Apollo.MutationFunction<
  Types.UpdateDevPlanLevelMutation,
  Types.UpdateDevPlanLevelMutationVariables
>;

/**
 * __useUpdateDevPlanLevelMutation__
 *
 * To run a mutation, you first call `useUpdateDevPlanLevelMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateDevPlanLevelMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateDevPlanLevelMutation, { data, loading, error }] = useUpdateDevPlanLevelMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateDevPlanLevelMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateDevPlanLevelMutation,
    Types.UpdateDevPlanLevelMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdateDevPlanLevelMutation,
    Types.UpdateDevPlanLevelMutationVariables
  >(UpdateDevPlanLevelDocument, options);
}
export type UpdateDevPlanLevelMutationHookResult = ReturnType<typeof useUpdateDevPlanLevelMutation>;
export type UpdateDevPlanLevelMutationResult =
  Apollo.MutationResult<Types.UpdateDevPlanLevelMutation>;
export type UpdateDevPlanLevelMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateDevPlanLevelMutation,
  Types.UpdateDevPlanLevelMutationVariables
>;
export const DeleteDevPlanLevelDocument = gql`
  mutation DeleteDevPlanLevel($id: Int!) {
    deleteDevPlanLevel(id: $id) {
      ...DevPlanLevel
    }
  }
  ${DevPlanLevelFragmentDoc}
`;
export type DeleteDevPlanLevelMutationFn = Apollo.MutationFunction<
  Types.DeleteDevPlanLevelMutation,
  Types.DeleteDevPlanLevelMutationVariables
>;

/**
 * __useDeleteDevPlanLevelMutation__
 *
 * To run a mutation, you first call `useDeleteDevPlanLevelMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteDevPlanLevelMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteDevPlanLevelMutation, { data, loading, error }] = useDeleteDevPlanLevelMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteDevPlanLevelMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteDevPlanLevelMutation,
    Types.DeleteDevPlanLevelMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteDevPlanLevelMutation,
    Types.DeleteDevPlanLevelMutationVariables
  >(DeleteDevPlanLevelDocument, options);
}
export type DeleteDevPlanLevelMutationHookResult = ReturnType<typeof useDeleteDevPlanLevelMutation>;
export type DeleteDevPlanLevelMutationResult =
  Apollo.MutationResult<Types.DeleteDevPlanLevelMutation>;
export type DeleteDevPlanLevelMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteDevPlanLevelMutation,
  Types.DeleteDevPlanLevelMutationVariables
>;
export const DeleteDevPlanLevelsDocument = gql`
  mutation DeleteDevPlanLevels($ids: [Int!]!) {
    deleteDevPlanLevels(ids: $ids)
  }
`;
export type DeleteDevPlanLevelsMutationFn = Apollo.MutationFunction<
  Types.DeleteDevPlanLevelsMutation,
  Types.DeleteDevPlanLevelsMutationVariables
>;

/**
 * __useDeleteDevPlanLevelsMutation__
 *
 * To run a mutation, you first call `useDeleteDevPlanLevelsMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteDevPlanLevelsMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteDevPlanLevelsMutation, { data, loading, error }] = useDeleteDevPlanLevelsMutation({
 *   variables: {
 *      ids: // value for 'ids'
 *   },
 * });
 */
export function useDeleteDevPlanLevelsMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteDevPlanLevelsMutation,
    Types.DeleteDevPlanLevelsMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteDevPlanLevelsMutation,
    Types.DeleteDevPlanLevelsMutationVariables
  >(DeleteDevPlanLevelsDocument, options);
}
export type DeleteDevPlanLevelsMutationHookResult = ReturnType<
  typeof useDeleteDevPlanLevelsMutation
>;
export type DeleteDevPlanLevelsMutationResult =
  Apollo.MutationResult<Types.DeleteDevPlanLevelsMutation>;
export type DeleteDevPlanLevelsMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteDevPlanLevelsMutation,
  Types.DeleteDevPlanLevelsMutationVariables
>;
export const GetDevPlanLevelDocument = gql`
  query GetDevPlanLevel($id: Int!) {
    getDevPlanLevel(id: $id) {
      ...DevPlanLevel
      goalCount {
        ...GoalTypeCount
      }
    }
  }
  ${DevPlanLevelFragmentDoc}
  ${GoalTypeCountFragmentDoc}
`;

/**
 * __useGetDevPlanLevelQuery__
 *
 * To run a query within a React component, call `useGetDevPlanLevelQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetDevPlanLevelQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetDevPlanLevelQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetDevPlanLevelQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetDevPlanLevelQuery,
    Types.GetDevPlanLevelQueryVariables
  > &
    ({ variables: Types.GetDevPlanLevelQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetDevPlanLevelQuery, Types.GetDevPlanLevelQueryVariables>(
    GetDevPlanLevelDocument,
    options,
  );
}
export function useGetDevPlanLevelLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetDevPlanLevelQuery,
    Types.GetDevPlanLevelQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetDevPlanLevelQuery, Types.GetDevPlanLevelQueryVariables>(
    GetDevPlanLevelDocument,
    options,
  );
}
export function useGetDevPlanLevelSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetDevPlanLevelQuery,
        Types.GetDevPlanLevelQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetDevPlanLevelQuery, Types.GetDevPlanLevelQueryVariables>(
    GetDevPlanLevelDocument,
    options,
  );
}
export type GetDevPlanLevelQueryHookResult = ReturnType<typeof useGetDevPlanLevelQuery>;
export type GetDevPlanLevelLazyQueryHookResult = ReturnType<typeof useGetDevPlanLevelLazyQuery>;
export type GetDevPlanLevelSuspenseQueryHookResult = ReturnType<
  typeof useGetDevPlanLevelSuspenseQuery
>;
export type GetDevPlanLevelQueryResult = Apollo.QueryResult<
  Types.GetDevPlanLevelQuery,
  Types.GetDevPlanLevelQueryVariables
>;
export const SearchDevPlanLevelsDocument = gql`
  query SearchDevPlanLevels($data: SearchDevPlanLevel!) {
    searchDevPlanLevels(data: $data) {
      ...DevPlanLevel
      goalCount {
        ...GoalTypeCount
      }
    }
  }
  ${DevPlanLevelFragmentDoc}
  ${GoalTypeCountFragmentDoc}
`;

/**
 * __useSearchDevPlanLevelsQuery__
 *
 * To run a query within a React component, call `useSearchDevPlanLevelsQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchDevPlanLevelsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchDevPlanLevelsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchDevPlanLevelsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchDevPlanLevelsQuery,
    Types.SearchDevPlanLevelsQueryVariables
  > &
    ({ variables: Types.SearchDevPlanLevelsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchDevPlanLevelsQuery, Types.SearchDevPlanLevelsQueryVariables>(
    SearchDevPlanLevelsDocument,
    options,
  );
}
export function useSearchDevPlanLevelsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchDevPlanLevelsQuery,
    Types.SearchDevPlanLevelsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.SearchDevPlanLevelsQuery,
    Types.SearchDevPlanLevelsQueryVariables
  >(SearchDevPlanLevelsDocument, options);
}
export function useSearchDevPlanLevelsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchDevPlanLevelsQuery,
        Types.SearchDevPlanLevelsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchDevPlanLevelsQuery,
    Types.SearchDevPlanLevelsQueryVariables
  >(SearchDevPlanLevelsDocument, options);
}
export type SearchDevPlanLevelsQueryHookResult = ReturnType<typeof useSearchDevPlanLevelsQuery>;
export type SearchDevPlanLevelsLazyQueryHookResult = ReturnType<
  typeof useSearchDevPlanLevelsLazyQuery
>;
export type SearchDevPlanLevelsSuspenseQueryHookResult = ReturnType<
  typeof useSearchDevPlanLevelsSuspenseQuery
>;
export type SearchDevPlanLevelsQueryResult = Apollo.QueryResult<
  Types.SearchDevPlanLevelsQuery,
  Types.SearchDevPlanLevelsQueryVariables
>;
export const GetDevPlanLevelsTreeDocument = gql`
  query GetDevPlanLevelsTree($devPlanId: Int!, $getRootAsNode: Boolean) {
    getDevPlanLevelsTree(devPlanId: $devPlanId, getRootAsNode: $getRootAsNode) {
      ...DevPlanLevel
      goalCount {
        ...GoalTypeCount
      }
      children {
        ...DevPlanLevel
        goalCount {
          ...GoalTypeCount
        }
        children {
          ...DevPlanLevel
          goalCount {
            ...GoalTypeCount
          }
          children {
            ...DevPlanLevel
            goalCount {
              ...GoalTypeCount
            }
            children {
              ...DevPlanLevel
              goalCount {
                ...GoalTypeCount
              }
            }
          }
        }
      }
    }
  }
  ${DevPlanLevelFragmentDoc}
  ${GoalTypeCountFragmentDoc}
`;

/**
 * __useGetDevPlanLevelsTreeQuery__
 *
 * To run a query within a React component, call `useGetDevPlanLevelsTreeQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetDevPlanLevelsTreeQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetDevPlanLevelsTreeQuery({
 *   variables: {
 *      devPlanId: // value for 'devPlanId'
 *      getRootAsNode: // value for 'getRootAsNode'
 *   },
 * });
 */
export function useGetDevPlanLevelsTreeQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetDevPlanLevelsTreeQuery,
    Types.GetDevPlanLevelsTreeQueryVariables
  > &
    ({ variables: Types.GetDevPlanLevelsTreeQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetDevPlanLevelsTreeQuery, Types.GetDevPlanLevelsTreeQueryVariables>(
    GetDevPlanLevelsTreeDocument,
    options,
  );
}
export function useGetDevPlanLevelsTreeLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetDevPlanLevelsTreeQuery,
    Types.GetDevPlanLevelsTreeQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetDevPlanLevelsTreeQuery,
    Types.GetDevPlanLevelsTreeQueryVariables
  >(GetDevPlanLevelsTreeDocument, options);
}
export function useGetDevPlanLevelsTreeSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetDevPlanLevelsTreeQuery,
        Types.GetDevPlanLevelsTreeQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetDevPlanLevelsTreeQuery,
    Types.GetDevPlanLevelsTreeQueryVariables
  >(GetDevPlanLevelsTreeDocument, options);
}
export type GetDevPlanLevelsTreeQueryHookResult = ReturnType<typeof useGetDevPlanLevelsTreeQuery>;
export type GetDevPlanLevelsTreeLazyQueryHookResult = ReturnType<
  typeof useGetDevPlanLevelsTreeLazyQuery
>;
export type GetDevPlanLevelsTreeSuspenseQueryHookResult = ReturnType<
  typeof useGetDevPlanLevelsTreeSuspenseQuery
>;
export type GetDevPlanLevelsTreeQueryResult = Apollo.QueryResult<
  Types.GetDevPlanLevelsTreeQuery,
  Types.GetDevPlanLevelsTreeQueryVariables
>;
export const GetMonitoringConfigsDocument = gql`
  query GetMonitoringConfigs($data: GetMonitoringConfig) {
    getMonitoringConfigs(data: $data) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;

/**
 * __useGetMonitoringConfigsQuery__
 *
 * To run a query within a React component, call `useGetMonitoringConfigsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMonitoringConfigsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMonitoringConfigsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetMonitoringConfigsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetMonitoringConfigsQuery,
    Types.GetMonitoringConfigsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetMonitoringConfigsQuery, Types.GetMonitoringConfigsQueryVariables>(
    GetMonitoringConfigsDocument,
    options,
  );
}
export function useGetMonitoringConfigsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMonitoringConfigsQuery,
    Types.GetMonitoringConfigsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetMonitoringConfigsQuery,
    Types.GetMonitoringConfigsQueryVariables
  >(GetMonitoringConfigsDocument, options);
}
export function useGetMonitoringConfigsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMonitoringConfigsQuery,
        Types.GetMonitoringConfigsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetMonitoringConfigsQuery,
    Types.GetMonitoringConfigsQueryVariables
  >(GetMonitoringConfigsDocument, options);
}
export type GetMonitoringConfigsQueryHookResult = ReturnType<typeof useGetMonitoringConfigsQuery>;
export type GetMonitoringConfigsLazyQueryHookResult = ReturnType<
  typeof useGetMonitoringConfigsLazyQuery
>;
export type GetMonitoringConfigsSuspenseQueryHookResult = ReturnType<
  typeof useGetMonitoringConfigsSuspenseQuery
>;
export type GetMonitoringConfigsQueryResult = Apollo.QueryResult<
  Types.GetMonitoringConfigsQuery,
  Types.GetMonitoringConfigsQueryVariables
>;
export const GetMonitoringConfigDocument = gql`
  query GetMonitoringConfig($id: Int!) {
    getMonitoringConfig(id: $id) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;

/**
 * __useGetMonitoringConfigQuery__
 *
 * To run a query within a React component, call `useGetMonitoringConfigQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMonitoringConfigQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMonitoringConfigQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetMonitoringConfigQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetMonitoringConfigQuery,
    Types.GetMonitoringConfigQueryVariables
  > &
    ({ variables: Types.GetMonitoringConfigQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetMonitoringConfigQuery, Types.GetMonitoringConfigQueryVariables>(
    GetMonitoringConfigDocument,
    options,
  );
}
export function useGetMonitoringConfigLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMonitoringConfigQuery,
    Types.GetMonitoringConfigQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetMonitoringConfigQuery,
    Types.GetMonitoringConfigQueryVariables
  >(GetMonitoringConfigDocument, options);
}
export function useGetMonitoringConfigSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMonitoringConfigQuery,
        Types.GetMonitoringConfigQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetMonitoringConfigQuery,
    Types.GetMonitoringConfigQueryVariables
  >(GetMonitoringConfigDocument, options);
}
export type GetMonitoringConfigQueryHookResult = ReturnType<typeof useGetMonitoringConfigQuery>;
export type GetMonitoringConfigLazyQueryHookResult = ReturnType<
  typeof useGetMonitoringConfigLazyQuery
>;
export type GetMonitoringConfigSuspenseQueryHookResult = ReturnType<
  typeof useGetMonitoringConfigSuspenseQuery
>;
export type GetMonitoringConfigQueryResult = Apollo.QueryResult<
  Types.GetMonitoringConfigQuery,
  Types.GetMonitoringConfigQueryVariables
>;
export const GetActiveMonitoringConfigDocument = gql`
  query GetActiveMonitoringConfig($data: GetMonitoringConfig) {
    getActiveMonitoringConfig(data: $data) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;

/**
 * __useGetActiveMonitoringConfigQuery__
 *
 * To run a query within a React component, call `useGetActiveMonitoringConfigQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetActiveMonitoringConfigQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetActiveMonitoringConfigQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetActiveMonitoringConfigQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetActiveMonitoringConfigQuery,
    Types.GetActiveMonitoringConfigQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetActiveMonitoringConfigQuery,
    Types.GetActiveMonitoringConfigQueryVariables
  >(GetActiveMonitoringConfigDocument, options);
}
export function useGetActiveMonitoringConfigLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetActiveMonitoringConfigQuery,
    Types.GetActiveMonitoringConfigQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetActiveMonitoringConfigQuery,
    Types.GetActiveMonitoringConfigQueryVariables
  >(GetActiveMonitoringConfigDocument, options);
}
export function useGetActiveMonitoringConfigSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetActiveMonitoringConfigQuery,
        Types.GetActiveMonitoringConfigQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetActiveMonitoringConfigQuery,
    Types.GetActiveMonitoringConfigQueryVariables
  >(GetActiveMonitoringConfigDocument, options);
}
export type GetActiveMonitoringConfigQueryHookResult = ReturnType<
  typeof useGetActiveMonitoringConfigQuery
>;
export type GetActiveMonitoringConfigLazyQueryHookResult = ReturnType<
  typeof useGetActiveMonitoringConfigLazyQuery
>;
export type GetActiveMonitoringConfigSuspenseQueryHookResult = ReturnType<
  typeof useGetActiveMonitoringConfigSuspenseQuery
>;
export type GetActiveMonitoringConfigQueryResult = Apollo.QueryResult<
  Types.GetActiveMonitoringConfigQuery,
  Types.GetActiveMonitoringConfigQueryVariables
>;
export const CreateMonitoringConfigDocument = gql`
  mutation CreateMonitoringConfig($data: CreateMonitoringConfig!) {
    createMonitoringConfig(data: $data) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;
export type CreateMonitoringConfigMutationFn = Apollo.MutationFunction<
  Types.CreateMonitoringConfigMutation,
  Types.CreateMonitoringConfigMutationVariables
>;

/**
 * __useCreateMonitoringConfigMutation__
 *
 * To run a mutation, you first call `useCreateMonitoringConfigMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateMonitoringConfigMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createMonitoringConfigMutation, { data, loading, error }] = useCreateMonitoringConfigMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateMonitoringConfigMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateMonitoringConfigMutation,
    Types.CreateMonitoringConfigMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreateMonitoringConfigMutation,
    Types.CreateMonitoringConfigMutationVariables
  >(CreateMonitoringConfigDocument, options);
}
export type CreateMonitoringConfigMutationHookResult = ReturnType<
  typeof useCreateMonitoringConfigMutation
>;
export type CreateMonitoringConfigMutationResult =
  Apollo.MutationResult<Types.CreateMonitoringConfigMutation>;
export type CreateMonitoringConfigMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateMonitoringConfigMutation,
  Types.CreateMonitoringConfigMutationVariables
>;
export const CopyMonitoringConfigPreviousScheduleDocument = gql`
  mutation CopyMonitoringConfigPreviousSchedule($data: CopyMonitoringConfigPreviousSchedule!) {
    copyMonitoringConfigPreviousSchedule(data: $data) {
      ...MonitoringRecord
      resources {
        ...MonitoringRecordResource
      }
    }
  }
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
`;
export type CopyMonitoringConfigPreviousScheduleMutationFn = Apollo.MutationFunction<
  Types.CopyMonitoringConfigPreviousScheduleMutation,
  Types.CopyMonitoringConfigPreviousScheduleMutationVariables
>;

/**
 * __useCopyMonitoringConfigPreviousScheduleMutation__
 *
 * To run a mutation, you first call `useCopyMonitoringConfigPreviousScheduleMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCopyMonitoringConfigPreviousScheduleMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [copyMonitoringConfigPreviousScheduleMutation, { data, loading, error }] = useCopyMonitoringConfigPreviousScheduleMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCopyMonitoringConfigPreviousScheduleMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CopyMonitoringConfigPreviousScheduleMutation,
    Types.CopyMonitoringConfigPreviousScheduleMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CopyMonitoringConfigPreviousScheduleMutation,
    Types.CopyMonitoringConfigPreviousScheduleMutationVariables
  >(CopyMonitoringConfigPreviousScheduleDocument, options);
}
export type CopyMonitoringConfigPreviousScheduleMutationHookResult = ReturnType<
  typeof useCopyMonitoringConfigPreviousScheduleMutation
>;
export type CopyMonitoringConfigPreviousScheduleMutationResult =
  Apollo.MutationResult<Types.CopyMonitoringConfigPreviousScheduleMutation>;
export type CopyMonitoringConfigPreviousScheduleMutationOptions = Apollo.BaseMutationOptions<
  Types.CopyMonitoringConfigPreviousScheduleMutation,
  Types.CopyMonitoringConfigPreviousScheduleMutationVariables
>;
export const UpdateMonitoringConfigDocument = gql`
  mutation UpdateMonitoringConfig($data: UpdateMonitoringConfig!) {
    updateMonitoringConfig(data: $data) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;
export type UpdateMonitoringConfigMutationFn = Apollo.MutationFunction<
  Types.UpdateMonitoringConfigMutation,
  Types.UpdateMonitoringConfigMutationVariables
>;

/**
 * __useUpdateMonitoringConfigMutation__
 *
 * To run a mutation, you first call `useUpdateMonitoringConfigMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateMonitoringConfigMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateMonitoringConfigMutation, { data, loading, error }] = useUpdateMonitoringConfigMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateMonitoringConfigMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateMonitoringConfigMutation,
    Types.UpdateMonitoringConfigMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdateMonitoringConfigMutation,
    Types.UpdateMonitoringConfigMutationVariables
  >(UpdateMonitoringConfigDocument, options);
}
export type UpdateMonitoringConfigMutationHookResult = ReturnType<
  typeof useUpdateMonitoringConfigMutation
>;
export type UpdateMonitoringConfigMutationResult =
  Apollo.MutationResult<Types.UpdateMonitoringConfigMutation>;
export type UpdateMonitoringConfigMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateMonitoringConfigMutation,
  Types.UpdateMonitoringConfigMutationVariables
>;
export const SetActiveMonitoringConfigDocument = gql`
  mutation SetActiveMonitoringConfig($data: SetActiveMonitoringConfig!) {
    setActiveMonitoringConfig(data: $data) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;
export type SetActiveMonitoringConfigMutationFn = Apollo.MutationFunction<
  Types.SetActiveMonitoringConfigMutation,
  Types.SetActiveMonitoringConfigMutationVariables
>;

/**
 * __useSetActiveMonitoringConfigMutation__
 *
 * To run a mutation, you first call `useSetActiveMonitoringConfigMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useSetActiveMonitoringConfigMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [setActiveMonitoringConfigMutation, { data, loading, error }] = useSetActiveMonitoringConfigMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSetActiveMonitoringConfigMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.SetActiveMonitoringConfigMutation,
    Types.SetActiveMonitoringConfigMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.SetActiveMonitoringConfigMutation,
    Types.SetActiveMonitoringConfigMutationVariables
  >(SetActiveMonitoringConfigDocument, options);
}
export type SetActiveMonitoringConfigMutationHookResult = ReturnType<
  typeof useSetActiveMonitoringConfigMutation
>;
export type SetActiveMonitoringConfigMutationResult =
  Apollo.MutationResult<Types.SetActiveMonitoringConfigMutation>;
export type SetActiveMonitoringConfigMutationOptions = Apollo.BaseMutationOptions<
  Types.SetActiveMonitoringConfigMutation,
  Types.SetActiveMonitoringConfigMutationVariables
>;
export const DeleteMonitoringConfigDocument = gql`
  mutation DeleteMonitoringConfig($id: Int!) {
    deleteMonitoringConfig(id: $id) {
      ...MonitoringConfig
      devPlan {
        ...DevPlan
      }
    }
  }
  ${MonitoringConfigFragmentDoc}
  ${DevPlanFragmentDoc}
`;
export type DeleteMonitoringConfigMutationFn = Apollo.MutationFunction<
  Types.DeleteMonitoringConfigMutation,
  Types.DeleteMonitoringConfigMutationVariables
>;

/**
 * __useDeleteMonitoringConfigMutation__
 *
 * To run a mutation, you first call `useDeleteMonitoringConfigMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteMonitoringConfigMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteMonitoringConfigMutation, { data, loading, error }] = useDeleteMonitoringConfigMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteMonitoringConfigMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteMonitoringConfigMutation,
    Types.DeleteMonitoringConfigMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteMonitoringConfigMutation,
    Types.DeleteMonitoringConfigMutationVariables
  >(DeleteMonitoringConfigDocument, options);
}
export type DeleteMonitoringConfigMutationHookResult = ReturnType<
  typeof useDeleteMonitoringConfigMutation
>;
export type DeleteMonitoringConfigMutationResult =
  Apollo.MutationResult<Types.DeleteMonitoringConfigMutation>;
export type DeleteMonitoringConfigMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteMonitoringConfigMutation,
  Types.DeleteMonitoringConfigMutationVariables
>;
export const GetOdssDocument = gql`
  query GetOdss {
    getOdss {
      ...Ods
    }
  }
  ${OdsFragmentDoc}
`;

/**
 * __useGetOdssQuery__
 *
 * To run a query within a React component, call `useGetOdssQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetOdssQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetOdssQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetOdssQuery(
  baseOptions?: Apollo.QueryHookOptions<Types.GetOdssQuery, Types.GetOdssQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetOdssQuery, Types.GetOdssQueryVariables>(GetOdssDocument, options);
}
export function useGetOdssLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetOdssQuery, Types.GetOdssQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetOdssQuery, Types.GetOdssQueryVariables>(
    GetOdssDocument,
    options,
  );
}
export function useGetOdssSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetOdssQuery, Types.GetOdssQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetOdssQuery, Types.GetOdssQueryVariables>(
    GetOdssDocument,
    options,
  );
}
export type GetOdssQueryHookResult = ReturnType<typeof useGetOdssQuery>;
export type GetOdssLazyQueryHookResult = ReturnType<typeof useGetOdssLazyQuery>;
export type GetOdssSuspenseQueryHookResult = ReturnType<typeof useGetOdssSuspenseQuery>;
export type GetOdssQueryResult = Apollo.QueryResult<
  Types.GetOdssQuery,
  Types.GetOdssQueryVariables
>;
export const GetOdsDocument = gql`
  query GetOds($getOdsId: Int!) {
    getOds(id: $getOdsId) {
      ...Ods
    }
  }
  ${OdsFragmentDoc}
`;

/**
 * __useGetOdsQuery__
 *
 * To run a query within a React component, call `useGetOdsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetOdsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetOdsQuery({
 *   variables: {
 *      getOdsId: // value for 'getOdsId'
 *   },
 * });
 */
export function useGetOdsQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetOdsQuery, Types.GetOdsQueryVariables> &
    ({ variables: Types.GetOdsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetOdsQuery, Types.GetOdsQueryVariables>(GetOdsDocument, options);
}
export function useGetOdsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetOdsQuery, Types.GetOdsQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetOdsQuery, Types.GetOdsQueryVariables>(
    GetOdsDocument,
    options,
  );
}
export function useGetOdsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetOdsQuery, Types.GetOdsQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetOdsQuery, Types.GetOdsQueryVariables>(
    GetOdsDocument,
    options,
  );
}
export type GetOdsQueryHookResult = ReturnType<typeof useGetOdsQuery>;
export type GetOdsLazyQueryHookResult = ReturnType<typeof useGetOdsLazyQuery>;
export type GetOdsSuspenseQueryHookResult = ReturnType<typeof useGetOdsSuspenseQuery>;
export type GetOdsQueryResult = Apollo.QueryResult<Types.GetOdsQuery, Types.GetOdsQueryVariables>;
export const GetUnitsDocument = gql`
  query GetUnits {
    getUnits {
      ...Unit
    }
  }
  ${UnitFragmentDoc}
`;

/**
 * __useGetUnitsQuery__
 *
 * To run a query within a React component, call `useGetUnitsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetUnitsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetUnitsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetUnitsQuery(
  baseOptions?: Apollo.QueryHookOptions<Types.GetUnitsQuery, Types.GetUnitsQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetUnitsQuery, Types.GetUnitsQueryVariables>(
    GetUnitsDocument,
    options,
  );
}
export function useGetUnitsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetUnitsQuery, Types.GetUnitsQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetUnitsQuery, Types.GetUnitsQueryVariables>(
    GetUnitsDocument,
    options,
  );
}
export function useGetUnitsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetUnitsQuery, Types.GetUnitsQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetUnitsQuery, Types.GetUnitsQueryVariables>(
    GetUnitsDocument,
    options,
  );
}
export type GetUnitsQueryHookResult = ReturnType<typeof useGetUnitsQuery>;
export type GetUnitsLazyQueryHookResult = ReturnType<typeof useGetUnitsLazyQuery>;
export type GetUnitsSuspenseQueryHookResult = ReturnType<typeof useGetUnitsSuspenseQuery>;
export type GetUnitsQueryResult = Apollo.QueryResult<
  Types.GetUnitsQuery,
  Types.GetUnitsQueryVariables
>;
export const GetUnitDocument = gql`
  query GetUnit($getUnitId: Int!) {
    getUnit(id: $getUnitId) {
      ...Unit
    }
  }
  ${UnitFragmentDoc}
`;

/**
 * __useGetUnitQuery__
 *
 * To run a query within a React component, call `useGetUnitQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetUnitQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetUnitQuery({
 *   variables: {
 *      getUnitId: // value for 'getUnitId'
 *   },
 * });
 */
export function useGetUnitQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetUnitQuery, Types.GetUnitQueryVariables> &
    ({ variables: Types.GetUnitQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetUnitQuery, Types.GetUnitQueryVariables>(GetUnitDocument, options);
}
export function useGetUnitLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetUnitQuery, Types.GetUnitQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetUnitQuery, Types.GetUnitQueryVariables>(
    GetUnitDocument,
    options,
  );
}
export function useGetUnitSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetUnitQuery, Types.GetUnitQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetUnitQuery, Types.GetUnitQueryVariables>(
    GetUnitDocument,
    options,
  );
}
export type GetUnitQueryHookResult = ReturnType<typeof useGetUnitQuery>;
export type GetUnitLazyQueryHookResult = ReturnType<typeof useGetUnitLazyQuery>;
export type GetUnitSuspenseQueryHookResult = ReturnType<typeof useGetUnitSuspenseQuery>;
export type GetUnitQueryResult = Apollo.QueryResult<
  Types.GetUnitQuery,
  Types.GetUnitQueryVariables
>;
export const GetGoalsDocument = gql`
  query GetGoals($devPlanLevelId: Int!, $goalTypes: [GoalType!]) {
    getGoals(devPlanLevelId: $devPlanLevelId, goalTypes: $goalTypes) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      devPlanLevel {
        ...DevPlanLevel
        devPlan {
          ...DevPlan
        }
      }
      history {
        ...GoalHistory
        createdByAccount {
          ...UserAccount
        }
      }
      schedule {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      tracking {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      activities {
        ...SiifActividadMeta
      }
      monitoringRecords {
        ...MonitoringRecordWithStatus
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanLevelFragmentDoc}
  ${DevPlanFragmentDoc}
  ${GoalHistoryFragmentDoc}
  ${UserAccountFragmentDoc}
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
  ${SiifActividadMetaFragmentDoc}
  ${MonitoringRecordWithStatusFragmentDoc}
`;

/**
 * __useGetGoalsQuery__
 *
 * To run a query within a React component, call `useGetGoalsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGoalsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGoalsQuery({
 *   variables: {
 *      devPlanLevelId: // value for 'devPlanLevelId'
 *      goalTypes: // value for 'goalTypes'
 *   },
 * });
 */
export function useGetGoalsQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetGoalsQuery, Types.GetGoalsQueryVariables> &
    ({ variables: Types.GetGoalsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetGoalsQuery, Types.GetGoalsQueryVariables>(
    GetGoalsDocument,
    options,
  );
}
export function useGetGoalsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetGoalsQuery, Types.GetGoalsQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetGoalsQuery, Types.GetGoalsQueryVariables>(
    GetGoalsDocument,
    options,
  );
}
export function useGetGoalsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetGoalsQuery, Types.GetGoalsQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetGoalsQuery, Types.GetGoalsQueryVariables>(
    GetGoalsDocument,
    options,
  );
}
export type GetGoalsQueryHookResult = ReturnType<typeof useGetGoalsQuery>;
export type GetGoalsLazyQueryHookResult = ReturnType<typeof useGetGoalsLazyQuery>;
export type GetGoalsSuspenseQueryHookResult = ReturnType<typeof useGetGoalsSuspenseQuery>;
export type GetGoalsQueryResult = Apollo.QueryResult<
  Types.GetGoalsQuery,
  Types.GetGoalsQueryVariables
>;
export const GetPublicPoliticGoalsDocument = gql`
  query GetPublicPoliticGoals($publicPoliticId: Int!) {
    getPublicPoliticGoals(publicPoliticId: $publicPoliticId) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      schedule {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      tracking {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      monitoringRecords {
        ...MonitoringRecordWithStatus
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
  ${MonitoringRecordWithStatusFragmentDoc}
`;

/**
 * __useGetPublicPoliticGoalsQuery__
 *
 * To run a query within a React component, call `useGetPublicPoliticGoalsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPublicPoliticGoalsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPublicPoliticGoalsQuery({
 *   variables: {
 *      publicPoliticId: // value for 'publicPoliticId'
 *   },
 * });
 */
export function useGetPublicPoliticGoalsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetPublicPoliticGoalsQuery,
    Types.GetPublicPoliticGoalsQueryVariables
  > &
    ({ variables: Types.GetPublicPoliticGoalsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetPublicPoliticGoalsQuery,
    Types.GetPublicPoliticGoalsQueryVariables
  >(GetPublicPoliticGoalsDocument, options);
}
export function useGetPublicPoliticGoalsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPublicPoliticGoalsQuery,
    Types.GetPublicPoliticGoalsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetPublicPoliticGoalsQuery,
    Types.GetPublicPoliticGoalsQueryVariables
  >(GetPublicPoliticGoalsDocument, options);
}
export function useGetPublicPoliticGoalsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPublicPoliticGoalsQuery,
        Types.GetPublicPoliticGoalsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetPublicPoliticGoalsQuery,
    Types.GetPublicPoliticGoalsQueryVariables
  >(GetPublicPoliticGoalsDocument, options);
}
export type GetPublicPoliticGoalsQueryHookResult = ReturnType<typeof useGetPublicPoliticGoalsQuery>;
export type GetPublicPoliticGoalsLazyQueryHookResult = ReturnType<
  typeof useGetPublicPoliticGoalsLazyQuery
>;
export type GetPublicPoliticGoalsSuspenseQueryHookResult = ReturnType<
  typeof useGetPublicPoliticGoalsSuspenseQuery
>;
export type GetPublicPoliticGoalsQueryResult = Apollo.QueryResult<
  Types.GetPublicPoliticGoalsQuery,
  Types.GetPublicPoliticGoalsQueryVariables
>;
export const GetGoalsWithScheduleDocument = gql`
  query GetGoalsWithSchedule($devPlanLevelId: Int!) {
    getGoals(devPlanLevelId: $devPlanLevelId) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      devPlanLevel {
        ...DevPlanLevel
        devPlan {
          ...DevPlan
        }
      }
      schedule {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      tracking {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      activities {
        ...SiifActividadMeta
      }
      monitoringRecords {
        ...MonitoringRecordWithStatus
      }
      actividad {
        ...VActividadesPry
      }
      proyecto {
        ...Proyecto
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanLevelFragmentDoc}
  ${DevPlanFragmentDoc}
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
  ${SiifActividadMetaFragmentDoc}
  ${MonitoringRecordWithStatusFragmentDoc}
  ${VActividadesPryFragmentDoc}
  ${ProyectoFragmentDoc}
`;

/**
 * __useGetGoalsWithScheduleQuery__
 *
 * To run a query within a React component, call `useGetGoalsWithScheduleQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGoalsWithScheduleQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGoalsWithScheduleQuery({
 *   variables: {
 *      devPlanLevelId: // value for 'devPlanLevelId'
 *   },
 * });
 */
export function useGetGoalsWithScheduleQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetGoalsWithScheduleQuery,
    Types.GetGoalsWithScheduleQueryVariables
  > &
    ({ variables: Types.GetGoalsWithScheduleQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetGoalsWithScheduleQuery, Types.GetGoalsWithScheduleQueryVariables>(
    GetGoalsWithScheduleDocument,
    options,
  );
}
export function useGetGoalsWithScheduleLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetGoalsWithScheduleQuery,
    Types.GetGoalsWithScheduleQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetGoalsWithScheduleQuery,
    Types.GetGoalsWithScheduleQueryVariables
  >(GetGoalsWithScheduleDocument, options);
}
export function useGetGoalsWithScheduleSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetGoalsWithScheduleQuery,
        Types.GetGoalsWithScheduleQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetGoalsWithScheduleQuery,
    Types.GetGoalsWithScheduleQueryVariables
  >(GetGoalsWithScheduleDocument, options);
}
export type GetGoalsWithScheduleQueryHookResult = ReturnType<typeof useGetGoalsWithScheduleQuery>;
export type GetGoalsWithScheduleLazyQueryHookResult = ReturnType<
  typeof useGetGoalsWithScheduleLazyQuery
>;
export type GetGoalsWithScheduleSuspenseQueryHookResult = ReturnType<
  typeof useGetGoalsWithScheduleSuspenseQuery
>;
export type GetGoalsWithScheduleQueryResult = Apollo.QueryResult<
  Types.GetGoalsWithScheduleQuery,
  Types.GetGoalsWithScheduleQueryVariables
>;
export const GetParentLevelGoalsDocument = gql`
  query GetParentLevelGoals($devPlanLevelId: Int!) {
    getParentLevelGoals(devPlanLevelId: $devPlanLevelId) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useGetParentLevelGoalsQuery__
 *
 * To run a query within a React component, call `useGetParentLevelGoalsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetParentLevelGoalsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetParentLevelGoalsQuery({
 *   variables: {
 *      devPlanLevelId: // value for 'devPlanLevelId'
 *   },
 * });
 */
export function useGetParentLevelGoalsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetParentLevelGoalsQuery,
    Types.GetParentLevelGoalsQueryVariables
  > &
    ({ variables: Types.GetParentLevelGoalsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetParentLevelGoalsQuery, Types.GetParentLevelGoalsQueryVariables>(
    GetParentLevelGoalsDocument,
    options,
  );
}
export function useGetParentLevelGoalsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetParentLevelGoalsQuery,
    Types.GetParentLevelGoalsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetParentLevelGoalsQuery,
    Types.GetParentLevelGoalsQueryVariables
  >(GetParentLevelGoalsDocument, options);
}
export function useGetParentLevelGoalsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetParentLevelGoalsQuery,
        Types.GetParentLevelGoalsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetParentLevelGoalsQuery,
    Types.GetParentLevelGoalsQueryVariables
  >(GetParentLevelGoalsDocument, options);
}
export type GetParentLevelGoalsQueryHookResult = ReturnType<typeof useGetParentLevelGoalsQuery>;
export type GetParentLevelGoalsLazyQueryHookResult = ReturnType<
  typeof useGetParentLevelGoalsLazyQuery
>;
export type GetParentLevelGoalsSuspenseQueryHookResult = ReturnType<
  typeof useGetParentLevelGoalsSuspenseQuery
>;
export type GetParentLevelGoalsQueryResult = Apollo.QueryResult<
  Types.GetParentLevelGoalsQuery,
  Types.GetParentLevelGoalsQueryVariables
>;
export const GetGoalDocument = gql`
  query GetGoal($id: Int!) {
    getGoal(id: $id) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      ods {
        ...Ods
      }
      publicPolitic {
        ...PublicPolitic
      }
      peacePolitic {
        ...PublicPolitic
      }
      victimsPolitic {
        ...PublicPolitic
      }
      productCatalog {
        ...ProductCatalog
      }
      devPlanLevel {
        ...DevPlanLevel
        devPlan {
          ...DevPlan
        }
      }
      history {
        ...GoalHistory
        monitoringRecord {
          ...MonitoringRecord
        }
        createdByAccount {
          ...UserAccount
        }
      }
      schedule {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      tracking {
        ...MonitoringRecord
        resources {
          ...MonitoringRecordResource
        }
      }
      activities {
        ...SiifActividadMeta
      }
      monitoringRecords {
        ...MonitoringRecordWithStatus
      }
      actividad {
        ...VActividadesPry
      }
      proyecto {
        ...Proyecto
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${OdsFragmentDoc}
  ${PublicPoliticFragmentDoc}
  ${ProductCatalogFragmentDoc}
  ${DevPlanLevelFragmentDoc}
  ${DevPlanFragmentDoc}
  ${GoalHistoryFragmentDoc}
  ${MonitoringRecordFragmentDoc}
  ${UserAccountFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
  ${SiifActividadMetaFragmentDoc}
  ${MonitoringRecordWithStatusFragmentDoc}
  ${VActividadesPryFragmentDoc}
  ${ProyectoFragmentDoc}
`;

/**
 * __useGetGoalQuery__
 *
 * To run a query within a React component, call `useGetGoalQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGoalQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGoalQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetGoalQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetGoalQuery, Types.GetGoalQueryVariables> &
    ({ variables: Types.GetGoalQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetGoalQuery, Types.GetGoalQueryVariables>(GetGoalDocument, options);
}
export function useGetGoalLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetGoalQuery, Types.GetGoalQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetGoalQuery, Types.GetGoalQueryVariables>(
    GetGoalDocument,
    options,
  );
}
export function useGetGoalSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetGoalQuery, Types.GetGoalQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetGoalQuery, Types.GetGoalQueryVariables>(
    GetGoalDocument,
    options,
  );
}
export type GetGoalQueryHookResult = ReturnType<typeof useGetGoalQuery>;
export type GetGoalLazyQueryHookResult = ReturnType<typeof useGetGoalLazyQuery>;
export type GetGoalSuspenseQueryHookResult = ReturnType<typeof useGetGoalSuspenseQuery>;
export type GetGoalQueryResult = Apollo.QueryResult<
  Types.GetGoalQuery,
  Types.GetGoalQueryVariables
>;
export const SearchGoalsDocument = gql`
  query SearchGoals($data: SearchGoals!) {
    searchGoals(data: $data) {
      count
      countByType {
        ...GoalTypeCount
      }
      items {
        ...GoalData
        children {
          ...GoalData
        }
      }
      filters
    }
  }
  ${GoalTypeCountFragmentDoc}
  ${GoalDataFragmentDoc}
`;

/**
 * __useSearchGoalsQuery__
 *
 * To run a query within a React component, call `useSearchGoalsQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchGoalsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchGoalsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchGoalsQuery(
  baseOptions: Apollo.QueryHookOptions<Types.SearchGoalsQuery, Types.SearchGoalsQueryVariables> &
    ({ variables: Types.SearchGoalsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchGoalsQuery, Types.SearchGoalsQueryVariables>(
    SearchGoalsDocument,
    options,
  );
}
export function useSearchGoalsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchGoalsQuery,
    Types.SearchGoalsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.SearchGoalsQuery, Types.SearchGoalsQueryVariables>(
    SearchGoalsDocument,
    options,
  );
}
export function useSearchGoalsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.SearchGoalsQuery, Types.SearchGoalsQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.SearchGoalsQuery, Types.SearchGoalsQueryVariables>(
    SearchGoalsDocument,
    options,
  );
}
export type SearchGoalsQueryHookResult = ReturnType<typeof useSearchGoalsQuery>;
export type SearchGoalsLazyQueryHookResult = ReturnType<typeof useSearchGoalsLazyQuery>;
export type SearchGoalsSuspenseQueryHookResult = ReturnType<typeof useSearchGoalsSuspenseQuery>;
export type SearchGoalsQueryResult = Apollo.QueryResult<
  Types.SearchGoalsQuery,
  Types.SearchGoalsQueryVariables
>;
export const SearchGoalsSummaryDocument = gql`
  query SearchGoalsSummary($data: SearchGoals!) {
    searchGoals(data: $data) {
      count
      countByType {
        ...GoalTypeCount
      }
      items {
        ...Goal
        entity {
          ...Entity
        }
        devPlanLevel {
          ...DevPlanLevel
          devPlan {
            ...DevPlan
          }
        }
      }
      filters
    }
  }
  ${GoalTypeCountFragmentDoc}
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanLevelFragmentDoc}
  ${DevPlanFragmentDoc}
`;

/**
 * __useSearchGoalsSummaryQuery__
 *
 * To run a query within a React component, call `useSearchGoalsSummaryQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchGoalsSummaryQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchGoalsSummaryQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchGoalsSummaryQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchGoalsSummaryQuery,
    Types.SearchGoalsSummaryQueryVariables
  > &
    ({ variables: Types.SearchGoalsSummaryQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchGoalsSummaryQuery, Types.SearchGoalsSummaryQueryVariables>(
    SearchGoalsSummaryDocument,
    options,
  );
}
export function useSearchGoalsSummaryLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchGoalsSummaryQuery,
    Types.SearchGoalsSummaryQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.SearchGoalsSummaryQuery, Types.SearchGoalsSummaryQueryVariables>(
    SearchGoalsSummaryDocument,
    options,
  );
}
export function useSearchGoalsSummarySuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchGoalsSummaryQuery,
        Types.SearchGoalsSummaryQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchGoalsSummaryQuery,
    Types.SearchGoalsSummaryQueryVariables
  >(SearchGoalsSummaryDocument, options);
}
export type SearchGoalsSummaryQueryHookResult = ReturnType<typeof useSearchGoalsSummaryQuery>;
export type SearchGoalsSummaryLazyQueryHookResult = ReturnType<
  typeof useSearchGoalsSummaryLazyQuery
>;
export type SearchGoalsSummarySuspenseQueryHookResult = ReturnType<
  typeof useSearchGoalsSummarySuspenseQuery
>;
export type SearchGoalsSummaryQueryResult = Apollo.QueryResult<
  Types.SearchGoalsSummaryQuery,
  Types.SearchGoalsSummaryQueryVariables
>;
export const SearchGoalsFormatDocument = gql`
  query SearchGoalsFormat($data: SearchGoalsFormat!) {
    searchGoalsFormat(data: $data)
  }
`;

/**
 * __useSearchGoalsFormatQuery__
 *
 * To run a query within a React component, call `useSearchGoalsFormatQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchGoalsFormatQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchGoalsFormatQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchGoalsFormatQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchGoalsFormatQuery,
    Types.SearchGoalsFormatQueryVariables
  > &
    ({ variables: Types.SearchGoalsFormatQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchGoalsFormatQuery, Types.SearchGoalsFormatQueryVariables>(
    SearchGoalsFormatDocument,
    options,
  );
}
export function useSearchGoalsFormatLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchGoalsFormatQuery,
    Types.SearchGoalsFormatQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.SearchGoalsFormatQuery, Types.SearchGoalsFormatQueryVariables>(
    SearchGoalsFormatDocument,
    options,
  );
}
export function useSearchGoalsFormatSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchGoalsFormatQuery,
        Types.SearchGoalsFormatQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchGoalsFormatQuery,
    Types.SearchGoalsFormatQueryVariables
  >(SearchGoalsFormatDocument, options);
}
export type SearchGoalsFormatQueryHookResult = ReturnType<typeof useSearchGoalsFormatQuery>;
export type SearchGoalsFormatLazyQueryHookResult = ReturnType<typeof useSearchGoalsFormatLazyQuery>;
export type SearchGoalsFormatSuspenseQueryHookResult = ReturnType<
  typeof useSearchGoalsFormatSuspenseQuery
>;
export type SearchGoalsFormatQueryResult = Apollo.QueryResult<
  Types.SearchGoalsFormatQuery,
  Types.SearchGoalsFormatQueryVariables
>;
export const DashboardGoalsFormatDocument = gql`
  query DashboardGoalsFormat($data: SearchGoalsFormat!) {
    dashboardGoalsFormat(data: $data)
  }
`;

/**
 * __useDashboardGoalsFormatQuery__
 *
 * To run a query within a React component, call `useDashboardGoalsFormatQuery` and pass it any options that fit your needs.
 * When your component renders, `useDashboardGoalsFormatQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useDashboardGoalsFormatQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useDashboardGoalsFormatQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.DashboardGoalsFormatQuery,
    Types.DashboardGoalsFormatQueryVariables
  > &
    ({ variables: Types.DashboardGoalsFormatQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.DashboardGoalsFormatQuery, Types.DashboardGoalsFormatQueryVariables>(
    DashboardGoalsFormatDocument,
    options,
  );
}
export function useDashboardGoalsFormatLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.DashboardGoalsFormatQuery,
    Types.DashboardGoalsFormatQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.DashboardGoalsFormatQuery,
    Types.DashboardGoalsFormatQueryVariables
  >(DashboardGoalsFormatDocument, options);
}
export function useDashboardGoalsFormatSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.DashboardGoalsFormatQuery,
        Types.DashboardGoalsFormatQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.DashboardGoalsFormatQuery,
    Types.DashboardGoalsFormatQueryVariables
  >(DashboardGoalsFormatDocument, options);
}
export type DashboardGoalsFormatQueryHookResult = ReturnType<typeof useDashboardGoalsFormatQuery>;
export type DashboardGoalsFormatLazyQueryHookResult = ReturnType<
  typeof useDashboardGoalsFormatLazyQuery
>;
export type DashboardGoalsFormatSuspenseQueryHookResult = ReturnType<
  typeof useDashboardGoalsFormatSuspenseQuery
>;
export type DashboardGoalsFormatQueryResult = Apollo.QueryResult<
  Types.DashboardGoalsFormatQuery,
  Types.DashboardGoalsFormatQueryVariables
>;
export const CreateGoalDocument = gql`
  mutation CreateGoal($data: CreateGoal!) {
    createGoal(data: $data) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      ods {
        ...Ods
      }
      publicPolitic {
        ...PublicPolitic
      }
      peacePolitic {
        ...PublicPolitic
      }
      victimsPolitic {
        ...PublicPolitic
      }
      productCatalog {
        ...ProductCatalog
      }
      actividad {
        ...VActividadesPry
      }
      proyecto {
        ...Proyecto
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${OdsFragmentDoc}
  ${PublicPoliticFragmentDoc}
  ${ProductCatalogFragmentDoc}
  ${VActividadesPryFragmentDoc}
  ${ProyectoFragmentDoc}
`;
export type CreateGoalMutationFn = Apollo.MutationFunction<
  Types.CreateGoalMutation,
  Types.CreateGoalMutationVariables
>;

/**
 * __useCreateGoalMutation__
 *
 * To run a mutation, you first call `useCreateGoalMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateGoalMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createGoalMutation, { data, loading, error }] = useCreateGoalMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateGoalMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateGoalMutation,
    Types.CreateGoalMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.CreateGoalMutation, Types.CreateGoalMutationVariables>(
    CreateGoalDocument,
    options,
  );
}
export type CreateGoalMutationHookResult = ReturnType<typeof useCreateGoalMutation>;
export type CreateGoalMutationResult = Apollo.MutationResult<Types.CreateGoalMutation>;
export type CreateGoalMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateGoalMutation,
  Types.CreateGoalMutationVariables
>;
export const UpdateGoalDocument = gql`
  mutation UpdateGoal($data: UpdateGoal!) {
    updateGoal(data: $data) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      ods {
        ...Ods
      }
      publicPolitic {
        ...PublicPolitic
      }
      peacePolitic {
        ...PublicPolitic
      }
      victimsPolitic {
        ...PublicPolitic
      }
      productCatalog {
        ...ProductCatalog
      }
      actividad {
        ...VActividadesPry
      }
      proyecto {
        ...Proyecto
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${OdsFragmentDoc}
  ${PublicPoliticFragmentDoc}
  ${ProductCatalogFragmentDoc}
  ${VActividadesPryFragmentDoc}
  ${ProyectoFragmentDoc}
`;
export type UpdateGoalMutationFn = Apollo.MutationFunction<
  Types.UpdateGoalMutation,
  Types.UpdateGoalMutationVariables
>;

/**
 * __useUpdateGoalMutation__
 *
 * To run a mutation, you first call `useUpdateGoalMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateGoalMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateGoalMutation, { data, loading, error }] = useUpdateGoalMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateGoalMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateGoalMutation,
    Types.UpdateGoalMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.UpdateGoalMutation, Types.UpdateGoalMutationVariables>(
    UpdateGoalDocument,
    options,
  );
}
export type UpdateGoalMutationHookResult = ReturnType<typeof useUpdateGoalMutation>;
export type UpdateGoalMutationResult = Apollo.MutationResult<Types.UpdateGoalMutation>;
export type UpdateGoalMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateGoalMutation,
  Types.UpdateGoalMutationVariables
>;
export const DeleteGoalDocument = gql`
  mutation DeleteGoal($id: Int!) {
    deleteGoal(id: $id) {
      ...Goal
      children {
        ...Goal
      }
    }
  }
  ${GoalFragmentDoc}
`;
export type DeleteGoalMutationFn = Apollo.MutationFunction<
  Types.DeleteGoalMutation,
  Types.DeleteGoalMutationVariables
>;

/**
 * __useDeleteGoalMutation__
 *
 * To run a mutation, you first call `useDeleteGoalMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteGoalMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteGoalMutation, { data, loading, error }] = useDeleteGoalMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteGoalMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteGoalMutation,
    Types.DeleteGoalMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<Types.DeleteGoalMutation, Types.DeleteGoalMutationVariables>(
    DeleteGoalDocument,
    options,
  );
}
export type DeleteGoalMutationHookResult = ReturnType<typeof useDeleteGoalMutation>;
export type DeleteGoalMutationResult = Apollo.MutationResult<Types.DeleteGoalMutation>;
export type DeleteGoalMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteGoalMutation,
  Types.DeleteGoalMutationVariables
>;
export const GetPublicPoliticsDocument = gql`
  query GetPublicPolitics {
    getPublicPolitics {
      ...PublicPolitic
      goalCount
      components {
        ...PublicPoliticComponent
      }
    }
  }
  ${PublicPoliticFragmentDoc}
  ${PublicPoliticComponentFragmentDoc}
`;

/**
 * __useGetPublicPoliticsQuery__
 *
 * To run a query within a React component, call `useGetPublicPoliticsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPublicPoliticsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPublicPoliticsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetPublicPoliticsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetPublicPoliticsQuery,
    Types.GetPublicPoliticsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetPublicPoliticsQuery, Types.GetPublicPoliticsQueryVariables>(
    GetPublicPoliticsDocument,
    options,
  );
}
export function useGetPublicPoliticsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPublicPoliticsQuery,
    Types.GetPublicPoliticsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetPublicPoliticsQuery, Types.GetPublicPoliticsQueryVariables>(
    GetPublicPoliticsDocument,
    options,
  );
}
export function useGetPublicPoliticsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPublicPoliticsQuery,
        Types.GetPublicPoliticsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetPublicPoliticsQuery,
    Types.GetPublicPoliticsQueryVariables
  >(GetPublicPoliticsDocument, options);
}
export type GetPublicPoliticsQueryHookResult = ReturnType<typeof useGetPublicPoliticsQuery>;
export type GetPublicPoliticsLazyQueryHookResult = ReturnType<typeof useGetPublicPoliticsLazyQuery>;
export type GetPublicPoliticsSuspenseQueryHookResult = ReturnType<
  typeof useGetPublicPoliticsSuspenseQuery
>;
export type GetPublicPoliticsQueryResult = Apollo.QueryResult<
  Types.GetPublicPoliticsQuery,
  Types.GetPublicPoliticsQueryVariables
>;
export const SearchPublicPoliticsDocument = gql`
  query SearchPublicPolitics($data: SearchPublicPolitic!) {
    searchPublicPolitics(data: $data) {
      count
      filters
      items {
        ...PublicPolitic
        goalCount
        components {
          ...PublicPoliticComponent
        }
      }
    }
  }
  ${PublicPoliticFragmentDoc}
  ${PublicPoliticComponentFragmentDoc}
`;

/**
 * __useSearchPublicPoliticsQuery__
 *
 * To run a query within a React component, call `useSearchPublicPoliticsQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchPublicPoliticsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchPublicPoliticsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchPublicPoliticsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchPublicPoliticsQuery,
    Types.SearchPublicPoliticsQueryVariables
  > &
    ({ variables: Types.SearchPublicPoliticsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchPublicPoliticsQuery, Types.SearchPublicPoliticsQueryVariables>(
    SearchPublicPoliticsDocument,
    options,
  );
}
export function useSearchPublicPoliticsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchPublicPoliticsQuery,
    Types.SearchPublicPoliticsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.SearchPublicPoliticsQuery,
    Types.SearchPublicPoliticsQueryVariables
  >(SearchPublicPoliticsDocument, options);
}
export function useSearchPublicPoliticsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchPublicPoliticsQuery,
        Types.SearchPublicPoliticsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchPublicPoliticsQuery,
    Types.SearchPublicPoliticsQueryVariables
  >(SearchPublicPoliticsDocument, options);
}
export type SearchPublicPoliticsQueryHookResult = ReturnType<typeof useSearchPublicPoliticsQuery>;
export type SearchPublicPoliticsLazyQueryHookResult = ReturnType<
  typeof useSearchPublicPoliticsLazyQuery
>;
export type SearchPublicPoliticsSuspenseQueryHookResult = ReturnType<
  typeof useSearchPublicPoliticsSuspenseQuery
>;
export type SearchPublicPoliticsQueryResult = Apollo.QueryResult<
  Types.SearchPublicPoliticsQuery,
  Types.SearchPublicPoliticsQueryVariables
>;
export const GetPublicPoliticDocument = gql`
  query GetPublicPolitic($id: Int!) {
    getPublicPolitic(id: $id) {
      ...PublicPolitic
      components {
        ...PublicPoliticComponent
      }
    }
  }
  ${PublicPoliticFragmentDoc}
  ${PublicPoliticComponentFragmentDoc}
`;

/**
 * __useGetPublicPoliticQuery__
 *
 * To run a query within a React component, call `useGetPublicPoliticQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPublicPoliticQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPublicPoliticQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetPublicPoliticQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetPublicPoliticQuery,
    Types.GetPublicPoliticQueryVariables
  > &
    ({ variables: Types.GetPublicPoliticQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetPublicPoliticQuery, Types.GetPublicPoliticQueryVariables>(
    GetPublicPoliticDocument,
    options,
  );
}
export function useGetPublicPoliticLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPublicPoliticQuery,
    Types.GetPublicPoliticQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetPublicPoliticQuery, Types.GetPublicPoliticQueryVariables>(
    GetPublicPoliticDocument,
    options,
  );
}
export function useGetPublicPoliticSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPublicPoliticQuery,
        Types.GetPublicPoliticQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetPublicPoliticQuery, Types.GetPublicPoliticQueryVariables>(
    GetPublicPoliticDocument,
    options,
  );
}
export type GetPublicPoliticQueryHookResult = ReturnType<typeof useGetPublicPoliticQuery>;
export type GetPublicPoliticLazyQueryHookResult = ReturnType<typeof useGetPublicPoliticLazyQuery>;
export type GetPublicPoliticSuspenseQueryHookResult = ReturnType<
  typeof useGetPublicPoliticSuspenseQuery
>;
export type GetPublicPoliticQueryResult = Apollo.QueryResult<
  Types.GetPublicPoliticQuery,
  Types.GetPublicPoliticQueryVariables
>;
export const CreatePublicPoliticDocument = gql`
  mutation CreatePublicPolitic($data: CreatePublicPolitic!) {
    createPublicPolitic(data: $data) {
      ...PublicPolitic
      components {
        ...PublicPoliticComponent
      }
    }
  }
  ${PublicPoliticFragmentDoc}
  ${PublicPoliticComponentFragmentDoc}
`;
export type CreatePublicPoliticMutationFn = Apollo.MutationFunction<
  Types.CreatePublicPoliticMutation,
  Types.CreatePublicPoliticMutationVariables
>;

/**
 * __useCreatePublicPoliticMutation__
 *
 * To run a mutation, you first call `useCreatePublicPoliticMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreatePublicPoliticMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createPublicPoliticMutation, { data, loading, error }] = useCreatePublicPoliticMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreatePublicPoliticMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreatePublicPoliticMutation,
    Types.CreatePublicPoliticMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreatePublicPoliticMutation,
    Types.CreatePublicPoliticMutationVariables
  >(CreatePublicPoliticDocument, options);
}
export type CreatePublicPoliticMutationHookResult = ReturnType<
  typeof useCreatePublicPoliticMutation
>;
export type CreatePublicPoliticMutationResult =
  Apollo.MutationResult<Types.CreatePublicPoliticMutation>;
export type CreatePublicPoliticMutationOptions = Apollo.BaseMutationOptions<
  Types.CreatePublicPoliticMutation,
  Types.CreatePublicPoliticMutationVariables
>;
export const UpdatePublicPoliticDocument = gql`
  mutation UpdatePublicPolitic($data: UpdatePublicPolitic!) {
    updatePublicPolitic(data: $data) {
      ...PublicPolitic
      components {
        ...PublicPoliticComponent
      }
    }
  }
  ${PublicPoliticFragmentDoc}
  ${PublicPoliticComponentFragmentDoc}
`;
export type UpdatePublicPoliticMutationFn = Apollo.MutationFunction<
  Types.UpdatePublicPoliticMutation,
  Types.UpdatePublicPoliticMutationVariables
>;

/**
 * __useUpdatePublicPoliticMutation__
 *
 * To run a mutation, you first call `useUpdatePublicPoliticMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdatePublicPoliticMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updatePublicPoliticMutation, { data, loading, error }] = useUpdatePublicPoliticMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdatePublicPoliticMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdatePublicPoliticMutation,
    Types.UpdatePublicPoliticMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdatePublicPoliticMutation,
    Types.UpdatePublicPoliticMutationVariables
  >(UpdatePublicPoliticDocument, options);
}
export type UpdatePublicPoliticMutationHookResult = ReturnType<
  typeof useUpdatePublicPoliticMutation
>;
export type UpdatePublicPoliticMutationResult =
  Apollo.MutationResult<Types.UpdatePublicPoliticMutation>;
export type UpdatePublicPoliticMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdatePublicPoliticMutation,
  Types.UpdatePublicPoliticMutationVariables
>;
export const DeletePublicPoliticDocument = gql`
  mutation DeletePublicPolitic($id: Int!) {
    deletePublicPolitic(id: $id) {
      ...PublicPolitic
    }
  }
  ${PublicPoliticFragmentDoc}
`;
export type DeletePublicPoliticMutationFn = Apollo.MutationFunction<
  Types.DeletePublicPoliticMutation,
  Types.DeletePublicPoliticMutationVariables
>;

/**
 * __useDeletePublicPoliticMutation__
 *
 * To run a mutation, you first call `useDeletePublicPoliticMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeletePublicPoliticMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deletePublicPoliticMutation, { data, loading, error }] = useDeletePublicPoliticMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeletePublicPoliticMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeletePublicPoliticMutation,
    Types.DeletePublicPoliticMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeletePublicPoliticMutation,
    Types.DeletePublicPoliticMutationVariables
  >(DeletePublicPoliticDocument, options);
}
export type DeletePublicPoliticMutationHookResult = ReturnType<
  typeof useDeletePublicPoliticMutation
>;
export type DeletePublicPoliticMutationResult =
  Apollo.MutationResult<Types.DeletePublicPoliticMutation>;
export type DeletePublicPoliticMutationOptions = Apollo.BaseMutationOptions<
  Types.DeletePublicPoliticMutation,
  Types.DeletePublicPoliticMutationVariables
>;
export const GetPublicPoliticComponentsDocument = gql`
  query GetPublicPoliticComponents {
    getPublicPoliticComponents {
      ...PublicPoliticComponent
    }
  }
  ${PublicPoliticComponentFragmentDoc}
`;

/**
 * __useGetPublicPoliticComponentsQuery__
 *
 * To run a query within a React component, call `useGetPublicPoliticComponentsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPublicPoliticComponentsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPublicPoliticComponentsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetPublicPoliticComponentsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetPublicPoliticComponentsQuery,
    Types.GetPublicPoliticComponentsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetPublicPoliticComponentsQuery,
    Types.GetPublicPoliticComponentsQueryVariables
  >(GetPublicPoliticComponentsDocument, options);
}
export function useGetPublicPoliticComponentsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPublicPoliticComponentsQuery,
    Types.GetPublicPoliticComponentsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetPublicPoliticComponentsQuery,
    Types.GetPublicPoliticComponentsQueryVariables
  >(GetPublicPoliticComponentsDocument, options);
}
export function useGetPublicPoliticComponentsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPublicPoliticComponentsQuery,
        Types.GetPublicPoliticComponentsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetPublicPoliticComponentsQuery,
    Types.GetPublicPoliticComponentsQueryVariables
  >(GetPublicPoliticComponentsDocument, options);
}
export type GetPublicPoliticComponentsQueryHookResult = ReturnType<
  typeof useGetPublicPoliticComponentsQuery
>;
export type GetPublicPoliticComponentsLazyQueryHookResult = ReturnType<
  typeof useGetPublicPoliticComponentsLazyQuery
>;
export type GetPublicPoliticComponentsSuspenseQueryHookResult = ReturnType<
  typeof useGetPublicPoliticComponentsSuspenseQuery
>;
export type GetPublicPoliticComponentsQueryResult = Apollo.QueryResult<
  Types.GetPublicPoliticComponentsQuery,
  Types.GetPublicPoliticComponentsQueryVariables
>;
export const GetPublicPoliticComponentDocument = gql`
  query GetPublicPoliticComponent($id: Int!) {
    getPublicPoliticComponent(id: $id) {
      ...PublicPoliticComponent
    }
  }
  ${PublicPoliticComponentFragmentDoc}
`;

/**
 * __useGetPublicPoliticComponentQuery__
 *
 * To run a query within a React component, call `useGetPublicPoliticComponentQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPublicPoliticComponentQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPublicPoliticComponentQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetPublicPoliticComponentQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetPublicPoliticComponentQuery,
    Types.GetPublicPoliticComponentQueryVariables
  > &
    (
      | { variables: Types.GetPublicPoliticComponentQueryVariables; skip?: boolean }
      | { skip: boolean }
    ),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetPublicPoliticComponentQuery,
    Types.GetPublicPoliticComponentQueryVariables
  >(GetPublicPoliticComponentDocument, options);
}
export function useGetPublicPoliticComponentLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPublicPoliticComponentQuery,
    Types.GetPublicPoliticComponentQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetPublicPoliticComponentQuery,
    Types.GetPublicPoliticComponentQueryVariables
  >(GetPublicPoliticComponentDocument, options);
}
export function useGetPublicPoliticComponentSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPublicPoliticComponentQuery,
        Types.GetPublicPoliticComponentQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetPublicPoliticComponentQuery,
    Types.GetPublicPoliticComponentQueryVariables
  >(GetPublicPoliticComponentDocument, options);
}
export type GetPublicPoliticComponentQueryHookResult = ReturnType<
  typeof useGetPublicPoliticComponentQuery
>;
export type GetPublicPoliticComponentLazyQueryHookResult = ReturnType<
  typeof useGetPublicPoliticComponentLazyQuery
>;
export type GetPublicPoliticComponentSuspenseQueryHookResult = ReturnType<
  typeof useGetPublicPoliticComponentSuspenseQuery
>;
export type GetPublicPoliticComponentQueryResult = Apollo.QueryResult<
  Types.GetPublicPoliticComponentQuery,
  Types.GetPublicPoliticComponentQueryVariables
>;
export const CreatePublicPoliticComponentDocument = gql`
  mutation CreatePublicPoliticComponent($data: CreatePublicPoliticComponent!) {
    createPublicPoliticComponent(data: $data) {
      ...PublicPoliticComponent
    }
  }
  ${PublicPoliticComponentFragmentDoc}
`;
export type CreatePublicPoliticComponentMutationFn = Apollo.MutationFunction<
  Types.CreatePublicPoliticComponentMutation,
  Types.CreatePublicPoliticComponentMutationVariables
>;

/**
 * __useCreatePublicPoliticComponentMutation__
 *
 * To run a mutation, you first call `useCreatePublicPoliticComponentMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreatePublicPoliticComponentMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createPublicPoliticComponentMutation, { data, loading, error }] = useCreatePublicPoliticComponentMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreatePublicPoliticComponentMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreatePublicPoliticComponentMutation,
    Types.CreatePublicPoliticComponentMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreatePublicPoliticComponentMutation,
    Types.CreatePublicPoliticComponentMutationVariables
  >(CreatePublicPoliticComponentDocument, options);
}
export type CreatePublicPoliticComponentMutationHookResult = ReturnType<
  typeof useCreatePublicPoliticComponentMutation
>;
export type CreatePublicPoliticComponentMutationResult =
  Apollo.MutationResult<Types.CreatePublicPoliticComponentMutation>;
export type CreatePublicPoliticComponentMutationOptions = Apollo.BaseMutationOptions<
  Types.CreatePublicPoliticComponentMutation,
  Types.CreatePublicPoliticComponentMutationVariables
>;
export const UpdatePublicPoliticComponentDocument = gql`
  mutation UpdatePublicPoliticComponent($data: UpdatePublicPoliticComponent!) {
    updatePublicPoliticComponent(data: $data) {
      ...PublicPoliticComponent
    }
  }
  ${PublicPoliticComponentFragmentDoc}
`;
export type UpdatePublicPoliticComponentMutationFn = Apollo.MutationFunction<
  Types.UpdatePublicPoliticComponentMutation,
  Types.UpdatePublicPoliticComponentMutationVariables
>;

/**
 * __useUpdatePublicPoliticComponentMutation__
 *
 * To run a mutation, you first call `useUpdatePublicPoliticComponentMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdatePublicPoliticComponentMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updatePublicPoliticComponentMutation, { data, loading, error }] = useUpdatePublicPoliticComponentMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdatePublicPoliticComponentMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdatePublicPoliticComponentMutation,
    Types.UpdatePublicPoliticComponentMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdatePublicPoliticComponentMutation,
    Types.UpdatePublicPoliticComponentMutationVariables
  >(UpdatePublicPoliticComponentDocument, options);
}
export type UpdatePublicPoliticComponentMutationHookResult = ReturnType<
  typeof useUpdatePublicPoliticComponentMutation
>;
export type UpdatePublicPoliticComponentMutationResult =
  Apollo.MutationResult<Types.UpdatePublicPoliticComponentMutation>;
export type UpdatePublicPoliticComponentMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdatePublicPoliticComponentMutation,
  Types.UpdatePublicPoliticComponentMutationVariables
>;
export const DeletePublicPoliticComponentDocument = gql`
  mutation DeletePublicPoliticComponent($id: Int!) {
    deletePublicPoliticComponent(id: $id) {
      ...PublicPoliticComponent
    }
  }
  ${PublicPoliticComponentFragmentDoc}
`;
export type DeletePublicPoliticComponentMutationFn = Apollo.MutationFunction<
  Types.DeletePublicPoliticComponentMutation,
  Types.DeletePublicPoliticComponentMutationVariables
>;

/**
 * __useDeletePublicPoliticComponentMutation__
 *
 * To run a mutation, you first call `useDeletePublicPoliticComponentMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeletePublicPoliticComponentMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deletePublicPoliticComponentMutation, { data, loading, error }] = useDeletePublicPoliticComponentMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeletePublicPoliticComponentMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeletePublicPoliticComponentMutation,
    Types.DeletePublicPoliticComponentMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeletePublicPoliticComponentMutation,
    Types.DeletePublicPoliticComponentMutationVariables
  >(DeletePublicPoliticComponentDocument, options);
}
export type DeletePublicPoliticComponentMutationHookResult = ReturnType<
  typeof useDeletePublicPoliticComponentMutation
>;
export type DeletePublicPoliticComponentMutationResult =
  Apollo.MutationResult<Types.DeletePublicPoliticComponentMutation>;
export type DeletePublicPoliticComponentMutationOptions = Apollo.BaseMutationOptions<
  Types.DeletePublicPoliticComponentMutation,
  Types.DeletePublicPoliticComponentMutationVariables
>;
export const GetMacroProjectsDocument = gql`
  query GetMacroProjects {
    getMacroProjects {
      ...MacroProject
    }
  }
  ${MacroProjectFragmentDoc}
`;

/**
 * __useGetMacroProjectsQuery__
 *
 * To run a query within a React component, call `useGetMacroProjectsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMacroProjectsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMacroProjectsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetMacroProjectsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetMacroProjectsQuery,
    Types.GetMacroProjectsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetMacroProjectsQuery, Types.GetMacroProjectsQueryVariables>(
    GetMacroProjectsDocument,
    options,
  );
}
export function useGetMacroProjectsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMacroProjectsQuery,
    Types.GetMacroProjectsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetMacroProjectsQuery, Types.GetMacroProjectsQueryVariables>(
    GetMacroProjectsDocument,
    options,
  );
}
export function useGetMacroProjectsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMacroProjectsQuery,
        Types.GetMacroProjectsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetMacroProjectsQuery, Types.GetMacroProjectsQueryVariables>(
    GetMacroProjectsDocument,
    options,
  );
}
export type GetMacroProjectsQueryHookResult = ReturnType<typeof useGetMacroProjectsQuery>;
export type GetMacroProjectsLazyQueryHookResult = ReturnType<typeof useGetMacroProjectsLazyQuery>;
export type GetMacroProjectsSuspenseQueryHookResult = ReturnType<
  typeof useGetMacroProjectsSuspenseQuery
>;
export type GetMacroProjectsQueryResult = Apollo.QueryResult<
  Types.GetMacroProjectsQuery,
  Types.GetMacroProjectsQueryVariables
>;
export const GetMacroProjectDocument = gql`
  query GetMacroProject($id: Int!) {
    getMacroProject(id: $id) {
      ...MacroProject
    }
  }
  ${MacroProjectFragmentDoc}
`;

/**
 * __useGetMacroProjectQuery__
 *
 * To run a query within a React component, call `useGetMacroProjectQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMacroProjectQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMacroProjectQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetMacroProjectQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetMacroProjectQuery,
    Types.GetMacroProjectQueryVariables
  > &
    ({ variables: Types.GetMacroProjectQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetMacroProjectQuery, Types.GetMacroProjectQueryVariables>(
    GetMacroProjectDocument,
    options,
  );
}
export function useGetMacroProjectLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMacroProjectQuery,
    Types.GetMacroProjectQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetMacroProjectQuery, Types.GetMacroProjectQueryVariables>(
    GetMacroProjectDocument,
    options,
  );
}
export function useGetMacroProjectSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMacroProjectQuery,
        Types.GetMacroProjectQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetMacroProjectQuery, Types.GetMacroProjectQueryVariables>(
    GetMacroProjectDocument,
    options,
  );
}
export type GetMacroProjectQueryHookResult = ReturnType<typeof useGetMacroProjectQuery>;
export type GetMacroProjectLazyQueryHookResult = ReturnType<typeof useGetMacroProjectLazyQuery>;
export type GetMacroProjectSuspenseQueryHookResult = ReturnType<
  typeof useGetMacroProjectSuspenseQuery
>;
export type GetMacroProjectQueryResult = Apollo.QueryResult<
  Types.GetMacroProjectQuery,
  Types.GetMacroProjectQueryVariables
>;
export const CreateMacroProjectDocument = gql`
  mutation CreateMacroProject($data: CreateMacroProject!) {
    createMacroProject(data: $data) {
      ...MacroProject
    }
  }
  ${MacroProjectFragmentDoc}
`;
export type CreateMacroProjectMutationFn = Apollo.MutationFunction<
  Types.CreateMacroProjectMutation,
  Types.CreateMacroProjectMutationVariables
>;

/**
 * __useCreateMacroProjectMutation__
 *
 * To run a mutation, you first call `useCreateMacroProjectMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateMacroProjectMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createMacroProjectMutation, { data, loading, error }] = useCreateMacroProjectMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateMacroProjectMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateMacroProjectMutation,
    Types.CreateMacroProjectMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreateMacroProjectMutation,
    Types.CreateMacroProjectMutationVariables
  >(CreateMacroProjectDocument, options);
}
export type CreateMacroProjectMutationHookResult = ReturnType<typeof useCreateMacroProjectMutation>;
export type CreateMacroProjectMutationResult =
  Apollo.MutationResult<Types.CreateMacroProjectMutation>;
export type CreateMacroProjectMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateMacroProjectMutation,
  Types.CreateMacroProjectMutationVariables
>;
export const UpdateMacroProjectDocument = gql`
  mutation UpdateMacroProject($data: UpdateMacroProject!) {
    updateMacroProject(data: $data) {
      ...MacroProject
    }
  }
  ${MacroProjectFragmentDoc}
`;
export type UpdateMacroProjectMutationFn = Apollo.MutationFunction<
  Types.UpdateMacroProjectMutation,
  Types.UpdateMacroProjectMutationVariables
>;

/**
 * __useUpdateMacroProjectMutation__
 *
 * To run a mutation, you first call `useUpdateMacroProjectMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateMacroProjectMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateMacroProjectMutation, { data, loading, error }] = useUpdateMacroProjectMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateMacroProjectMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateMacroProjectMutation,
    Types.UpdateMacroProjectMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdateMacroProjectMutation,
    Types.UpdateMacroProjectMutationVariables
  >(UpdateMacroProjectDocument, options);
}
export type UpdateMacroProjectMutationHookResult = ReturnType<typeof useUpdateMacroProjectMutation>;
export type UpdateMacroProjectMutationResult =
  Apollo.MutationResult<Types.UpdateMacroProjectMutation>;
export type UpdateMacroProjectMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateMacroProjectMutation,
  Types.UpdateMacroProjectMutationVariables
>;
export const DeleteMacroProjectDocument = gql`
  mutation DeleteMacroProject($id: Int!) {
    deleteMacroProject(id: $id) {
      ...MacroProject
    }
  }
  ${MacroProjectFragmentDoc}
`;
export type DeleteMacroProjectMutationFn = Apollo.MutationFunction<
  Types.DeleteMacroProjectMutation,
  Types.DeleteMacroProjectMutationVariables
>;

/**
 * __useDeleteMacroProjectMutation__
 *
 * To run a mutation, you first call `useDeleteMacroProjectMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteMacroProjectMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteMacroProjectMutation, { data, loading, error }] = useDeleteMacroProjectMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteMacroProjectMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteMacroProjectMutation,
    Types.DeleteMacroProjectMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteMacroProjectMutation,
    Types.DeleteMacroProjectMutationVariables
  >(DeleteMacroProjectDocument, options);
}
export type DeleteMacroProjectMutationHookResult = ReturnType<typeof useDeleteMacroProjectMutation>;
export type DeleteMacroProjectMutationResult =
  Apollo.MutationResult<Types.DeleteMacroProjectMutation>;
export type DeleteMacroProjectMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteMacroProjectMutation,
  Types.DeleteMacroProjectMutationVariables
>;
export const GetProductIndicatorsDocument = gql`
  query GetProductIndicators {
    getProductIndicators {
      count
      items {
        id
        code
        name
      }
    }
  }
`;

/**
 * __useGetProductIndicatorsQuery__
 *
 * To run a query within a React component, call `useGetProductIndicatorsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProductIndicatorsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetProductIndicatorsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetProductIndicatorsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetProductIndicatorsQuery,
    Types.GetProductIndicatorsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetProductIndicatorsQuery, Types.GetProductIndicatorsQueryVariables>(
    GetProductIndicatorsDocument,
    options,
  );
}
export function useGetProductIndicatorsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetProductIndicatorsQuery,
    Types.GetProductIndicatorsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetProductIndicatorsQuery,
    Types.GetProductIndicatorsQueryVariables
  >(GetProductIndicatorsDocument, options);
}
export function useGetProductIndicatorsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetProductIndicatorsQuery,
        Types.GetProductIndicatorsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetProductIndicatorsQuery,
    Types.GetProductIndicatorsQueryVariables
  >(GetProductIndicatorsDocument, options);
}
export type GetProductIndicatorsQueryHookResult = ReturnType<typeof useGetProductIndicatorsQuery>;
export type GetProductIndicatorsLazyQueryHookResult = ReturnType<
  typeof useGetProductIndicatorsLazyQuery
>;
export type GetProductIndicatorsSuspenseQueryHookResult = ReturnType<
  typeof useGetProductIndicatorsSuspenseQuery
>;
export type GetProductIndicatorsQueryResult = Apollo.QueryResult<
  Types.GetProductIndicatorsQuery,
  Types.GetProductIndicatorsQueryVariables
>;
export const GetProductSectorsDocument = gql`
  query GetProductSectors {
    getProductSectors {
      count
      items {
        id
        code
        name
      }
    }
  }
`;

/**
 * __useGetProductSectorsQuery__
 *
 * To run a query within a React component, call `useGetProductSectorsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProductSectorsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetProductSectorsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetProductSectorsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetProductSectorsQuery,
    Types.GetProductSectorsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetProductSectorsQuery, Types.GetProductSectorsQueryVariables>(
    GetProductSectorsDocument,
    options,
  );
}
export function useGetProductSectorsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetProductSectorsQuery,
    Types.GetProductSectorsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetProductSectorsQuery, Types.GetProductSectorsQueryVariables>(
    GetProductSectorsDocument,
    options,
  );
}
export function useGetProductSectorsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetProductSectorsQuery,
        Types.GetProductSectorsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetProductSectorsQuery,
    Types.GetProductSectorsQueryVariables
  >(GetProductSectorsDocument, options);
}
export type GetProductSectorsQueryHookResult = ReturnType<typeof useGetProductSectorsQuery>;
export type GetProductSectorsLazyQueryHookResult = ReturnType<typeof useGetProductSectorsLazyQuery>;
export type GetProductSectorsSuspenseQueryHookResult = ReturnType<
  typeof useGetProductSectorsSuspenseQuery
>;
export type GetProductSectorsQueryResult = Apollo.QueryResult<
  Types.GetProductSectorsQuery,
  Types.GetProductSectorsQueryVariables
>;
export const SearchProductIndicatorsDocument = gql`
  query SearchProductIndicators($data: SearchProductCatalog!) {
    searchProductIndicators(data: $data) {
      count
      items {
        ...ProductCatalog
        product {
          ...ProductCatalog
          program {
            ...ProductCatalog
            sector {
              ...ProductCatalog
            }
          }
        }
      }
    }
  }
  ${ProductCatalogFragmentDoc}
`;

/**
 * __useSearchProductIndicatorsQuery__
 *
 * To run a query within a React component, call `useSearchProductIndicatorsQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchProductIndicatorsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchProductIndicatorsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchProductIndicatorsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchProductIndicatorsQuery,
    Types.SearchProductIndicatorsQueryVariables
  > &
    (
      | { variables: Types.SearchProductIndicatorsQueryVariables; skip?: boolean }
      | { skip: boolean }
    ),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.SearchProductIndicatorsQuery,
    Types.SearchProductIndicatorsQueryVariables
  >(SearchProductIndicatorsDocument, options);
}
export function useSearchProductIndicatorsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchProductIndicatorsQuery,
    Types.SearchProductIndicatorsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.SearchProductIndicatorsQuery,
    Types.SearchProductIndicatorsQueryVariables
  >(SearchProductIndicatorsDocument, options);
}
export function useSearchProductIndicatorsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchProductIndicatorsQuery,
        Types.SearchProductIndicatorsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchProductIndicatorsQuery,
    Types.SearchProductIndicatorsQueryVariables
  >(SearchProductIndicatorsDocument, options);
}
export type SearchProductIndicatorsQueryHookResult = ReturnType<
  typeof useSearchProductIndicatorsQuery
>;
export type SearchProductIndicatorsLazyQueryHookResult = ReturnType<
  typeof useSearchProductIndicatorsLazyQuery
>;
export type SearchProductIndicatorsSuspenseQueryHookResult = ReturnType<
  typeof useSearchProductIndicatorsSuspenseQuery
>;
export type SearchProductIndicatorsQueryResult = Apollo.QueryResult<
  Types.SearchProductIndicatorsQuery,
  Types.SearchProductIndicatorsQueryVariables
>;
export const CreateMonitoringRecordDocument = gql`
  mutation CreateMonitoringRecord($data: CreateMonitoringRecord!) {
    createMonitoringRecord(data: $data) {
      ...MonitoringRecord
    }
  }
  ${MonitoringRecordFragmentDoc}
`;
export type CreateMonitoringRecordMutationFn = Apollo.MutationFunction<
  Types.CreateMonitoringRecordMutation,
  Types.CreateMonitoringRecordMutationVariables
>;

/**
 * __useCreateMonitoringRecordMutation__
 *
 * To run a mutation, you first call `useCreateMonitoringRecordMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateMonitoringRecordMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createMonitoringRecordMutation, { data, loading, error }] = useCreateMonitoringRecordMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateMonitoringRecordMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateMonitoringRecordMutation,
    Types.CreateMonitoringRecordMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreateMonitoringRecordMutation,
    Types.CreateMonitoringRecordMutationVariables
  >(CreateMonitoringRecordDocument, options);
}
export type CreateMonitoringRecordMutationHookResult = ReturnType<
  typeof useCreateMonitoringRecordMutation
>;
export type CreateMonitoringRecordMutationResult =
  Apollo.MutationResult<Types.CreateMonitoringRecordMutation>;
export type CreateMonitoringRecordMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateMonitoringRecordMutation,
  Types.CreateMonitoringRecordMutationVariables
>;
export const UpdateMonitoringRecordDocument = gql`
  mutation UpdateMonitoringRecord($data: UpdateMonitoringRecord!) {
    updateMonitoringRecord(data: $data) {
      ...MonitoringRecord
    }
  }
  ${MonitoringRecordFragmentDoc}
`;
export type UpdateMonitoringRecordMutationFn = Apollo.MutationFunction<
  Types.UpdateMonitoringRecordMutation,
  Types.UpdateMonitoringRecordMutationVariables
>;

/**
 * __useUpdateMonitoringRecordMutation__
 *
 * To run a mutation, you first call `useUpdateMonitoringRecordMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateMonitoringRecordMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateMonitoringRecordMutation, { data, loading, error }] = useUpdateMonitoringRecordMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateMonitoringRecordMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateMonitoringRecordMutation,
    Types.UpdateMonitoringRecordMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdateMonitoringRecordMutation,
    Types.UpdateMonitoringRecordMutationVariables
  >(UpdateMonitoringRecordDocument, options);
}
export type UpdateMonitoringRecordMutationHookResult = ReturnType<
  typeof useUpdateMonitoringRecordMutation
>;
export type UpdateMonitoringRecordMutationResult =
  Apollo.MutationResult<Types.UpdateMonitoringRecordMutation>;
export type UpdateMonitoringRecordMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateMonitoringRecordMutation,
  Types.UpdateMonitoringRecordMutationVariables
>;
export const GetUserAccountsDocument = gql`
  query GetUserAccounts {
    getUserAccounts {
      ...UserAccount
      entity {
        ...Entity
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useGetUserAccountsQuery__
 *
 * To run a query within a React component, call `useGetUserAccountsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetUserAccountsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetUserAccountsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetUserAccountsQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetUserAccountsQuery,
    Types.GetUserAccountsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetUserAccountsQuery, Types.GetUserAccountsQueryVariables>(
    GetUserAccountsDocument,
    options,
  );
}
export function useGetUserAccountsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetUserAccountsQuery,
    Types.GetUserAccountsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetUserAccountsQuery, Types.GetUserAccountsQueryVariables>(
    GetUserAccountsDocument,
    options,
  );
}
export function useGetUserAccountsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetUserAccountsQuery,
        Types.GetUserAccountsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetUserAccountsQuery, Types.GetUserAccountsQueryVariables>(
    GetUserAccountsDocument,
    options,
  );
}
export type GetUserAccountsQueryHookResult = ReturnType<typeof useGetUserAccountsQuery>;
export type GetUserAccountsLazyQueryHookResult = ReturnType<typeof useGetUserAccountsLazyQuery>;
export type GetUserAccountsSuspenseQueryHookResult = ReturnType<
  typeof useGetUserAccountsSuspenseQuery
>;
export type GetUserAccountsQueryResult = Apollo.QueryResult<
  Types.GetUserAccountsQuery,
  Types.GetUserAccountsQueryVariables
>;
export const GetUserAccountDocument = gql`
  query GetUserAccount($id: Int!) {
    getUserAccount(id: $id) {
      ...UserAccount
      entity {
        ...Entity
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useGetUserAccountQuery__
 *
 * To run a query within a React component, call `useGetUserAccountQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetUserAccountQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetUserAccountQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetUserAccountQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetUserAccountQuery,
    Types.GetUserAccountQueryVariables
  > &
    ({ variables: Types.GetUserAccountQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetUserAccountQuery, Types.GetUserAccountQueryVariables>(
    GetUserAccountDocument,
    options,
  );
}
export function useGetUserAccountLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetUserAccountQuery,
    Types.GetUserAccountQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetUserAccountQuery, Types.GetUserAccountQueryVariables>(
    GetUserAccountDocument,
    options,
  );
}
export function useGetUserAccountSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetUserAccountQuery,
        Types.GetUserAccountQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetUserAccountQuery, Types.GetUserAccountQueryVariables>(
    GetUserAccountDocument,
    options,
  );
}
export type GetUserAccountQueryHookResult = ReturnType<typeof useGetUserAccountQuery>;
export type GetUserAccountLazyQueryHookResult = ReturnType<typeof useGetUserAccountLazyQuery>;
export type GetUserAccountSuspenseQueryHookResult = ReturnType<
  typeof useGetUserAccountSuspenseQuery
>;
export type GetUserAccountQueryResult = Apollo.QueryResult<
  Types.GetUserAccountQuery,
  Types.GetUserAccountQueryVariables
>;
export const ChangeUserAccountPasswordDocument = gql`
  mutation ChangeUserAccountPassword($data: ChangeUserAccountPassword!) {
    changeUserAccountPassword(data: $data) {
      ...UserAccount
      entity {
        ...Entity
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;
export type ChangeUserAccountPasswordMutationFn = Apollo.MutationFunction<
  Types.ChangeUserAccountPasswordMutation,
  Types.ChangeUserAccountPasswordMutationVariables
>;

/**
 * __useChangeUserAccountPasswordMutation__
 *
 * To run a mutation, you first call `useChangeUserAccountPasswordMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useChangeUserAccountPasswordMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [changeUserAccountPasswordMutation, { data, loading, error }] = useChangeUserAccountPasswordMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useChangeUserAccountPasswordMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.ChangeUserAccountPasswordMutation,
    Types.ChangeUserAccountPasswordMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.ChangeUserAccountPasswordMutation,
    Types.ChangeUserAccountPasswordMutationVariables
  >(ChangeUserAccountPasswordDocument, options);
}
export type ChangeUserAccountPasswordMutationHookResult = ReturnType<
  typeof useChangeUserAccountPasswordMutation
>;
export type ChangeUserAccountPasswordMutationResult =
  Apollo.MutationResult<Types.ChangeUserAccountPasswordMutation>;
export type ChangeUserAccountPasswordMutationOptions = Apollo.BaseMutationOptions<
  Types.ChangeUserAccountPasswordMutation,
  Types.ChangeUserAccountPasswordMutationVariables
>;
export const AdminChangeUserAccountPasswordDocument = gql`
  mutation AdminChangeUserAccountPassword($data: AdminChangeUserAccountPassword!) {
    adminChangeUserAccountPassword(data: $data) {
      ...UserAccount
      entity {
        ...Entity
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;
export type AdminChangeUserAccountPasswordMutationFn = Apollo.MutationFunction<
  Types.AdminChangeUserAccountPasswordMutation,
  Types.AdminChangeUserAccountPasswordMutationVariables
>;

/**
 * __useAdminChangeUserAccountPasswordMutation__
 *
 * To run a mutation, you first call `useAdminChangeUserAccountPasswordMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useAdminChangeUserAccountPasswordMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [adminChangeUserAccountPasswordMutation, { data, loading, error }] = useAdminChangeUserAccountPasswordMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useAdminChangeUserAccountPasswordMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.AdminChangeUserAccountPasswordMutation,
    Types.AdminChangeUserAccountPasswordMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.AdminChangeUserAccountPasswordMutation,
    Types.AdminChangeUserAccountPasswordMutationVariables
  >(AdminChangeUserAccountPasswordDocument, options);
}
export type AdminChangeUserAccountPasswordMutationHookResult = ReturnType<
  typeof useAdminChangeUserAccountPasswordMutation
>;
export type AdminChangeUserAccountPasswordMutationResult =
  Apollo.MutationResult<Types.AdminChangeUserAccountPasswordMutation>;
export type AdminChangeUserAccountPasswordMutationOptions = Apollo.BaseMutationOptions<
  Types.AdminChangeUserAccountPasswordMutation,
  Types.AdminChangeUserAccountPasswordMutationVariables
>;
export const CreateUserAccountDocument = gql`
  mutation CreateUserAccount($data: CreateUserAccount!) {
    createUserAccount(data: $data) {
      ...UserAccount
      entity {
        ...Entity
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;
export type CreateUserAccountMutationFn = Apollo.MutationFunction<
  Types.CreateUserAccountMutation,
  Types.CreateUserAccountMutationVariables
>;

/**
 * __useCreateUserAccountMutation__
 *
 * To run a mutation, you first call `useCreateUserAccountMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateUserAccountMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createUserAccountMutation, { data, loading, error }] = useCreateUserAccountMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateUserAccountMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateUserAccountMutation,
    Types.CreateUserAccountMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreateUserAccountMutation,
    Types.CreateUserAccountMutationVariables
  >(CreateUserAccountDocument, options);
}
export type CreateUserAccountMutationHookResult = ReturnType<typeof useCreateUserAccountMutation>;
export type CreateUserAccountMutationResult =
  Apollo.MutationResult<Types.CreateUserAccountMutation>;
export type CreateUserAccountMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateUserAccountMutation,
  Types.CreateUserAccountMutationVariables
>;
export const UpdateUserAccountDocument = gql`
  mutation UpdateUserAccount($data: UpdateUserAccount!) {
    updateUserAccount(data: $data) {
      ...UserAccount
      entity {
        ...Entity
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;
export type UpdateUserAccountMutationFn = Apollo.MutationFunction<
  Types.UpdateUserAccountMutation,
  Types.UpdateUserAccountMutationVariables
>;

/**
 * __useUpdateUserAccountMutation__
 *
 * To run a mutation, you first call `useUpdateUserAccountMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateUserAccountMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateUserAccountMutation, { data, loading, error }] = useUpdateUserAccountMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUpdateUserAccountMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.UpdateUserAccountMutation,
    Types.UpdateUserAccountMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.UpdateUserAccountMutation,
    Types.UpdateUserAccountMutationVariables
  >(UpdateUserAccountDocument, options);
}
export type UpdateUserAccountMutationHookResult = ReturnType<typeof useUpdateUserAccountMutation>;
export type UpdateUserAccountMutationResult =
  Apollo.MutationResult<Types.UpdateUserAccountMutation>;
export type UpdateUserAccountMutationOptions = Apollo.BaseMutationOptions<
  Types.UpdateUserAccountMutation,
  Types.UpdateUserAccountMutationVariables
>;
export const SearchUserAccountsDocument = gql`
  query SearchUserAccounts($data: SearchUserAccount!) {
    searchUserAccounts(data: $data) {
      count
      items {
        ...UserAccount
        entity {
          ...Entity
        }
      }
    }
  }
  ${UserAccountFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useSearchUserAccountsQuery__
 *
 * To run a query within a React component, call `useSearchUserAccountsQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchUserAccountsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchUserAccountsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchUserAccountsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchUserAccountsQuery,
    Types.SearchUserAccountsQueryVariables
  > &
    ({ variables: Types.SearchUserAccountsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchUserAccountsQuery, Types.SearchUserAccountsQueryVariables>(
    SearchUserAccountsDocument,
    options,
  );
}
export function useSearchUserAccountsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchUserAccountsQuery,
    Types.SearchUserAccountsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.SearchUserAccountsQuery, Types.SearchUserAccountsQueryVariables>(
    SearchUserAccountsDocument,
    options,
  );
}
export function useSearchUserAccountsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchUserAccountsQuery,
        Types.SearchUserAccountsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchUserAccountsQuery,
    Types.SearchUserAccountsQueryVariables
  >(SearchUserAccountsDocument, options);
}
export type SearchUserAccountsQueryHookResult = ReturnType<typeof useSearchUserAccountsQuery>;
export type SearchUserAccountsLazyQueryHookResult = ReturnType<
  typeof useSearchUserAccountsLazyQuery
>;
export type SearchUserAccountsSuspenseQueryHookResult = ReturnType<
  typeof useSearchUserAccountsSuspenseQuery
>;
export type SearchUserAccountsQueryResult = Apollo.QueryResult<
  Types.SearchUserAccountsQuery,
  Types.SearchUserAccountsQueryVariables
>;
export const DeleteUserAccountDocument = gql`
  mutation DeleteUserAccount($id: Int!) {
    deleteUserAccount(id: $id)
  }
`;
export type DeleteUserAccountMutationFn = Apollo.MutationFunction<
  Types.DeleteUserAccountMutation,
  Types.DeleteUserAccountMutationVariables
>;

/**
 * __useDeleteUserAccountMutation__
 *
 * To run a mutation, you first call `useDeleteUserAccountMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteUserAccountMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteUserAccountMutation, { data, loading, error }] = useDeleteUserAccountMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteUserAccountMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteUserAccountMutation,
    Types.DeleteUserAccountMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteUserAccountMutation,
    Types.DeleteUserAccountMutationVariables
  >(DeleteUserAccountDocument, options);
}
export type DeleteUserAccountMutationHookResult = ReturnType<typeof useDeleteUserAccountMutation>;
export type DeleteUserAccountMutationResult =
  Apollo.MutationResult<Types.DeleteUserAccountMutation>;
export type DeleteUserAccountMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteUserAccountMutation,
  Types.DeleteUserAccountMutationVariables
>;
export const UserLoginDocument = gql`
  query UserLogin($data: LoginUserAccount!) {
    userLogin(data: $data) {
      ...UserLoggedIn
      entity {
        ...Entity
      }
    }
  }
  ${UserLoggedInFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useUserLoginQuery__
 *
 * To run a query within a React component, call `useUserLoginQuery` and pass it any options that fit your needs.
 * When your component renders, `useUserLoginQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useUserLoginQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useUserLoginQuery(
  baseOptions: Apollo.QueryHookOptions<Types.UserLoginQuery, Types.UserLoginQueryVariables> &
    ({ variables: Types.UserLoginQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.UserLoginQuery, Types.UserLoginQueryVariables>(
    UserLoginDocument,
    options,
  );
}
export function useUserLoginLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.UserLoginQuery, Types.UserLoginQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.UserLoginQuery, Types.UserLoginQueryVariables>(
    UserLoginDocument,
    options,
  );
}
export function useUserLoginSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.UserLoginQuery, Types.UserLoginQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.UserLoginQuery, Types.UserLoginQueryVariables>(
    UserLoginDocument,
    options,
  );
}
export type UserLoginQueryHookResult = ReturnType<typeof useUserLoginQuery>;
export type UserLoginLazyQueryHookResult = ReturnType<typeof useUserLoginLazyQuery>;
export type UserLoginSuspenseQueryHookResult = ReturnType<typeof useUserLoginSuspenseQuery>;
export type UserLoginQueryResult = Apollo.QueryResult<
  Types.UserLoginQuery,
  Types.UserLoginQueryVariables
>;
export const RefreshTokenDocument = gql`
  query RefreshToken {
    refreshToken {
      ...UserLoggedIn
      entity {
        ...Entity
      }
    }
  }
  ${UserLoggedInFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useRefreshTokenQuery__
 *
 * To run a query within a React component, call `useRefreshTokenQuery` and pass it any options that fit your needs.
 * When your component renders, `useRefreshTokenQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useRefreshTokenQuery({
 *   variables: {
 *   },
 * });
 */
export function useRefreshTokenQuery(
  baseOptions?: Apollo.QueryHookOptions<Types.RefreshTokenQuery, Types.RefreshTokenQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.RefreshTokenQuery, Types.RefreshTokenQueryVariables>(
    RefreshTokenDocument,
    options,
  );
}
export function useRefreshTokenLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.RefreshTokenQuery,
    Types.RefreshTokenQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.RefreshTokenQuery, Types.RefreshTokenQueryVariables>(
    RefreshTokenDocument,
    options,
  );
}
export function useRefreshTokenSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.RefreshTokenQuery, Types.RefreshTokenQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.RefreshTokenQuery, Types.RefreshTokenQueryVariables>(
    RefreshTokenDocument,
    options,
  );
}
export type RefreshTokenQueryHookResult = ReturnType<typeof useRefreshTokenQuery>;
export type RefreshTokenLazyQueryHookResult = ReturnType<typeof useRefreshTokenLazyQuery>;
export type RefreshTokenSuspenseQueryHookResult = ReturnType<typeof useRefreshTokenSuspenseQuery>;
export type RefreshTokenQueryResult = Apollo.QueryResult<
  Types.RefreshTokenQuery,
  Types.RefreshTokenQueryVariables
>;
export const SavePlannedMonitoringRecordDocument = gql`
  mutation SavePlannedMonitoringRecord($data: SavePlannedMonitoringRecord!) {
    savePlannedMonitoringRecord(data: $data) {
      ...MonitoringRecord
      goal {
        ...GoalData
      }
      resources {
        ...MonitoringRecordResource
      }
    }
  }
  ${MonitoringRecordFragmentDoc}
  ${GoalDataFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
`;
export type SavePlannedMonitoringRecordMutationFn = Apollo.MutationFunction<
  Types.SavePlannedMonitoringRecordMutation,
  Types.SavePlannedMonitoringRecordMutationVariables
>;

/**
 * __useSavePlannedMonitoringRecordMutation__
 *
 * To run a mutation, you first call `useSavePlannedMonitoringRecordMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useSavePlannedMonitoringRecordMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [savePlannedMonitoringRecordMutation, { data, loading, error }] = useSavePlannedMonitoringRecordMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSavePlannedMonitoringRecordMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.SavePlannedMonitoringRecordMutation,
    Types.SavePlannedMonitoringRecordMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.SavePlannedMonitoringRecordMutation,
    Types.SavePlannedMonitoringRecordMutationVariables
  >(SavePlannedMonitoringRecordDocument, options);
}
export type SavePlannedMonitoringRecordMutationHookResult = ReturnType<
  typeof useSavePlannedMonitoringRecordMutation
>;
export type SavePlannedMonitoringRecordMutationResult =
  Apollo.MutationResult<Types.SavePlannedMonitoringRecordMutation>;
export type SavePlannedMonitoringRecordMutationOptions = Apollo.BaseMutationOptions<
  Types.SavePlannedMonitoringRecordMutation,
  Types.SavePlannedMonitoringRecordMutationVariables
>;
export const GetMonitoringRecordDocument = gql`
  query GetMonitoringRecord($data: GetMonitoringRecord!) {
    getMonitoringRecord(data: $data) {
      ...MonitoringRecord
      resources {
        ...MonitoringRecordResource
      }
    }
  }
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
`;

/**
 * __useGetMonitoringRecordQuery__
 *
 * To run a query within a React component, call `useGetMonitoringRecordQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMonitoringRecordQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMonitoringRecordQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetMonitoringRecordQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetMonitoringRecordQuery,
    Types.GetMonitoringRecordQueryVariables
  > &
    ({ variables: Types.GetMonitoringRecordQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetMonitoringRecordQuery, Types.GetMonitoringRecordQueryVariables>(
    GetMonitoringRecordDocument,
    options,
  );
}
export function useGetMonitoringRecordLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMonitoringRecordQuery,
    Types.GetMonitoringRecordQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetMonitoringRecordQuery,
    Types.GetMonitoringRecordQueryVariables
  >(GetMonitoringRecordDocument, options);
}
export function useGetMonitoringRecordSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMonitoringRecordQuery,
        Types.GetMonitoringRecordQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetMonitoringRecordQuery,
    Types.GetMonitoringRecordQueryVariables
  >(GetMonitoringRecordDocument, options);
}
export type GetMonitoringRecordQueryHookResult = ReturnType<typeof useGetMonitoringRecordQuery>;
export type GetMonitoringRecordLazyQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordLazyQuery
>;
export type GetMonitoringRecordSuspenseQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordSuspenseQuery
>;
export type GetMonitoringRecordQueryResult = Apollo.QueryResult<
  Types.GetMonitoringRecordQuery,
  Types.GetMonitoringRecordQueryVariables
>;
export const SaveTrackingMonitoringRecordDocument = gql`
  mutation SaveTrackingMonitoringRecord($data: SaveTrackingMonitoringRecord!) {
    saveTrackingMonitoringRecord(data: $data) {
      ...MonitoringRecord
      resources {
        ...MonitoringRecordResource
      }
    }
  }
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
`;
export type SaveTrackingMonitoringRecordMutationFn = Apollo.MutationFunction<
  Types.SaveTrackingMonitoringRecordMutation,
  Types.SaveTrackingMonitoringRecordMutationVariables
>;

/**
 * __useSaveTrackingMonitoringRecordMutation__
 *
 * To run a mutation, you first call `useSaveTrackingMonitoringRecordMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useSaveTrackingMonitoringRecordMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [saveTrackingMonitoringRecordMutation, { data, loading, error }] = useSaveTrackingMonitoringRecordMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSaveTrackingMonitoringRecordMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.SaveTrackingMonitoringRecordMutation,
    Types.SaveTrackingMonitoringRecordMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.SaveTrackingMonitoringRecordMutation,
    Types.SaveTrackingMonitoringRecordMutationVariables
  >(SaveTrackingMonitoringRecordDocument, options);
}
export type SaveTrackingMonitoringRecordMutationHookResult = ReturnType<
  typeof useSaveTrackingMonitoringRecordMutation
>;
export type SaveTrackingMonitoringRecordMutationResult =
  Apollo.MutationResult<Types.SaveTrackingMonitoringRecordMutation>;
export type SaveTrackingMonitoringRecordMutationOptions = Apollo.BaseMutationOptions<
  Types.SaveTrackingMonitoringRecordMutation,
  Types.SaveTrackingMonitoringRecordMutationVariables
>;
export const GetGoalTypeStatsDocument = gql`
  query GetGoalTypeStats($data: GetGoalTypeStats!) {
    getGoalTypeStats(data: $data) {
      ...GetGoalTypeStatsResponse
    }
  }
  ${GetGoalTypeStatsResponseFragmentDoc}
`;

/**
 * __useGetGoalTypeStatsQuery__
 *
 * To run a query within a React component, call `useGetGoalTypeStatsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGoalTypeStatsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGoalTypeStatsQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetGoalTypeStatsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetGoalTypeStatsQuery,
    Types.GetGoalTypeStatsQueryVariables
  > &
    ({ variables: Types.GetGoalTypeStatsQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetGoalTypeStatsQuery, Types.GetGoalTypeStatsQueryVariables>(
    GetGoalTypeStatsDocument,
    options,
  );
}
export function useGetGoalTypeStatsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetGoalTypeStatsQuery,
    Types.GetGoalTypeStatsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetGoalTypeStatsQuery, Types.GetGoalTypeStatsQueryVariables>(
    GetGoalTypeStatsDocument,
    options,
  );
}
export function useGetGoalTypeStatsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetGoalTypeStatsQuery,
        Types.GetGoalTypeStatsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetGoalTypeStatsQuery, Types.GetGoalTypeStatsQueryVariables>(
    GetGoalTypeStatsDocument,
    options,
  );
}
export type GetGoalTypeStatsQueryHookResult = ReturnType<typeof useGetGoalTypeStatsQuery>;
export type GetGoalTypeStatsLazyQueryHookResult = ReturnType<typeof useGetGoalTypeStatsLazyQuery>;
export type GetGoalTypeStatsSuspenseQueryHookResult = ReturnType<
  typeof useGetGoalTypeStatsSuspenseQuery
>;
export type GetGoalTypeStatsQueryResult = Apollo.QueryResult<
  Types.GetGoalTypeStatsQuery,
  Types.GetGoalTypeStatsQueryVariables
>;
export const SearchSiifProyectosDocument = gql`
  query SearchSiifProyectos($data: SearchSiifProyecto!) {
    searchSiifProyectos(data: $data) {
      count
      items {
        ...SiifProyecto
        entity {
          ...Entity
        }
      }
    }
  }
  ${SiifProyectoFragmentDoc}
  ${EntityFragmentDoc}
`;

/**
 * __useSearchSiifProyectosQuery__
 *
 * To run a query within a React component, call `useSearchSiifProyectosQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchSiifProyectosQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchSiifProyectosQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchSiifProyectosQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchSiifProyectosQuery,
    Types.SearchSiifProyectosQueryVariables
  > &
    ({ variables: Types.SearchSiifProyectosQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchSiifProyectosQuery, Types.SearchSiifProyectosQueryVariables>(
    SearchSiifProyectosDocument,
    options,
  );
}
export function useSearchSiifProyectosLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchSiifProyectosQuery,
    Types.SearchSiifProyectosQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.SearchSiifProyectosQuery,
    Types.SearchSiifProyectosQueryVariables
  >(SearchSiifProyectosDocument, options);
}
export function useSearchSiifProyectosSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchSiifProyectosQuery,
        Types.SearchSiifProyectosQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.SearchSiifProyectosQuery,
    Types.SearchSiifProyectosQueryVariables
  >(SearchSiifProyectosDocument, options);
}
export type SearchSiifProyectosQueryHookResult = ReturnType<typeof useSearchSiifProyectosQuery>;
export type SearchSiifProyectosLazyQueryHookResult = ReturnType<
  typeof useSearchSiifProyectosLazyQuery
>;
export type SearchSiifProyectosSuspenseQueryHookResult = ReturnType<
  typeof useSearchSiifProyectosSuspenseQuery
>;
export type SearchSiifProyectosQueryResult = Apollo.QueryResult<
  Types.SearchSiifProyectosQuery,
  Types.SearchSiifProyectosQueryVariables
>;
export const SearchProyectosDocument = gql`
  query SearchProyectos($data: SearchProyecto!) {
    searchProyectos(data: $data) {
      count
      items {
        ...Proyecto
        entity {
          ...Entity
        }
        devPlan {
          ...DevPlan
        }
      }
    }
  }
  ${ProyectoFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanFragmentDoc}
`;

/**
 * __useSearchProyectosQuery__
 *
 * To run a query within a React component, call `useSearchProyectosQuery` and pass it any options that fit your needs.
 * When your component renders, `useSearchProyectosQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useSearchProyectosQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSearchProyectosQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.SearchProyectosQuery,
    Types.SearchProyectosQueryVariables
  > &
    ({ variables: Types.SearchProyectosQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.SearchProyectosQuery, Types.SearchProyectosQueryVariables>(
    SearchProyectosDocument,
    options,
  );
}
export function useSearchProyectosLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.SearchProyectosQuery,
    Types.SearchProyectosQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.SearchProyectosQuery, Types.SearchProyectosQueryVariables>(
    SearchProyectosDocument,
    options,
  );
}
export function useSearchProyectosSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.SearchProyectosQuery,
        Types.SearchProyectosQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.SearchProyectosQuery, Types.SearchProyectosQueryVariables>(
    SearchProyectosDocument,
    options,
  );
}
export type SearchProyectosQueryHookResult = ReturnType<typeof useSearchProyectosQuery>;
export type SearchProyectosLazyQueryHookResult = ReturnType<typeof useSearchProyectosLazyQuery>;
export type SearchProyectosSuspenseQueryHookResult = ReturnType<
  typeof useSearchProyectosSuspenseQuery
>;
export type SearchProyectosQueryResult = Apollo.QueryResult<
  Types.SearchProyectosQuery,
  Types.SearchProyectosQueryVariables
>;
export const GetProyectosForScheduleDocument = gql`
  query GetProyectosForSchedule($data: SearchProyectoForSchedule!) {
    getProyectosForSchedule(data: $data) {
      count
      filters
      items {
        ...Proyecto
        entity {
          ...Entity
        }
        goal {
          ...Goal
          schedule {
            ...MonitoringRecord
            resources {
              ...MonitoringRecordResource
            }
          }
        }
        actividades {
          ...VActividadesPryWithGoals
          goal {
            ...Goal
            schedule {
              ...MonitoringRecord
              resources {
                ...MonitoringRecordResource
              }
            }
          }
        }
      }
    }
  }
  ${ProyectoFragmentDoc}
  ${EntityFragmentDoc}
  ${GoalFragmentDoc}
  ${MonitoringRecordFragmentDoc}
  ${MonitoringRecordResourceFragmentDoc}
  ${VActividadesPryWithGoalsFragmentDoc}
`;

/**
 * __useGetProyectosForScheduleQuery__
 *
 * To run a query within a React component, call `useGetProyectosForScheduleQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProyectosForScheduleQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetProyectosForScheduleQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetProyectosForScheduleQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetProyectosForScheduleQuery,
    Types.GetProyectosForScheduleQueryVariables
  > &
    (
      | { variables: Types.GetProyectosForScheduleQueryVariables; skip?: boolean }
      | { skip: boolean }
    ),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetProyectosForScheduleQuery,
    Types.GetProyectosForScheduleQueryVariables
  >(GetProyectosForScheduleDocument, options);
}
export function useGetProyectosForScheduleLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetProyectosForScheduleQuery,
    Types.GetProyectosForScheduleQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetProyectosForScheduleQuery,
    Types.GetProyectosForScheduleQueryVariables
  >(GetProyectosForScheduleDocument, options);
}
export function useGetProyectosForScheduleSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetProyectosForScheduleQuery,
        Types.GetProyectosForScheduleQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetProyectosForScheduleQuery,
    Types.GetProyectosForScheduleQueryVariables
  >(GetProyectosForScheduleDocument, options);
}
export type GetProyectosForScheduleQueryHookResult = ReturnType<
  typeof useGetProyectosForScheduleQuery
>;
export type GetProyectosForScheduleLazyQueryHookResult = ReturnType<
  typeof useGetProyectosForScheduleLazyQuery
>;
export type GetProyectosForScheduleSuspenseQueryHookResult = ReturnType<
  typeof useGetProyectosForScheduleSuspenseQuery
>;
export type GetProyectosForScheduleQueryResult = Apollo.QueryResult<
  Types.GetProyectosForScheduleQuery,
  Types.GetProyectosForScheduleQueryVariables
>;
export const GetProyectoDocument = gql`
  query GetProyecto($codigo: String!) {
    getProyecto(codigo: $codigo) {
      ...Proyecto
      entity {
        ...Entity
      }
      devPlan {
        ...DevPlan
      }
      actividades {
        ...VActividadesPryWithGoals
        insumos {
          ...Insumo
        }
      }
    }
  }
  ${ProyectoFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanFragmentDoc}
  ${VActividadesPryWithGoalsFragmentDoc}
  ${InsumoFragmentDoc}
`;

/**
 * __useGetProyectoQuery__
 *
 * To run a query within a React component, call `useGetProyectoQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProyectoQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetProyectoQuery({
 *   variables: {
 *      codigo: // value for 'codigo'
 *   },
 * });
 */
export function useGetProyectoQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetProyectoQuery, Types.GetProyectoQueryVariables> &
    ({ variables: Types.GetProyectoQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetProyectoQuery, Types.GetProyectoQueryVariables>(
    GetProyectoDocument,
    options,
  );
}
export function useGetProyectoLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetProyectoQuery,
    Types.GetProyectoQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetProyectoQuery, Types.GetProyectoQueryVariables>(
    GetProyectoDocument,
    options,
  );
}
export function useGetProyectoSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetProyectoQuery, Types.GetProyectoQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetProyectoQuery, Types.GetProyectoQueryVariables>(
    GetProyectoDocument,
    options,
  );
}
export type GetProyectoQueryHookResult = ReturnType<typeof useGetProyectoQuery>;
export type GetProyectoLazyQueryHookResult = ReturnType<typeof useGetProyectoLazyQuery>;
export type GetProyectoSuspenseQueryHookResult = ReturnType<typeof useGetProyectoSuspenseQuery>;
export type GetProyectoQueryResult = Apollo.QueryResult<
  Types.GetProyectoQuery,
  Types.GetProyectoQueryVariables
>;
export const GetActividadesDocument = gql`
  query GetActividades($proyecto: String!) {
    getActividades(proyecto: $proyecto) {
      ...VActividadesPry
      insumos {
        ...Insumo
      }
    }
  }
  ${VActividadesPryFragmentDoc}
  ${InsumoFragmentDoc}
`;

/**
 * __useGetActividadesQuery__
 *
 * To run a query within a React component, call `useGetActividadesQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetActividadesQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetActividadesQuery({
 *   variables: {
 *      proyecto: // value for 'proyecto'
 *   },
 * });
 */
export function useGetActividadesQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetActividadesQuery,
    Types.GetActividadesQueryVariables
  > &
    ({ variables: Types.GetActividadesQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetActividadesQuery, Types.GetActividadesQueryVariables>(
    GetActividadesDocument,
    options,
  );
}
export function useGetActividadesLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetActividadesQuery,
    Types.GetActividadesQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetActividadesQuery, Types.GetActividadesQueryVariables>(
    GetActividadesDocument,
    options,
  );
}
export function useGetActividadesSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetActividadesQuery,
        Types.GetActividadesQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetActividadesQuery, Types.GetActividadesQueryVariables>(
    GetActividadesDocument,
    options,
  );
}
export type GetActividadesQueryHookResult = ReturnType<typeof useGetActividadesQuery>;
export type GetActividadesLazyQueryHookResult = ReturnType<typeof useGetActividadesLazyQuery>;
export type GetActividadesSuspenseQueryHookResult = ReturnType<
  typeof useGetActividadesSuspenseQuery
>;
export type GetActividadesQueryResult = Apollo.QueryResult<
  Types.GetActividadesQuery,
  Types.GetActividadesQueryVariables
>;
export const GetSiifActividadesDocument = gql`
  query GetSiifActividades($proyecto: String!) {
    getSiifActividades(proyecto: $proyecto) {
      ...SiifActividad
      siifActividadMetas {
        ...SiifActividadMeta
        acciones {
          ...SiifActividadMetaAccion
        }
      }
    }
  }
  ${SiifActividadFragmentDoc}
  ${SiifActividadMetaFragmentDoc}
  ${SiifActividadMetaAccionFragmentDoc}
`;

/**
 * __useGetSiifActividadesQuery__
 *
 * To run a query within a React component, call `useGetSiifActividadesQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetSiifActividadesQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetSiifActividadesQuery({
 *   variables: {
 *      proyecto: // value for 'proyecto'
 *   },
 * });
 */
export function useGetSiifActividadesQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetSiifActividadesQuery,
    Types.GetSiifActividadesQueryVariables
  > &
    ({ variables: Types.GetSiifActividadesQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetSiifActividadesQuery, Types.GetSiifActividadesQueryVariables>(
    GetSiifActividadesDocument,
    options,
  );
}
export function useGetSiifActividadesLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetSiifActividadesQuery,
    Types.GetSiifActividadesQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetSiifActividadesQuery, Types.GetSiifActividadesQueryVariables>(
    GetSiifActividadesDocument,
    options,
  );
}
export function useGetSiifActividadesSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetSiifActividadesQuery,
        Types.GetSiifActividadesQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetSiifActividadesQuery,
    Types.GetSiifActividadesQueryVariables
  >(GetSiifActividadesDocument, options);
}
export type GetSiifActividadesQueryHookResult = ReturnType<typeof useGetSiifActividadesQuery>;
export type GetSiifActividadesLazyQueryHookResult = ReturnType<
  typeof useGetSiifActividadesLazyQuery
>;
export type GetSiifActividadesSuspenseQueryHookResult = ReturnType<
  typeof useGetSiifActividadesSuspenseQuery
>;
export type GetSiifActividadesQueryResult = Apollo.QueryResult<
  Types.GetSiifActividadesQuery,
  Types.GetSiifActividadesQueryVariables
>;
export const GetSiifActividadMetasDocument = gql`
  query GetSiifActividadMetas($codigoAct: Int!, $proyecto: String!) {
    getSiifActividadMetas(codigoAct: $codigoAct, proyecto: $proyecto) {
      ...SiifActividadMeta
      acciones {
        ...SiifActividadMetaAccion
      }
    }
  }
  ${SiifActividadMetaFragmentDoc}
  ${SiifActividadMetaAccionFragmentDoc}
`;

/**
 * __useGetSiifActividadMetasQuery__
 *
 * To run a query within a React component, call `useGetSiifActividadMetasQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetSiifActividadMetasQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetSiifActividadMetasQuery({
 *   variables: {
 *      codigoAct: // value for 'codigoAct'
 *      proyecto: // value for 'proyecto'
 *   },
 * });
 */
export function useGetSiifActividadMetasQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetSiifActividadMetasQuery,
    Types.GetSiifActividadMetasQueryVariables
  > &
    ({ variables: Types.GetSiifActividadMetasQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetSiifActividadMetasQuery,
    Types.GetSiifActividadMetasQueryVariables
  >(GetSiifActividadMetasDocument, options);
}
export function useGetSiifActividadMetasLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetSiifActividadMetasQuery,
    Types.GetSiifActividadMetasQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetSiifActividadMetasQuery,
    Types.GetSiifActividadMetasQueryVariables
  >(GetSiifActividadMetasDocument, options);
}
export function useGetSiifActividadMetasSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetSiifActividadMetasQuery,
        Types.GetSiifActividadMetasQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetSiifActividadMetasQuery,
    Types.GetSiifActividadMetasQueryVariables
  >(GetSiifActividadMetasDocument, options);
}
export type GetSiifActividadMetasQueryHookResult = ReturnType<typeof useGetSiifActividadMetasQuery>;
export type GetSiifActividadMetasLazyQueryHookResult = ReturnType<
  typeof useGetSiifActividadMetasLazyQuery
>;
export type GetSiifActividadMetasSuspenseQueryHookResult = ReturnType<
  typeof useGetSiifActividadMetasSuspenseQuery
>;
export type GetSiifActividadMetasQueryResult = Apollo.QueryResult<
  Types.GetSiifActividadMetasQuery,
  Types.GetSiifActividadMetasQueryVariables
>;
export const SaveSiifActividadMetaDocument = gql`
  mutation SaveSiifActividadMeta($data: [CreateSiifActividadMeta!]!) {
    saveSiifActividadMeta(data: $data) {
      ...SiifActividadMeta
    }
  }
  ${SiifActividadMetaFragmentDoc}
`;
export type SaveSiifActividadMetaMutationFn = Apollo.MutationFunction<
  Types.SaveSiifActividadMetaMutation,
  Types.SaveSiifActividadMetaMutationVariables
>;

/**
 * __useSaveSiifActividadMetaMutation__
 *
 * To run a mutation, you first call `useSaveSiifActividadMetaMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useSaveSiifActividadMetaMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [saveSiifActividadMetaMutation, { data, loading, error }] = useSaveSiifActividadMetaMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSaveSiifActividadMetaMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.SaveSiifActividadMetaMutation,
    Types.SaveSiifActividadMetaMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.SaveSiifActividadMetaMutation,
    Types.SaveSiifActividadMetaMutationVariables
  >(SaveSiifActividadMetaDocument, options);
}
export type SaveSiifActividadMetaMutationHookResult = ReturnType<
  typeof useSaveSiifActividadMetaMutation
>;
export type SaveSiifActividadMetaMutationResult =
  Apollo.MutationResult<Types.SaveSiifActividadMetaMutation>;
export type SaveSiifActividadMetaMutationOptions = Apollo.BaseMutationOptions<
  Types.SaveSiifActividadMetaMutation,
  Types.SaveSiifActividadMetaMutationVariables
>;
export const DeleteSiifActividadMetasDocument = gql`
  mutation DeleteSiifActividadMetas($data: DeleteSiifActividadMetas!) {
    deleteSiifActividadMetas(data: $data) {
      ...SiifActividadMeta
    }
  }
  ${SiifActividadMetaFragmentDoc}
`;
export type DeleteSiifActividadMetasMutationFn = Apollo.MutationFunction<
  Types.DeleteSiifActividadMetasMutation,
  Types.DeleteSiifActividadMetasMutationVariables
>;

/**
 * __useDeleteSiifActividadMetasMutation__
 *
 * To run a mutation, you first call `useDeleteSiifActividadMetasMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteSiifActividadMetasMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteSiifActividadMetasMutation, { data, loading, error }] = useDeleteSiifActividadMetasMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useDeleteSiifActividadMetasMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteSiifActividadMetasMutation,
    Types.DeleteSiifActividadMetasMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteSiifActividadMetasMutation,
    Types.DeleteSiifActividadMetasMutationVariables
  >(DeleteSiifActividadMetasDocument, options);
}
export type DeleteSiifActividadMetasMutationHookResult = ReturnType<
  typeof useDeleteSiifActividadMetasMutation
>;
export type DeleteSiifActividadMetasMutationResult =
  Apollo.MutationResult<Types.DeleteSiifActividadMetasMutation>;
export type DeleteSiifActividadMetasMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteSiifActividadMetasMutation,
  Types.DeleteSiifActividadMetasMutationVariables
>;
export const GetGoalResourcesDocument = gql`
  query GetGoalResources($data: GetGoalResources!) {
    GetGoalResources(data: $data) {
      ...GetGoalResourcesResponse
    }
  }
  ${GetGoalResourcesResponseFragmentDoc}
`;

/**
 * __useGetGoalResourcesQuery__
 *
 * To run a query within a React component, call `useGetGoalResourcesQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGoalResourcesQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGoalResourcesQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetGoalResourcesQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetGoalResourcesQuery,
    Types.GetGoalResourcesQueryVariables
  > &
    ({ variables: Types.GetGoalResourcesQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetGoalResourcesQuery, Types.GetGoalResourcesQueryVariables>(
    GetGoalResourcesDocument,
    options,
  );
}
export function useGetGoalResourcesLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetGoalResourcesQuery,
    Types.GetGoalResourcesQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetGoalResourcesQuery, Types.GetGoalResourcesQueryVariables>(
    GetGoalResourcesDocument,
    options,
  );
}
export function useGetGoalResourcesSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetGoalResourcesQuery,
        Types.GetGoalResourcesQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetGoalResourcesQuery, Types.GetGoalResourcesQueryVariables>(
    GetGoalResourcesDocument,
    options,
  );
}
export type GetGoalResourcesQueryHookResult = ReturnType<typeof useGetGoalResourcesQuery>;
export type GetGoalResourcesLazyQueryHookResult = ReturnType<typeof useGetGoalResourcesLazyQuery>;
export type GetGoalResourcesSuspenseQueryHookResult = ReturnType<
  typeof useGetGoalResourcesSuspenseQuery
>;
export type GetGoalResourcesQueryResult = Apollo.QueryResult<
  Types.GetGoalResourcesQuery,
  Types.GetGoalResourcesQueryVariables
>;
export const SaveSiifActividadMetaAccionDocument = gql`
  mutation SaveSiifActividadMetaAccion($data: [CreateSiifActividadMetaAccion!]!) {
    saveSiifActividadMetaAccion(data: $data) {
      ...SiifActividadMetaAccion
    }
  }
  ${SiifActividadMetaAccionFragmentDoc}
`;
export type SaveSiifActividadMetaAccionMutationFn = Apollo.MutationFunction<
  Types.SaveSiifActividadMetaAccionMutation,
  Types.SaveSiifActividadMetaAccionMutationVariables
>;

/**
 * __useSaveSiifActividadMetaAccionMutation__
 *
 * To run a mutation, you first call `useSaveSiifActividadMetaAccionMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useSaveSiifActividadMetaAccionMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [saveSiifActividadMetaAccionMutation, { data, loading, error }] = useSaveSiifActividadMetaAccionMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useSaveSiifActividadMetaAccionMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.SaveSiifActividadMetaAccionMutation,
    Types.SaveSiifActividadMetaAccionMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.SaveSiifActividadMetaAccionMutation,
    Types.SaveSiifActividadMetaAccionMutationVariables
  >(SaveSiifActividadMetaAccionDocument, options);
}
export type SaveSiifActividadMetaAccionMutationHookResult = ReturnType<
  typeof useSaveSiifActividadMetaAccionMutation
>;
export type SaveSiifActividadMetaAccionMutationResult =
  Apollo.MutationResult<Types.SaveSiifActividadMetaAccionMutation>;
export type SaveSiifActividadMetaAccionMutationOptions = Apollo.BaseMutationOptions<
  Types.SaveSiifActividadMetaAccionMutation,
  Types.SaveSiifActividadMetaAccionMutationVariables
>;
export const DeleteSiifActividadMetaAccionesDocument = gql`
  mutation DeleteSiifActividadMetaAcciones($data: DeleteSiifActividadMetaAcciones!) {
    deleteSiifActividadMetaAcciones(data: $data) {
      ...SiifActividadMetaAccion
    }
  }
  ${SiifActividadMetaAccionFragmentDoc}
`;
export type DeleteSiifActividadMetaAccionesMutationFn = Apollo.MutationFunction<
  Types.DeleteSiifActividadMetaAccionesMutation,
  Types.DeleteSiifActividadMetaAccionesMutationVariables
>;

/**
 * __useDeleteSiifActividadMetaAccionesMutation__
 *
 * To run a mutation, you first call `useDeleteSiifActividadMetaAccionesMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteSiifActividadMetaAccionesMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteSiifActividadMetaAccionesMutation, { data, loading, error }] = useDeleteSiifActividadMetaAccionesMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useDeleteSiifActividadMetaAccionesMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteSiifActividadMetaAccionesMutation,
    Types.DeleteSiifActividadMetaAccionesMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteSiifActividadMetaAccionesMutation,
    Types.DeleteSiifActividadMetaAccionesMutationVariables
  >(DeleteSiifActividadMetaAccionesDocument, options);
}
export type DeleteSiifActividadMetaAccionesMutationHookResult = ReturnType<
  typeof useDeleteSiifActividadMetaAccionesMutation
>;
export type DeleteSiifActividadMetaAccionesMutationResult =
  Apollo.MutationResult<Types.DeleteSiifActividadMetaAccionesMutation>;
export type DeleteSiifActividadMetaAccionesMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteSiifActividadMetaAccionesMutation,
  Types.DeleteSiifActividadMetaAccionesMutationVariables
>;
export const GetGeoLocationsTreeDocument = gql`
  query GetGeoLocationsTree {
    getGeoLocationsTree {
      ...GeoLocation
      children {
        ...GeoLocation
        children {
          ...GeoLocation
        }
      }
    }
  }
  ${GeoLocationFragmentDoc}
`;

/**
 * __useGetGeoLocationsTreeQuery__
 *
 * To run a query within a React component, call `useGetGeoLocationsTreeQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGeoLocationsTreeQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGeoLocationsTreeQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetGeoLocationsTreeQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetGeoLocationsTreeQuery,
    Types.GetGeoLocationsTreeQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetGeoLocationsTreeQuery, Types.GetGeoLocationsTreeQueryVariables>(
    GetGeoLocationsTreeDocument,
    options,
  );
}
export function useGetGeoLocationsTreeLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetGeoLocationsTreeQuery,
    Types.GetGeoLocationsTreeQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetGeoLocationsTreeQuery,
    Types.GetGeoLocationsTreeQueryVariables
  >(GetGeoLocationsTreeDocument, options);
}
export function useGetGeoLocationsTreeSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetGeoLocationsTreeQuery,
        Types.GetGeoLocationsTreeQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetGeoLocationsTreeQuery,
    Types.GetGeoLocationsTreeQueryVariables
  >(GetGeoLocationsTreeDocument, options);
}
export type GetGeoLocationsTreeQueryHookResult = ReturnType<typeof useGetGeoLocationsTreeQuery>;
export type GetGeoLocationsTreeLazyQueryHookResult = ReturnType<
  typeof useGetGeoLocationsTreeLazyQuery
>;
export type GetGeoLocationsTreeSuspenseQueryHookResult = ReturnType<
  typeof useGetGeoLocationsTreeSuspenseQuery
>;
export type GetGeoLocationsTreeQueryResult = Apollo.QueryResult<
  Types.GetGeoLocationsTreeQuery,
  Types.GetGeoLocationsTreeQueryVariables
>;
export const CreateMonitoringRecordAttachmentLinkDocument = gql`
  mutation CreateMonitoringRecordAttachmentLink($data: CreateMonitoringRecordAttachmentLink!) {
    createMonitoringRecordAttachmentLink(data: $data) {
      ...CreateMonitoringRecordAttachmentLinkResponse
      downloadLink
    }
  }
  ${CreateMonitoringRecordAttachmentLinkResponseFragmentDoc}
`;
export type CreateMonitoringRecordAttachmentLinkMutationFn = Apollo.MutationFunction<
  Types.CreateMonitoringRecordAttachmentLinkMutation,
  Types.CreateMonitoringRecordAttachmentLinkMutationVariables
>;

/**
 * __useCreateMonitoringRecordAttachmentLinkMutation__
 *
 * To run a mutation, you first call `useCreateMonitoringRecordAttachmentLinkMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreateMonitoringRecordAttachmentLinkMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createMonitoringRecordAttachmentLinkMutation, { data, loading, error }] = useCreateMonitoringRecordAttachmentLinkMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useCreateMonitoringRecordAttachmentLinkMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CreateMonitoringRecordAttachmentLinkMutation,
    Types.CreateMonitoringRecordAttachmentLinkMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CreateMonitoringRecordAttachmentLinkMutation,
    Types.CreateMonitoringRecordAttachmentLinkMutationVariables
  >(CreateMonitoringRecordAttachmentLinkDocument, options);
}
export type CreateMonitoringRecordAttachmentLinkMutationHookResult = ReturnType<
  typeof useCreateMonitoringRecordAttachmentLinkMutation
>;
export type CreateMonitoringRecordAttachmentLinkMutationResult =
  Apollo.MutationResult<Types.CreateMonitoringRecordAttachmentLinkMutation>;
export type CreateMonitoringRecordAttachmentLinkMutationOptions = Apollo.BaseMutationOptions<
  Types.CreateMonitoringRecordAttachmentLinkMutation,
  Types.CreateMonitoringRecordAttachmentLinkMutationVariables
>;
export const GetMonitoringRecordAttachmentsDocument = gql`
  query GetMonitoringRecordAttachments($monitoringRecordId: Int!) {
    getMonitoringRecordAttachments(monitoringRecordId: $monitoringRecordId) {
      ...MonitoringRecordAttachment
      downloadLink
    }
  }
  ${MonitoringRecordAttachmentFragmentDoc}
`;

/**
 * __useGetMonitoringRecordAttachmentsQuery__
 *
 * To run a query within a React component, call `useGetMonitoringRecordAttachmentsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMonitoringRecordAttachmentsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMonitoringRecordAttachmentsQuery({
 *   variables: {
 *      monitoringRecordId: // value for 'monitoringRecordId'
 *   },
 * });
 */
export function useGetMonitoringRecordAttachmentsQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetMonitoringRecordAttachmentsQuery,
    Types.GetMonitoringRecordAttachmentsQueryVariables
  > &
    (
      | { variables: Types.GetMonitoringRecordAttachmentsQueryVariables; skip?: boolean }
      | { skip: boolean }
    ),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetMonitoringRecordAttachmentsQuery,
    Types.GetMonitoringRecordAttachmentsQueryVariables
  >(GetMonitoringRecordAttachmentsDocument, options);
}
export function useGetMonitoringRecordAttachmentsLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMonitoringRecordAttachmentsQuery,
    Types.GetMonitoringRecordAttachmentsQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetMonitoringRecordAttachmentsQuery,
    Types.GetMonitoringRecordAttachmentsQueryVariables
  >(GetMonitoringRecordAttachmentsDocument, options);
}
export function useGetMonitoringRecordAttachmentsSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMonitoringRecordAttachmentsQuery,
        Types.GetMonitoringRecordAttachmentsQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetMonitoringRecordAttachmentsQuery,
    Types.GetMonitoringRecordAttachmentsQueryVariables
  >(GetMonitoringRecordAttachmentsDocument, options);
}
export type GetMonitoringRecordAttachmentsQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordAttachmentsQuery
>;
export type GetMonitoringRecordAttachmentsLazyQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordAttachmentsLazyQuery
>;
export type GetMonitoringRecordAttachmentsSuspenseQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordAttachmentsSuspenseQuery
>;
export type GetMonitoringRecordAttachmentsQueryResult = Apollo.QueryResult<
  Types.GetMonitoringRecordAttachmentsQuery,
  Types.GetMonitoringRecordAttachmentsQueryVariables
>;
export const GetMonitoringRecordAttachmentDocument = gql`
  query GetMonitoringRecordAttachment($id: Int!) {
    getMonitoringRecordAttachment(id: $id) {
      ...MonitoringRecordAttachment
      downloadLink
    }
  }
  ${MonitoringRecordAttachmentFragmentDoc}
`;

/**
 * __useGetMonitoringRecordAttachmentQuery__
 *
 * To run a query within a React component, call `useGetMonitoringRecordAttachmentQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMonitoringRecordAttachmentQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMonitoringRecordAttachmentQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetMonitoringRecordAttachmentQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetMonitoringRecordAttachmentQuery,
    Types.GetMonitoringRecordAttachmentQueryVariables
  > &
    (
      | { variables: Types.GetMonitoringRecordAttachmentQueryVariables; skip?: boolean }
      | { skip: boolean }
    ),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetMonitoringRecordAttachmentQuery,
    Types.GetMonitoringRecordAttachmentQueryVariables
  >(GetMonitoringRecordAttachmentDocument, options);
}
export function useGetMonitoringRecordAttachmentLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetMonitoringRecordAttachmentQuery,
    Types.GetMonitoringRecordAttachmentQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetMonitoringRecordAttachmentQuery,
    Types.GetMonitoringRecordAttachmentQueryVariables
  >(GetMonitoringRecordAttachmentDocument, options);
}
export function useGetMonitoringRecordAttachmentSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetMonitoringRecordAttachmentQuery,
        Types.GetMonitoringRecordAttachmentQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetMonitoringRecordAttachmentQuery,
    Types.GetMonitoringRecordAttachmentQueryVariables
  >(GetMonitoringRecordAttachmentDocument, options);
}
export type GetMonitoringRecordAttachmentQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordAttachmentQuery
>;
export type GetMonitoringRecordAttachmentLazyQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordAttachmentLazyQuery
>;
export type GetMonitoringRecordAttachmentSuspenseQueryHookResult = ReturnType<
  typeof useGetMonitoringRecordAttachmentSuspenseQuery
>;
export type GetMonitoringRecordAttachmentQueryResult = Apollo.QueryResult<
  Types.GetMonitoringRecordAttachmentQuery,
  Types.GetMonitoringRecordAttachmentQueryVariables
>;
export const DeleteMonitoringRecordAttachmentDocument = gql`
  mutation DeleteMonitoringRecordAttachment($id: Int!) {
    deleteMonitoringRecordAttachment(id: $id) {
      ...MonitoringRecordAttachment
      downloadLink
    }
  }
  ${MonitoringRecordAttachmentFragmentDoc}
`;
export type DeleteMonitoringRecordAttachmentMutationFn = Apollo.MutationFunction<
  Types.DeleteMonitoringRecordAttachmentMutation,
  Types.DeleteMonitoringRecordAttachmentMutationVariables
>;

/**
 * __useDeleteMonitoringRecordAttachmentMutation__
 *
 * To run a mutation, you first call `useDeleteMonitoringRecordAttachmentMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteMonitoringRecordAttachmentMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteMonitoringRecordAttachmentMutation, { data, loading, error }] = useDeleteMonitoringRecordAttachmentMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteMonitoringRecordAttachmentMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.DeleteMonitoringRecordAttachmentMutation,
    Types.DeleteMonitoringRecordAttachmentMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.DeleteMonitoringRecordAttachmentMutation,
    Types.DeleteMonitoringRecordAttachmentMutationVariables
  >(DeleteMonitoringRecordAttachmentDocument, options);
}
export type DeleteMonitoringRecordAttachmentMutationHookResult = ReturnType<
  typeof useDeleteMonitoringRecordAttachmentMutation
>;
export type DeleteMonitoringRecordAttachmentMutationResult =
  Apollo.MutationResult<Types.DeleteMonitoringRecordAttachmentMutation>;
export type DeleteMonitoringRecordAttachmentMutationOptions = Apollo.BaseMutationOptions<
  Types.DeleteMonitoringRecordAttachmentMutation,
  Types.DeleteMonitoringRecordAttachmentMutationVariables
>;
export const GetSupersetGuestTokenDocument = gql`
  mutation GetSupersetGuestToken($data: GetSupersetGuestTokenParams!) {
    getSupersetGuestToken(data: $data)
  }
`;
export type GetSupersetGuestTokenMutationFn = Apollo.MutationFunction<
  Types.GetSupersetGuestTokenMutation,
  Types.GetSupersetGuestTokenMutationVariables
>;

/**
 * __useGetSupersetGuestTokenMutation__
 *
 * To run a mutation, you first call `useGetSupersetGuestTokenMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useGetSupersetGuestTokenMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [getSupersetGuestTokenMutation, { data, loading, error }] = useGetSupersetGuestTokenMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetSupersetGuestTokenMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.GetSupersetGuestTokenMutation,
    Types.GetSupersetGuestTokenMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.GetSupersetGuestTokenMutation,
    Types.GetSupersetGuestTokenMutationVariables
  >(GetSupersetGuestTokenDocument, options);
}
export type GetSupersetGuestTokenMutationHookResult = ReturnType<
  typeof useGetSupersetGuestTokenMutation
>;
export type GetSupersetGuestTokenMutationResult =
  Apollo.MutationResult<Types.GetSupersetGuestTokenMutation>;
export type GetSupersetGuestTokenMutationOptions = Apollo.BaseMutationOptions<
  Types.GetSupersetGuestTokenMutation,
  Types.GetSupersetGuestTokenMutationVariables
>;
export const GetPlanesDesarrolloDocument = gql`
  query GetPlanesDesarrollo {
    getPlanesDesarrollo {
      ...PlanDesarrollo
      ejes {
        ...EjeEstructurante
      }
    }
  }
  ${PlanDesarrolloFragmentDoc}
  ${EjeEstructuranteFragmentDoc}
`;

/**
 * __useGetPlanesDesarrolloQuery__
 *
 * To run a query within a React component, call `useGetPlanesDesarrolloQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPlanesDesarrolloQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPlanesDesarrolloQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetPlanesDesarrolloQuery(
  baseOptions?: Apollo.QueryHookOptions<
    Types.GetPlanesDesarrolloQuery,
    Types.GetPlanesDesarrolloQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetPlanesDesarrolloQuery, Types.GetPlanesDesarrolloQueryVariables>(
    GetPlanesDesarrolloDocument,
    options,
  );
}
export function useGetPlanesDesarrolloLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPlanesDesarrolloQuery,
    Types.GetPlanesDesarrolloQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetPlanesDesarrolloQuery,
    Types.GetPlanesDesarrolloQueryVariables
  >(GetPlanesDesarrolloDocument, options);
}
export function useGetPlanesDesarrolloSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPlanesDesarrolloQuery,
        Types.GetPlanesDesarrolloQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetPlanesDesarrolloQuery,
    Types.GetPlanesDesarrolloQueryVariables
  >(GetPlanesDesarrolloDocument, options);
}
export type GetPlanesDesarrolloQueryHookResult = ReturnType<typeof useGetPlanesDesarrolloQuery>;
export type GetPlanesDesarrolloLazyQueryHookResult = ReturnType<
  typeof useGetPlanesDesarrolloLazyQuery
>;
export type GetPlanesDesarrolloSuspenseQueryHookResult = ReturnType<
  typeof useGetPlanesDesarrolloSuspenseQuery
>;
export type GetPlanesDesarrolloQueryResult = Apollo.QueryResult<
  Types.GetPlanesDesarrolloQuery,
  Types.GetPlanesDesarrolloQueryVariables
>;
export const GetPlanDesarrolloByCodeDocument = gql`
  query GetPlanDesarrolloByCode($code: String!) {
    getPlanDesarrolloByCode(code: $code) {
      ...PlanDesarrollo
      ejes {
        ...EjeEstructurante
        sectores {
          ...Sector
          programas {
            ...ProgramaPry
            subprogramas {
              ...SubprogramaPry
            }
          }
        }
      }
    }
  }
  ${PlanDesarrolloFragmentDoc}
  ${EjeEstructuranteFragmentDoc}
  ${SectorFragmentDoc}
  ${ProgramaPryFragmentDoc}
  ${SubprogramaPryFragmentDoc}
`;

/**
 * __useGetPlanDesarrolloByCodeQuery__
 *
 * To run a query within a React component, call `useGetPlanDesarrolloByCodeQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetPlanDesarrolloByCodeQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetPlanDesarrolloByCodeQuery({
 *   variables: {
 *      code: // value for 'code'
 *   },
 * });
 */
export function useGetPlanDesarrolloByCodeQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetPlanDesarrolloByCodeQuery,
    Types.GetPlanDesarrolloByCodeQueryVariables
  > &
    (
      | { variables: Types.GetPlanDesarrolloByCodeQueryVariables; skip?: boolean }
      | { skip: boolean }
    ),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetPlanDesarrolloByCodeQuery,
    Types.GetPlanDesarrolloByCodeQueryVariables
  >(GetPlanDesarrolloByCodeDocument, options);
}
export function useGetPlanDesarrolloByCodeLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetPlanDesarrolloByCodeQuery,
    Types.GetPlanDesarrolloByCodeQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetPlanDesarrolloByCodeQuery,
    Types.GetPlanDesarrolloByCodeQueryVariables
  >(GetPlanDesarrolloByCodeDocument, options);
}
export function useGetPlanDesarrolloByCodeSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetPlanDesarrolloByCodeQuery,
        Types.GetPlanDesarrolloByCodeQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetPlanDesarrolloByCodeQuery,
    Types.GetPlanDesarrolloByCodeQueryVariables
  >(GetPlanDesarrolloByCodeDocument, options);
}
export type GetPlanDesarrolloByCodeQueryHookResult = ReturnType<
  typeof useGetPlanDesarrolloByCodeQuery
>;
export type GetPlanDesarrolloByCodeLazyQueryHookResult = ReturnType<
  typeof useGetPlanDesarrolloByCodeLazyQuery
>;
export type GetPlanDesarrolloByCodeSuspenseQueryHookResult = ReturnType<
  typeof useGetPlanDesarrolloByCodeSuspenseQuery
>;
export type GetPlanDesarrolloByCodeQueryResult = Apollo.QueryResult<
  Types.GetPlanDesarrolloByCodeQuery,
  Types.GetPlanDesarrolloByCodeQueryVariables
>;
export const GetGoalsToCopyFromSiifDocument = gql`
  query GetGoalsToCopyFromSIIF($devPlanId: Float!) {
    getGoalsToCopyFromSIIF(devPlanId: $devPlanId) {
      countGoalsSIIF
      countGoalsSPD
      goalstoCopyFromSIIF {
        ...VSpdMeta
      }
    }
  }
  ${VSpdMetaFragmentDoc}
`;

/**
 * __useGetGoalsToCopyFromSiifQuery__
 *
 * To run a query within a React component, call `useGetGoalsToCopyFromSiifQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetGoalsToCopyFromSiifQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetGoalsToCopyFromSiifQuery({
 *   variables: {
 *      devPlanId: // value for 'devPlanId'
 *   },
 * });
 */
export function useGetGoalsToCopyFromSiifQuery(
  baseOptions: Apollo.QueryHookOptions<
    Types.GetGoalsToCopyFromSiifQuery,
    Types.GetGoalsToCopyFromSiifQueryVariables
  > &
    ({ variables: Types.GetGoalsToCopyFromSiifQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<
    Types.GetGoalsToCopyFromSiifQuery,
    Types.GetGoalsToCopyFromSiifQueryVariables
  >(GetGoalsToCopyFromSiifDocument, options);
}
export function useGetGoalsToCopyFromSiifLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<
    Types.GetGoalsToCopyFromSiifQuery,
    Types.GetGoalsToCopyFromSiifQueryVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<
    Types.GetGoalsToCopyFromSiifQuery,
    Types.GetGoalsToCopyFromSiifQueryVariables
  >(GetGoalsToCopyFromSiifDocument, options);
}
export function useGetGoalsToCopyFromSiifSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<
        Types.GetGoalsToCopyFromSiifQuery,
        Types.GetGoalsToCopyFromSiifQueryVariables
      >,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<
    Types.GetGoalsToCopyFromSiifQuery,
    Types.GetGoalsToCopyFromSiifQueryVariables
  >(GetGoalsToCopyFromSiifDocument, options);
}
export type GetGoalsToCopyFromSiifQueryHookResult = ReturnType<
  typeof useGetGoalsToCopyFromSiifQuery
>;
export type GetGoalsToCopyFromSiifLazyQueryHookResult = ReturnType<
  typeof useGetGoalsToCopyFromSiifLazyQuery
>;
export type GetGoalsToCopyFromSiifSuspenseQueryHookResult = ReturnType<
  typeof useGetGoalsToCopyFromSiifSuspenseQuery
>;
export type GetGoalsToCopyFromSiifQueryResult = Apollo.QueryResult<
  Types.GetGoalsToCopyFromSiifQuery,
  Types.GetGoalsToCopyFromSiifQueryVariables
>;
export const GetMetasDocument = gql`
  query GetMetas($data: SearchSpdMeta!) {
    getMetas(data: $data) {
      ...VSpdMeta
    }
  }
  ${VSpdMetaFragmentDoc}
`;

/**
 * __useGetMetasQuery__
 *
 * To run a query within a React component, call `useGetMetasQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetMetasQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetMetasQuery({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useGetMetasQuery(
  baseOptions: Apollo.QueryHookOptions<Types.GetMetasQuery, Types.GetMetasQueryVariables> &
    ({ variables: Types.GetMetasQueryVariables; skip?: boolean } | { skip: boolean }),
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useQuery<Types.GetMetasQuery, Types.GetMetasQueryVariables>(
    GetMetasDocument,
    options,
  );
}
export function useGetMetasLazyQuery(
  baseOptions?: Apollo.LazyQueryHookOptions<Types.GetMetasQuery, Types.GetMetasQueryVariables>,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useLazyQuery<Types.GetMetasQuery, Types.GetMetasQueryVariables>(
    GetMetasDocument,
    options,
  );
}
export function useGetMetasSuspenseQuery(
  baseOptions?:
    | Apollo.SkipToken
    | Apollo.SuspenseQueryHookOptions<Types.GetMetasQuery, Types.GetMetasQueryVariables>,
) {
  const options =
    baseOptions === Apollo.skipToken ? baseOptions : { ...defaultOptions, ...baseOptions };
  return Apollo.useSuspenseQuery<Types.GetMetasQuery, Types.GetMetasQueryVariables>(
    GetMetasDocument,
    options,
  );
}
export type GetMetasQueryHookResult = ReturnType<typeof useGetMetasQuery>;
export type GetMetasLazyQueryHookResult = ReturnType<typeof useGetMetasLazyQuery>;
export type GetMetasSuspenseQueryHookResult = ReturnType<typeof useGetMetasSuspenseQuery>;
export type GetMetasQueryResult = Apollo.QueryResult<
  Types.GetMetasQuery,
  Types.GetMetasQueryVariables
>;
export const CopyGoalsFromSiifDocument = gql`
  mutation CopyGoalsFromSIIF($devPlanId: Float!) {
    copyGoalsFromSIIF(devPlanId: $devPlanId) {
      ...Goal
      children {
        ...Goal
      }
      entity {
        ...Entity
      }
      devPlanLevel {
        ...DevPlanLevel
        devPlan {
          ...DevPlan
        }
      }
    }
  }
  ${GoalFragmentDoc}
  ${EntityFragmentDoc}
  ${DevPlanLevelFragmentDoc}
  ${DevPlanFragmentDoc}
`;
export type CopyGoalsFromSiifMutationFn = Apollo.MutationFunction<
  Types.CopyGoalsFromSiifMutation,
  Types.CopyGoalsFromSiifMutationVariables
>;

/**
 * __useCopyGoalsFromSiifMutation__
 *
 * To run a mutation, you first call `useCopyGoalsFromSiifMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCopyGoalsFromSiifMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [copyGoalsFromSiifMutation, { data, loading, error }] = useCopyGoalsFromSiifMutation({
 *   variables: {
 *      devPlanId: // value for 'devPlanId'
 *   },
 * });
 */
export function useCopyGoalsFromSiifMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.CopyGoalsFromSiifMutation,
    Types.CopyGoalsFromSiifMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.CopyGoalsFromSiifMutation,
    Types.CopyGoalsFromSiifMutationVariables
  >(CopyGoalsFromSiifDocument, options);
}
export type CopyGoalsFromSiifMutationHookResult = ReturnType<typeof useCopyGoalsFromSiifMutation>;
export type CopyGoalsFromSiifMutationResult =
  Apollo.MutationResult<Types.CopyGoalsFromSiifMutation>;
export type CopyGoalsFromSiifMutationOptions = Apollo.BaseMutationOptions<
  Types.CopyGoalsFromSiifMutation,
  Types.CopyGoalsFromSiifMutationVariables
>;
export const LinkGoalToActivityDocument = gql`
  mutation LinkGoalToActivity($data: LinkGoalToActivity!) {
    linkGoalToActivity(data: $data) {
      ...GoalToActivity
      goal {
        ...Goal
      }
    }
  }
  ${GoalToActivityFragmentDoc}
  ${GoalFragmentDoc}
`;
export type LinkGoalToActivityMutationFn = Apollo.MutationFunction<
  Types.LinkGoalToActivityMutation,
  Types.LinkGoalToActivityMutationVariables
>;

/**
 * __useLinkGoalToActivityMutation__
 *
 * To run a mutation, you first call `useLinkGoalToActivityMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useLinkGoalToActivityMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [linkGoalToActivityMutation, { data, loading, error }] = useLinkGoalToActivityMutation({
 *   variables: {
 *      data: // value for 'data'
 *   },
 * });
 */
export function useLinkGoalToActivityMutation(
  baseOptions?: Apollo.MutationHookOptions<
    Types.LinkGoalToActivityMutation,
    Types.LinkGoalToActivityMutationVariables
  >,
) {
  const options = { ...defaultOptions, ...baseOptions };
  return Apollo.useMutation<
    Types.LinkGoalToActivityMutation,
    Types.LinkGoalToActivityMutationVariables
  >(LinkGoalToActivityDocument, options);
}
export type LinkGoalToActivityMutationHookResult = ReturnType<typeof useLinkGoalToActivityMutation>;
export type LinkGoalToActivityMutationResult =
  Apollo.MutationResult<Types.LinkGoalToActivityMutation>;
export type LinkGoalToActivityMutationOptions = Apollo.BaseMutationOptions<
  Types.LinkGoalToActivityMutation,
  Types.LinkGoalToActivityMutationVariables
>;
