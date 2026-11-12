import { Button, Drawer, Radio, Input, Form } from "antd";
import React, { useState } from "react";
import { FormSubmitButtons } from "../../Buttons/FormSubmitButtons";

const { TextArea } = Input;
const { Item } = Form;

const itemLayout = { labelCol: { span: 24 }, wrapperCol: { span: 24 } };

type Props = {
  onSave: () => void;
  loading: boolean;
};

const MonitoringReviewDialog: React.FC<Props> = ({ onSave, loading }) => {
  const [open, setOpen] = useState(false);

  const showDrawer = () => {
    setOpen(true);
  };

  const onClose = () => {
    setOpen(false);
  };

  return (
    <>
      <Button type="primary" onClick={showDrawer}>
        Aprobar/Rechazar
      </Button>
      <Drawer
        title="Aprobar o Rechazar Seguimiento"
        placement="right"
        onClose={onClose}
        open={open}
        extra={
          <FormSubmitButtons
            type="icons"
            submitAction={() => {
              onSave();
              onClose();
            }}
            loading={loading}
            returnAction={onClose}
            returnText="Cancelar"
          />
        }
      >
        <Item name="reviewStatus">
          <Radio.Group>
            <Radio value={"approved"}>Aprobar</Radio>
            <Radio value={"rejected"}>Rechazar</Radio>
          </Radio.Group>
        </Item>
        <Item name={"reviewNotes"} label="Observación" style={{ marginTop: 10 }} {...itemLayout}>
          <TextArea rows={6} placeholder="Ingrese una observación si lo requiere" />
        </Item>
      </Drawer>
    </>
  );
};

export { MonitoringReviewDialog };
