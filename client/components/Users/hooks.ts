import { useEffect, useState } from "react";
import {
  SearchUserAccountsDocument,
  useAdminChangeUserAccountPasswordMutation,
  useCreateUserAccountMutation,
  useDeleteUserAccountMutation,
  useGetUserAccountQuery,
  useSearchUserAccountsQuery,
  useUpdateUserAccountMutation,
} from "../../../graphql/gen/hooks";
import { useTable } from "../../hooks/useTable";
import { DEFAULT_PAGE_SIZE } from "../../const";
import { useRouter } from "next/router";
import { useStoreActions, useStoreState } from "../../store";
import { SpdRole } from "../../../graphql/gen/schema";
import { SearchUserAccountsQuery, UserAccountFragment } from "../../../graphql/gen/ops";
import { AlertProps, FormInstance } from "antd";
import { SPDRole } from "@prisma/client";

type UseEditUserProps = {
  id: number;
  form?: FormInstance<any>;
};

type UseChangePasswordProps = {
  id: number;
  firstName?: string | null;
  lastName?: string | null;
  onSuccess?: () => void;
};

const useUsers = () => {
  const setSearchUserAccountVariables = useStoreActions(
    (actions) => actions.user.setSearchUserAccountVariables,
  );
  const searchUserAccountVariables = useStoreState(
    (actions) => actions.user.searchUserAccountVariables,
  );

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
    sorter: { field: "lastName", order: "asc" },
    filters: {
      isActive: [true],
    },
    search: {
      searchedColumn: "text",
      searchText: searchUserAccountVariables.text ?? "",
    },
  });

  const getQueryVariables = () => {
    return {
      ...(search?.searchedColumn ? { [search.searchedColumn]: search.searchText } : {}),
      limit: pagination?.pageSize,
      offset: ((pagination?.current ?? 1) - 1) * (pagination?.pageSize ?? DEFAULT_PAGE_SIZE),
      ...(filters?.role ? { roles: filters.role } : {}),
      ...(filters?.isActive ? { active: filters.isActive } : {}),
      ...(filters?.entity ? { entityIds: filters.entity } : {}),
      sort: sorter,
    };
  };

  useEffect(() => {
    setPagination({ ...pagination, current: 1 });
    setSearchUserAccountVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search]);

  useEffect(() => {
    setSearchUserAccountVariables(getQueryVariables());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const { loading, data, error } = useSearchUserAccountsQuery({
    variables: { data: getQueryVariables() },
    fetchPolicy: "cache-and-network",
  });

  useEffect(() => {
    setTotal(data?.searchUserAccounts?.count ?? 0);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data?.searchUserAccounts?.count]);

  return {
    loading,
    error,
    data: data?.searchUserAccounts?.items ?? [],
    count: data?.searchUserAccounts?.count ?? 0,
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

const useDeleteUser = () => {
  const searchUserAccountVariables = useStoreState(
    (state) => state.user.searchUserAccountVariables,
  );
  // implement optimistic response
  const [deleteUserAccount, { loading, data, error }] = useDeleteUserAccountMutation({
    refetchQueries: [
      { query: SearchUserAccountsDocument, variables: { data: searchUserAccountVariables } },
    ],
  });
  const deleteUser = async (id: number) => {
    await deleteUserAccount({
      variables: {
        id,
      },
      optimisticResponse: {
        __typename: "Mutation",
        deleteUserAccount: id,
      },
      update: (cache, { data }) => {
        const userAccounts = cache.readQuery<SearchUserAccountsQuery>({
          query: SearchUserAccountsDocument,
          variables: { data: searchUserAccountVariables },
        });

        if (userAccounts?.searchUserAccounts) {
          const newItems = userAccounts.searchUserAccounts.items.filter(
            (item) => item.id !== data?.deleteUserAccount,
          );
          cache.writeQuery<SearchUserAccountsQuery>({
            query: SearchUserAccountsDocument,
            variables: { data: searchUserAccountVariables },
            data: {
              searchUserAccounts: {
                ...userAccounts.searchUserAccounts,
                items: newItems,
                count: newItems.length,
              },
            },
          });
        }
      },
    });
  };

  return { deleteUser, loading, data, error };
};

const useCreateUser = () => {
  const router = useRouter();
  const tenant = useStoreState((state) => state.tenant.data);
  const searchUserAccountVariables = useStoreState(
    (state) => state.user.searchUserAccountVariables,
  );
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [saveUserAccount, { loading, data, error }] = useCreateUserAccountMutation({
    refetchQueries: [
      {
        query: SearchUserAccountsDocument,
        variables: { data: searchUserAccountVariables },
        fetchPolicy: "network-only",
      },
    ],
  });

  const createUser = async (values: Record<string, string>) => {
    if (tenant?.id) {
      try {
        const variables = {
          data: {
            tenantId: tenant?.id,
            docNumber: values.docNumber,
            email: values.email,
            firstName: values.firstName,
            lastName: values.lastName,
            password: values.password,
            phone: values.phone,
            entityId: parseInt(values.entityId),
            role: values.role as SpdRole,
          },
        };
        const result = await saveUserAccount({ variables });
        if (result?.data?.createUserAccount) {
          sendNotification({
            type: "success",
            message: "Usuario creado",
            description: `Se ha creado correctamente el usuario`,
          });
          router.back();
        }
      } catch (e) {
        //noop
      }
    }
  };

  return { createUser, loading, data, error };
};

const useUserDetail = (id: number) => {
  const { loading, error, data } = useGetUserAccountQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  return {
    loading,
    error,
    data: data?.getUserAccount,
  };
};

const useEditUser = ({ id, form }: UseEditUserProps) => {
  const router = useRouter();
  const [currentUser, setCurrentUser] = useState<UserAccountFragment | undefined | null>();
  const searchUserAccountVariables = useStoreState(
    (state) => state.user.searchUserAccountVariables,
  );
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const { data: detailData, loading: detailLoading, error: detailError } = useUserDetail(id);
  const [updateUserAccount, { loading: updateLoading, error: updateError, data: updateData }] =
    useUpdateUserAccountMutation({
      refetchQueries: [
        {
          query: SearchUserAccountsDocument,
          variables: { data: searchUserAccountVariables },
          fetchPolicy: "network-only",
        },
      ],
    });

  useEffect(() => {
    setCurrentUser(detailData);
  }, [detailData]);

  useEffect(() => {
    if (currentUser && form) {
      form.setFieldsValue(getFormEditValues());
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentUser, form]);

  const getFormEditValues = () => {
    return {
      docNumber: currentUser?.docNumber,
      email: currentUser?.email,
      firstName: currentUser?.firstName,
      lastName: currentUser?.lastName,
      entityId: currentUser?.entityId,
      phone: currentUser?.phone,
      role: currentUser?.role as SpdRole,
      isActive: currentUser?.isActive,
    };
  };

  const updateUser = async (values: Record<string, string>) => {
    try {
      const variables = {
        data: {
          id,
          docNumber: values.docNumber,
          email: values.email,
          firstName: values.firstName,
          lastName: values.lastName,
          password: values.password,
          phone: values.phone,
          entityId: parseInt(values.entityId),
          role: values.role as SpdRole,
          isActive: `${values.isActive}` === "true",
        },
      };
      const result = await updateUserAccount({ variables });
      if (result?.data?.updateUserAccount) {
        sendNotification({
          type: "success",
          message: "Usuario editado",
          description: `Se ha editado correctamente el usuario`,
        });
        router.back();
      }
    } catch (e) {
      // noop
    }
  };

  return {
    updateUser,
    getFormEditValues,
    detailLoading,
    detailError,
    detailData,
    updateLoading,
    updateError,
    updateData: updateData?.updateUserAccount,
  };
};

const useChangePassword = ({ id, firstName, lastName, onSuccess }: UseChangePasswordProps) => {
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [alert, setAlert] = useState<AlertProps>();
  const [changePassword, { loading, data, error }] = useAdminChangeUserAccountPasswordMutation();

  const updatePassword = async (values: Record<string, string>) => {
    try {
      const variables = {
        data: {
          id: id,
          newPassword: values.newPassword,
        },
      };
      const result = await changePassword({ variables });
      if (result?.errors) {
        setAlert({
          type: "error",
          message: "Error",
          description: result?.errors?.[0]?.message,
          showIcon: true,
        });
      } else {
        sendNotification({
          type: "success",
          message: "Cambio de clave satisfactorio!",
          description: `Se ha editado correctamente la clave del usuario ${firstName} ${lastName}`,
        });
        onSuccess?.();
      }
    } catch (e) {
      setAlert({
        type: "error",
        message: "Error",
        description: `${e}`,
        showIcon: true,
      });
    }
  };

  return {
    updatePassword,
    loading,
    data: data?.adminChangeUserAccountPassword,
    error,
    alert,
  };
};

const useCurrentUser = () => {
  const user = useStoreState((state) => state.user.data);

  const hasTrackPermission = (): boolean => {
    return !!(
      user?.entityId &&
      user?.role &&
      (user?.role === SpdRole.Operator ||
        user?.role === SpdRole.Validator ||
        user?.role === SpdRole.Auditor ||
        user?.role === SpdRole.Admin)
    );
  };

  const hasValidatePermission = (): boolean => {
    return !!(
      user?.entityId &&
      user?.role &&
      (user?.role === SpdRole.Validator ||
        user?.role === SpdRole.Auditor ||
        user?.role === SpdRole.Admin)
    );
  };

  const hasReviewPermission = (): boolean => {
    return !!(
      user?.entityId &&
      user?.role &&
      (user?.role === SpdRole.Auditor || user?.role === SpdRole.Admin)
    );
  };

  const hasRole = (roles: SPDRole[]): boolean => {
    return Boolean(user?.role && roles.includes(user?.role));
  };

  const isOperator = (): boolean => hasRole([SPDRole.OPERATOR]);
  const isValidator = (): boolean => hasRole([SPDRole.VALIDATOR]);
  const isAuditor = (): boolean => hasRole([SPDRole.AUDITOR]);
  const isAdmin = (): boolean => hasRole([SPDRole.ADMIN]);

  return {
    user,
    hasTrackPermission,
    hasValidatePermission,
    hasRole,
    isOperator,
    isValidator,
    isAuditor,
    isAdmin,
    hasReviewPermission,
  };
};

export {
  useUsers,
  useDeleteUser,
  useCreateUser,
  useUserDetail,
  useEditUser,
  useChangePassword,
  useCurrentUser,
};
