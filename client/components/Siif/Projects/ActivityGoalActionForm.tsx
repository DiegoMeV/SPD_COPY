import React, { useEffect } from "react";
import { Form, FormListFieldData, Input, Select, Space } from "antd";
import { ButtonAdd, ButtonDelete } from "../Buttons";
import { SelectGoalForPlan } from "../Selects";
import { NumberInput } from "../Inputs/NumberInput/NumberInput";
import { GoalType } from "../../../graphql/gen/schema";
import { useDevPlan } from "../DevPlan/hooks";
import { SiifActividadMetaAccionRecord } from "../../store/models/siifProyecto";

type Props = {
  fields: FormListFieldData[];
  actions?: Array<SiifActividadMetaAccionRecord>;
  onSelect?: (row?: SiifActividadMetaAccionRecord) => void;
  add: (defaultValue?: any, insertIndex?: number | undefined) => void;
  remove: (index: number | number[]) => void;
};

const ActivityGoalActionForm: React.FC<Props> = ({
  fields,
  add,
  remove,
  onSelect,
  actions = [],
}) => {
  useEffect(() => {
    if (!actions?.length) add();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [actions.length]);

  return (
    <table width={"98%"} style={{ border: "1px solid #f0f0f0 ", margin: "0 auto" }}>
      <colgroup>
        <col width="12%" />
        <col width="78%" />
        <col width="10%" />
      </colgroup>
      <thead style={{ border: "1px solid #f0f0f0 " }}>
        <tr style={{ backgroundColor: "#fafafa", height: "3em" }}>
          <th>ID</th>
          <th>Acción</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        {fields.map(({ key, name, ...restField }, index) => {
          return (
            <tr
              key={`row${index}`}
              style={{
                border: "1px solid #f0f0f0 ",
              }}
              onClick={() => {
                onSelect?.(actions?.[index]);
              }}
            >
              <td style={{ padding: "5px" }}>
                <Form.Item {...restField} name={[name, "id"]} labelCol={{ span: 10 }}>
                  <Input disabled />
                </Form.Item>
              </td>
              <td style={{ padding: "5px" }}>
                <Form.Item {...restField} name={[name, "descripcion"]} labelCol={{ span: 10 }}>
                  <Input />
                </Form.Item>
              </td>

              <td style={{ padding: "5px", marginLeft: "10px" }} align="center">
                <Form.Item>
                  <Space>
                    <ButtonAdd title="Nueva accion" onClick={() => add()}></ButtonAdd>
                    <ButtonDelete title="Eliminar accion" onClick={() => remove(name)} />
                  </Space>
                </Form.Item>
              </td>
            </tr>
          );
        })}
      </tbody>
    </table>
  );
};

export { ActivityGoalActionForm };
