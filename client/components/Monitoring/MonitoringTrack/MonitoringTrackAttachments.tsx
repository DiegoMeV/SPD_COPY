import React, { useState, useEffect } from "react";
import { DeleteOutlined, InboxOutlined } from "@ant-design/icons";
import type { UploadProps } from "antd";
import { Alert, Form, message, Popconfirm, Upload } from "antd";
import {
  useCreateMonitoringRecordAttachmentLinkMutation,
  useDeleteMonitoringRecordAttachmentMutation,
  useGetMonitoringRecordAttachmentsLazyQuery,
} from "../../../../graphql/gen/hooks";
import axios from "axios";
import { v4 as v4uuid } from "uuid";

const { Dragger } = Upload;

type Props = {
  disabled?: boolean;
};

const MonitoringTrackAttachments: React.FC<Props> = ({ disabled }) => {
  const [fileList, setFileList] = useState<any[]>([]);
  const [createUploadLink] = useCreateMonitoringRecordAttachmentLinkMutation();
  const [deleteAttachment] = useDeleteMonitoringRecordAttachmentMutation();
  const [getAttachments, { data: dataAttachments }] = useGetMonitoringRecordAttachmentsLazyQuery();
  const form = Form.useFormInstance();
  const monitoringRecordId = form.getFieldValue("id");

  useEffect(() => {
    getAttachments({
      variables: {
        monitoringRecordId,
      },
      fetchPolicy: "network-only",
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [monitoringRecordId]);

  // Check if there are new files to upload and start uploading them
  useEffect(() => {
    if (fileList.length) {
      const uploadFile = async (fileIndex: number) => {
        if (fileIndex >= 0) {
          updateFileData(fileIndex, { status: "uploading" });
          const file = fileList[fileIndex];
          try {
            const response = await startUploadForFile(file.file);
            if (response?.status === 200) {
              const attachment = response.data;
              updateFileData(fileIndex, {
                uid: attachment?.id,
                status: "done",
                url: attachment?.downloadLink,
              });
            }
          } catch (error: any) {
            updateFileData(fileIndex, {
              status: "error",
              response: error?.response?.data,
            });
          }
        }
      };
      const fileToUploadIndex = fileList.findIndex((file) => file.status === "new");
      uploadFile(fileToUploadIndex);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [fileList]);

  useEffect(() => {
    const attachments =
      dataAttachments?.getMonitoringRecordAttachments?.map((attachment) => ({
        uid: attachment.id,
        name: attachment.name,
        status: "done",
        url: attachment.downloadLink,
      })) ?? [];
    setFileList(attachments);
  }, [dataAttachments]);

  const updateFileData = (fileIndex: number, newData: any) => {
    setFileList((fileList) => [
      ...fileList.slice(0, fileIndex),
      { ...fileList[fileIndex], ...newData },
      ...fileList.slice(fileIndex + 1),
    ]);
  };

  const startUploadForFile = async (file: File) => {
    const getUploadLinkResponse = await createUploadLink({
      variables: {
        data: {
          monitoringRecordId,
          name: file.name,
        },
      },
    });
    const uploadAction =
      getUploadLinkResponse.data?.createMonitoringRecordAttachmentLink?.uploadURL;
    if (!uploadAction) {
      message.error("Unable to fetch the upload action URL.");
      return;
    }

    const response = await axios.put(uploadAction, file, {
      headers: {
        "Content-Type": file.type,
      },
    });
    return {
      ...response,
      data: getUploadLinkResponse.data?.createMonitoringRecordAttachmentLink,
    };
  };

  // Function to start uploading for all selected files
  const startUpload = async (files: FileList) => {
    const newFiles = Array.from(files).map((file) => ({
      name: file.name,
      uid: v4uuid(),
      status: "new",
      file,
    }));
    setFileList([...fileList, ...newFiles]);
  };

  const deleteFile = async (file: any) => {
    const response = await deleteAttachment({
      variables: {
        id: file.uid,
      },
    });
    if (response.data?.deleteMonitoringRecordAttachment) {
      setFileList((fileList) => fileList.filter((fileL) => fileL.uid !== file.uid));
    }
    return !!response.data?.deleteMonitoringRecordAttachment;
  };

  const props: UploadProps = {
    name: "file",
    multiple: true,
    onDrop(e) {
      startUpload(e.dataTransfer.files);
    },
    showUploadList: {
      removeIcon: (file: any) => (
        <Popconfirm
          placement="left"
          title="Confirmar"
          description="Está seguro(a) que desea eliminar este archivo?"
          onConfirm={() => deleteFile(file)}
        >
          <DeleteOutlined />
        </Popconfirm>
      ),
    },
    fileList,
  };

  return (
    <>
      {monitoringRecordId && (
        <Dragger {...props} disabled={disabled}>
          <p className="ant-upload-drag-icon">
            <InboxOutlined />
          </p>
          <p className="ant-upload-text">Has clic y arrastra archivos a esta área</p>
          <p className="ant-upload-hint">
            Puedes arrastrar uno o varios archivos como evidencias de ejecución.
          </p>
        </Dragger>
      )}
      {!monitoringRecordId && (
        <Alert
          message="Requiere guardar avance"
          description="Por favor guarde el avance cuantitativo para que pueda adjuntar las evidencias."
          type="info"
          showIcon
        />
      )}
    </>
  );
};

export { MonitoringTrackAttachments };
