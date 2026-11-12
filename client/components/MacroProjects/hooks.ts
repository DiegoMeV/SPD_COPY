import { useEffect, useState } from "react";
import {
  GetMacroProjectDocument,
  GetMacroProjectsDocument,
  useCreateMacroProjectMutation,
  useDeleteMacroProjectMutation,
  useGetMacroProjectQuery,
  useGetMacroProjectsQuery,
  useUpdateMacroProjectMutation,
} from "../../../graphql/gen/hooks";
import { UseTableProps } from "../../hooks/useTable";
import { useRouter } from "next/router";
import { useStoreActions, useStoreState } from "../../store";
import { MacroProjectFragment } from "../../../graphql/gen/ops";
import { FormInstance } from "antd";

type UseEditMacroProjectProps = {
  id: number;
  form?: FormInstance<any>;
};

const useMacroProject = (props: UseTableProps) => {
  const { loading, data, error } = useGetMacroProjectsQuery({
    fetchPolicy: "cache-and-network",
  });

  return {
    loading,
    error,
    data: data?.getMacroProjects ?? [],
    count: data?.getMacroProjects?.length ?? 0,
  };
};

const useDeleteMacroProject = () => {
  const [deleteMacroProject, { loading, data, error }] = useDeleteMacroProjectMutation({
    refetchQueries: [{ query: GetMacroProjectsDocument }],
  });
  const remove = async (id: number) => {
    await deleteMacroProject({
      variables: {
        id,
      },
    });
  };

  return { remove, loading, data, error };
};

const useCreateMacroProject = () => {
  const router = useRouter();
  const tenant = useStoreState((state) => state.tenant.data);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [saveMacroProject, { loading, data, error }] = useCreateMacroProjectMutation({
    refetchQueries: [{ query: GetMacroProjectsDocument }],
  });

  const createCreateMacroProject = async (values: Record<string, string>) => {
    if (tenant?.id) {
      try {
        const variables = {
          data: {
            code: values.code,
            description: values.description,
            name: values.name,
          },
        };
        const result = await saveMacroProject({ variables });
        if (result?.data?.createMacroProject) {
          sendNotification({
            type: "success",
            message: "Macro proyecto creado",
            description: `Se ha creado correctamente el macro proyecto`,
          });
        }
      } catch (e) {
        sendNotification({
          type: "error",
          message: "Creando macro proyecto",
          description: `${e}`,
        });
      } finally {
        router.back();
      }
    }
  };

  return { createCreateMacroProject, loading, data, error };
};

const useMacroProjectDetail = (id: number) => {
  const { loading, error, data } = useGetMacroProjectQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  return {
    loading,
    error,
    data: data?.getMacroProject,
  };
};

const useEditMacroProject = ({ id, form }: UseEditMacroProjectProps) => {
  const router = useRouter();
  const [currentMacroProject, setCurrentMacroProject] = useState<
    MacroProjectFragment | undefined | null
  >();
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const {
    data: detailData,
    loading: detailLoading,
    error: detailError,
  } = useMacroProjectDetail(id);
  const [updateMacroProject, { loading: updateLoading, error: updateError, data: updateData }] =
    useUpdateMacroProjectMutation({
      refetchQueries: [{ query: GetMacroProjectDocument }],
    });

  useEffect(() => {
    setCurrentMacroProject(detailData);
  }, [detailData]);

  useEffect(() => {
    if (currentMacroProject && form) {
      form.setFieldsValue(getFormEditValues());
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentMacroProject, form]);

  const getFormEditValues = () => {
    return {
      code: currentMacroProject?.code,
      description: currentMacroProject?.description,
      id: currentMacroProject?.id,
      name: currentMacroProject?.name,
    };
  };

  const update = async (values: Record<string, string>) => {
    try {
      const variables = {
        data: {
          id,
          code: values.code,
          description: values.description,
          name: values.name,
        },
      };
      const result = await updateMacroProject({ variables });
      if (result?.data?.updateMacroProject) {
        sendNotification({
          type: "success",
          message: "Macro proyecto editado",
          description: `Se ha editado correctamente el macro proyecto`,
        });
      }
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Editando macro proyecto",
        description: `${e}`,
      });
    } finally {
      router.back();
    }
  };

  return {
    update,
    getFormEditValues,
    detailLoading,
    detailError,
    detailData,
    updateLoading,
    updateError,
    updateData: updateData?.updateMacroProject,
  };
};

export {
  useMacroProject,
  useDeleteMacroProject,
  useCreateMacroProject,
  useMacroProjectDetail,
  useEditMacroProject,
};
