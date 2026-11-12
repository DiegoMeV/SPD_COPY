import React from "react";
import { Spin, Result, Card, Typography, Descriptions, Row, Col, Modal, Space } from "antd";
import { useRouter } from "next/router";
import { useGetEntityQuery } from "../../../graphql/gen/hooks";
import { ButtonBack, ButtonDelete, ButtonEdit } from "../Buttons";
import { EntityFragment } from "../../../graphql/gen/ops";
import { useDeleteEntityMutation, GetEntitiesDocument } from "../../../graphql/gen/hooks";
import { ExclamationCircleOutlined } from "@ant-design/icons";

const { Title } = Typography;
const { confirm } = Modal;

type Props = {
  id: number;
  data?: EntityFragment[];
};

const EntityDetails: React.FC<Props> = ({ id }) => {
  const router = useRouter();
  const [deleteEntity] = useDeleteEntityMutation({
    refetchQueries: [{ query: GetEntitiesDocument }, "GetEntities"],
  });
  const { loading, error, data } = useGetEntityQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  const entity = data?.getEntity;

  const showDeleteConfirm = (entity: EntityFragment) => {
    confirm({
      title: "Está seguro de eliminar esta entidad?",
      icon: <ExclamationCircleOutlined />,
      content: (
        <span>
          <Title style={{ display: "inline" }} level={5}>
            {entity.name}
          </Title>
          se eliminará de forma permanente, desea continuar?
        </span>
      ),
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk() {
        onConfirmDelete(entity.id);
        backEntities();
      },
    });
  };

  const onConfirmDelete = async (id: number) => {
    await deleteEntity({
      variables: {
        id,
      },
    });
  };

  const backEntities = () => router.push("/config/entities");

  return (
    <Card>
      <Descriptions
        title="Entidad"
        bordered
        column={{ xxl: 2, xl: 2, lg: 2, md: 2, sm: 2, xs: 1 }}
        extra={
          <>
            <Row>
              <Space>
                <Col>
                  <ButtonBack title="Volver" onClick={() => router.push("/config/entities")} />
                </Col>
                <Col>
                  <ButtonEdit
                    title="Editar"
                    onClick={() => router.push(`/config/entities/edit/${entity?.id}`)}
                  />
                </Col>
                <Col>
                  <ButtonDelete
                    title="Eliminar"
                    onClick={() => {
                      if (entity) {
                        showDeleteConfirm(entity);
                      }
                    }}
                  />
                </Col>
              </Space>
            </Row>
          </>
        }
      >
        <Descriptions.Item label="ID">{entity?.id}</Descriptions.Item>
        <Descriptions.Item label="Código">{entity?.code}</Descriptions.Item>
        <Descriptions.Item label="Nombre">{entity?.name}</Descriptions.Item>
      </Descriptions>
    </Card>
  );
};

export { EntityDetails };
