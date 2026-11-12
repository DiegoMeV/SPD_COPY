import {
  SearchEntitiesDocument,
  useDeleteEntityMutation,
  useGetEntitiesLazyQuery,
  useSearchEntitiesQuery,
} from "../../../graphql/gen/hooks";
import { SearchEntitiesQuery } from "../../../graphql/gen/ops";
import { DEFAULT_PAGE_SIZE } from "../../const";
import { useTable } from "../../hooks/useTable";
import { useStoreActions, useStoreState } from "../../store";
import { useEffect } from "react";

const useEntities = () => {
  const setEntities = useStoreActions((actions) => actions.entity.setData);
  const entities = useStoreState((state) => state.entity.data);
  const [fetchEntities, { loading, data, error }] = useGetEntitiesLazyQuery({
    fetchPolicy: "cache-first",
  });

  useEffect(() => {
    if (!entities?.length) fetchEntities();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [entities]);

  useEffect(() => {
    if (data) {
      setEntities(data?.getEntities);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  return { loading, data: entities, error };
};

const useSearchEntities = () => {
  const setSearchEntityVariables = useStoreActions(
    (actions) => actions.entity.setSearchEntityVariables,
  );
  const searchEntityVariables = useStoreState((actions) => actions.entity.searchEntityVariables);

  const {
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setTotal,
    handleTableChange,
    setSearch,
    getColumnRender,
    setPagination,
  } = useTable({
    pagination: { pageSize: 10 },
    sorter: { field: "name", order: "asc" },
    filters: {
      isActive: [true],
    },
    search: {
      searchedColumn: "text",
      searchText: searchEntityVariables.text ?? "",
    },
  });

  const getQueryVariables = () => {
    return {
      ...(search?.searchedColumn ? { [search.searchedColumn]: search.searchText } : {}),
      limit: pagination?.pageSize,
      offset: ((pagination?.current ?? 1) - 1) * (pagination?.pageSize ?? DEFAULT_PAGE_SIZE),
      ...(filters?.isActive ? { active: filters.isActive } : {}),
      sort: sorter,
    };
  };

  useEffect(() => {
    setPagination({ ...pagination, current: 1 });
    setSearchEntityVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search]);

  useEffect(() => {
    setSearchEntityVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const { loading, data, error } = useSearchEntitiesQuery({
    variables: { data: getQueryVariables() },
    fetchPolicy: "cache-and-network",
  });

  useEffect(() => {
    setTotal(data?.searchEntities?.count ?? 0);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.searchEntities?.count]);

  return {
    loading,
    error,
    data: data?.searchEntities?.items ?? [],
    count: data?.searchEntities?.count ?? 0,
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setTotal,
    handleTableChange,
    setSearch,
    getColumnRender,
  };
};

const useDeleteEntity = () => {
  const searchEntityVariables = useStoreState((actions) => actions.entity.searchEntityVariables);

  // implement optimistic response
  const [deleteEntityMutation, { loading, data, error }] = useDeleteEntityMutation({
    refetchQueries: [{ query: SearchEntitiesDocument, variables: { data: searchEntityVariables } }],
  });
  const deleteEntity = async (id: number) => {
    await deleteEntityMutation({
      variables: {
        id,
      },
      optimisticResponse: {
        __typename: "Mutation",
        deleteEntity: id,
      },
      update: (cache, { data }) => {
        const entities = cache.readQuery<SearchEntitiesQuery>({
          query: SearchEntitiesDocument,
          variables: { data: searchEntityVariables },
        });

        if (entities?.searchEntities) {
          const newItems = entities.searchEntities.items.filter(
            (item) => item.id !== data?.deleteEntity,
          );
          cache.writeQuery<SearchEntitiesQuery>({
            query: SearchEntitiesDocument,
            variables: { data: searchEntityVariables },
            data: {
              searchEntities: {
                ...entities.searchEntities,
                items: newItems,
                count: newItems.length,
              },
            },
          });
        }
      },
    });
  };

  return { deleteEntity, loading, data, error };
};

export { useEntities, useSearchEntities, useDeleteEntity };
