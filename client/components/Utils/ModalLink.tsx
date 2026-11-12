import { Modal, Button } from "antd";
import React, { useState } from "react";

type Props = {
  title?: string;
  link: React.ReactNode;
  children: React.ReactNode;
  preLoad?: () => void;
};

const ModalLink: React.FC<Props> = ({ link, children, title, preLoad }) => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleOk = () => {
    setIsModalOpen(false);
  };

  const handleCancel = () => {
    setIsModalOpen(false);
  };

  return (
    <>
      <div
        onClick={() => {
          setIsModalOpen(true);
          preLoad?.();
        }}
      >
        {link}
      </div>
      <Modal
        title={title}
        open={isModalOpen}
        onOk={handleOk}
        onCancel={handleCancel}
        width={1000}
        footer={[
          <Button key="back" onClick={handleCancel}>
            Regresar
          </Button>,
        ]}
      >
        <div style={{ marginRight: "1vw" }}>{children}</div>
      </Modal>
    </>
  );
};

export { ModalLink };
