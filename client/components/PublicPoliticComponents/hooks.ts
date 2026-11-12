import { useEffect, useState } from "react";
import {
  GetPublicPoliticComponentDocument,
  GetPublicPoliticComponentsDocument,
  useCreatePublicPoliticComponentMutation,
  useDeletePublicPoliticComponentMutation,
  useGetPublicPoliticComponentQuery,
  useGetPublicPoliticComponentsQuery,
  useUpdatePublicPoliticComponentMutation,
} from "../../../graphql/gen/hooks";
import { UseTableProps } from "../../hooks/useTable";
import { useRouter } from "next/router";
import { useStoreActions, useStoreState } from "../../store";
import { PublicPoliticComponentFragment } from "../../../graphql/gen/ops";
import { FormInstance } from "antd";

type UseEditPublicPoliticComponentProps = {
  id: number;
  form?: FormInstance<any>;
};

const usePublicPoliticComponent = (props: UseTableProps) => {
  const { loading, data, error } = useGetPublicPoliticComponentsQuery({
    fetchPolicy: "cache-and-network",
  });

  return {
    loading,
    error,
    data: data?.getPublicPoliticComponents ?? [],
    count: data?.getPublicPoliticComponents?.length ?? 0,
  };
};

const useDeletePublicPoliticComponent = () => {
  const [deletePublicPoliticComponent, { loading, data, error }] =
    useDeletePublicPoliticComponentMutation({
      refetchQueries: [{ query: GetPublicPoliticComponentsDocument }],
    });
  const deleteComponent = async (id: number) => {
    await deletePublicPoliticComponent({
      variables: {
        id,
      },
    });
  };

  return { deleteComponent, loading, data, error };
};

const useCreatePublicPoliticComponent = () => {
  const router = useRouter();
  const tenant = useStoreState((state) => state.tenant.data);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [savePublicPoliticComponent, { loading, data, error }] =
    useCreatePublicPoliticComponentMutation({
      refetchQueries: [{ query: GetPublicPoliticComponentsDocument }],
    });

  const createCreatePublicPoliticComponent = async (values: Record<string, string>) => {
    if (tenant?.id) {
      try {
        const variables = {
          data: {
            code: values.code,
            description: values.description,
            name: values.name,
          },
        };
        const result = await savePublicPoliticComponent({ variables });
        if (result?.data?.createPublicPoliticComponent) {
          sendNotification({
            type: "success",
            message: "Componente creado",
            description: `Se ha creado correctamente el componente`,
          });
        }
      } catch (e) {
        sendNotification({
          type: "error",
          message: "Creando componente",
          description: `${e}`,
        });
      } finally {
        router.back();
      }
    }
  };

  return { createCreatePublicPoliticComponent, loading, data, error };
};

const usePublicPoliticComponentDetail = (id: number) => {
  const { loading, error, data } = useGetPublicPoliticComponentQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  return {
    loading,
    error,
    data: data?.getPublicPoliticComponent,
  };
};

const useEditPublicPoliticComponent = ({ id, form }: UseEditPublicPoliticComponentProps) => {
  const router = useRouter();
  const [currentPublicPoliticComponent, setCurrentPublicPoliticComponent] = useState<
    PublicPoliticComponentFragment | undefined | null
  >();
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const {
    data: detailData,
    loading: detailLoading,
    error: detailError,
  } = usePublicPoliticComponentDetail(id);
  const [
    updatePublicPoliticComponent,
    { loading: updateLoading, error: updateError, data: updateData },
  ] = useUpdatePublicPoliticComponentMutation({
    refetchQueries: [{ query: GetPublicPoliticComponentDocument }],
  });

  useEffect(() => {
    setCurrentPublicPoliticComponent(detailData);
  }, [detailData]);

  useEffect(() => {
    if (currentPublicPoliticComponent && form) {
      form.setFieldsValue(getFormEditValues());
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentPublicPoliticComponent, form]);

  const getFormEditValues = () => {
    return {
      code: currentPublicPoliticComponent?.code,
      description: currentPublicPoliticComponent?.description,
      id: currentPublicPoliticComponent?.id,
      name: currentPublicPoliticComponent?.name,
    };
  };

  const updatePublicComponent = async (values: Record<string, string>) => {
    try {
      const variables = {
        data: {
          id,
          code: values.code,
          description: values.description,
          name: values.name,
        },
      };
      const result = await updatePublicPoliticComponent({ variables });
      if (result?.data?.updatePublicPoliticComponent) {
        sendNotification({
          type: "success",
          message: "Componente editado",
          description: `Se ha editado correctamente el componente`,
        });
      }
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Editando componente",
        description: `${e}`,
      });
    } finally {
      router.back();
    }
  };

  return {
    updatePublicComponent,
    getFormEditValues,
    detailLoading,
    detailError,
    detailData,
    updateLoading,
    updateError,
    updateData: updateData?.updatePublicPoliticComponent,
  };
};

export {
  usePublicPoliticComponent,
  useDeletePublicPoliticComponent,
  useCreatePublicPoliticComponent,
  usePublicPoliticComponentDetail,
  useEditPublicPoliticComponent,
};
