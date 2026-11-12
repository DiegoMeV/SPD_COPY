import { Space } from "antd";
import { useRouter } from "next/router";
import React from "react";
import { UserAccountFragment } from "../../../graphql/gen/ops";
import { ButtonEdit, ButtonDelete } from "../Buttons";
import { useDeleteUser } from "./hooks";
import { UserChangePassword } from "./UserChangePassword";

type Props = {
  user: UserAccountFragment;
};

const UsersTableActions: React.FC<Props> = ({ user }) => {
  const router = useRouter();
  const { deleteUser, loading } = useDeleteUser();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <ButtonEdit title="Editar" onClick={() => router.push(`/config/users/edit/${user.id}`)} />
      <ButtonDelete
        message="Está seguro de eliminar este usuario?"
        onDelete={() => {
          deleteUser(user.id);
        }}
        loading={loading}
      />
      <UserChangePassword id={user.id} firstName={user.firstName} lastName={user.lastName} />
    </Space>
  );
};

export { UsersTableActions };
