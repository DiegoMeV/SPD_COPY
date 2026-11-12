import React, { useEffect } from "react";
import { Checkbox, Form, FormListFieldData, Input, InputNumber, Select, Space } from "antd";
import { ButtonAdd, ButtonDelete } from "../Buttons";
import { SelectGoalType } from "../Selects";

type Props = {
  fields: FormListFieldData[];
  levels?: Array<Record<string, number | string>>;
  add: (defaultValue?: any, insertIndex?: number | undefined) => void;
  remove: (index: number | number[]) => void;
};

const DevPlanLevelForm: React.FC<Props> = ({ fields, add, remove, levels = [] }) => {
  useEffect(() => {
    if (!levels?.length) add();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [levels.length]);
  return (
    <>
      <table width={"90%"} style={{ border: "1px solid #f0f0f0 ", margin: "0 auto" }}>
        <colgroup>
          <col width="10%" />
          <col width="20%" />
          <col width="20%" />
          <col width="25%" />
          <col width="15%" />
          <col width="10%" />
        </colgroup>
        <thead style={{ border: "1px solid #f0f0f0 " }}>
          <tr style={{ backgroundColor: "#fafafa", height: "3em" }}>
            <th>Nivel</th>
            <th>Nombre Singular</th>
            <th>Nombre Plural</th>
            <th>Tipo de meta</th>
            <th>Asocia sector DNP?</th>
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
              >
                <td style={{ padding: "5px" }}>
                  <Form.Item
                    {...restField}
                    name={[name, "number"]}
                    labelCol={{ span: 12 }}
                    wrapperCol={{ span: 14 }}
                  >
                    <InputNumber defaultValue={`${index + 1}`} disabled />
                  </Form.Item>
                </td>
                <td style={{ padding: "5px" }}>
                  <Form.Item {...restField} name={[name, "singularName"]} labelCol={{ span: 10 }}>
                    <Input placeholder="Nombre Singular" style={{ width: "250px" }} />
                  </Form.Item>
                </td>
                <td style={{ padding: "5px" }}>
                  <Form.Item {...restField} name={[name, "pluralName"]} labelCol={{ span: 10 }}>
                    <Input placeholder="Nombre Plural" style={{ width: "250px" }} />
                  </Form.Item>
                </td>
                <td style={{ padding: "5px" }}>
                  <Form.Item {...restField} name={[name, "goalType"]} labelCol={{ span: 10 }}>
                    <SelectGoalType width={250} />
                  </Form.Item>
                </td>
                <td style={{ padding: "5px" }}>
                  <Form.Item
                    {...restField}
                    style={{ marginLeft: "40%" }}
                    valuePropName="checked"
                    name={[name, "isSectorLevel"]}
                    labelCol={{ span: 20 }}
                  >
                    <Checkbox />
                  </Form.Item>
                </td>
                <td style={{ padding: "5px", marginLeft: "10px" }} align="center">
                  <Form.Item>
                    <Space>
                      <ButtonAdd title="Nuevo nivel" onClick={() => add()}></ButtonAdd>
                      <ButtonDelete title="Eliminar nivel" onClick={() => remove(name)} />
                    </Space>
                  </Form.Item>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </>
  );
};

export { DevPlanLevelForm };
