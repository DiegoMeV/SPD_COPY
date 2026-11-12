import React from "react";
import { Descriptions, Col, Row } from "antd";
import type { DescriptionsProps } from "antd";
import { useCurrentUser } from "../Users/hooks";
import { SPDRoleMap } from "../../utils/uiUtils";

const UserProfile: React.FC = () => {
  const { user } = useCurrentUser();
  const borderedItems: DescriptionsProps["items"] = [
    {
      label: "Documento",
      children: user?.docNumber,
      key: "1",
    },
    {
      label: "Nombres",
      children: user?.firstName,
      key: "2",
    },
    {
      label: "Apellidos",
      children: user?.lastName,
      key: "3",
    },
    {
      label: "Correo Electrónico",
      children: user?.email,
      key: "4",
    },
    {
      label: "Número telefónico",
      children: user?.phone,
      key: "5",
    },
    {
      label: "Entidad",
      children: `${user?.entity?.code} - ${user?.entity?.name}`,
      key: "6",
    },
    {
      label: "Rol",
      children: `${user?.role ? SPDRoleMap[user?.role]?.tag : null}`,
      key: "7",
    },
  ];

  return (
    <Row gutter={[8, 8]}>
      <Col span={12}>
        <Descriptions
          title="Mi Perfil"
          bordered
          items={borderedItems}
          layout="horizontal"
          column={1}
        />
      </Col>
    </Row>
  );
};

export { UserProfile };
