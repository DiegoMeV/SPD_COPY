import { Form, Input, Checkbox, FormListFieldData, Space } from "antd";
import React, { useEffect } from "react";
import { ButtonAdd, ButtonDelete } from "../Buttons";
import { ColorInput } from "../Inputs";
import { NumberInput } from "../Inputs/NumberInput/NumberInput";

type Props = {
  fields: FormListFieldData[];
  colorsConfig?: Array<any>;
  add: (defaultValue?: any, insertIndex?: number | undefined) => void;
  remove: (index: number | number[]) => void;
};

const MonitoringConfigColorsForm: React.FC<Props> = ({
  fields,
  colorsConfig = [],
  add,
  remove,
}) => {
  useEffect(() => {
    if (!colorsConfig?.length) add();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [colorsConfig?.length]);

  return (
    <>
      <table width={"100%"} style={{ border: "1px solid #f0f0f0 ", margin: "0 auto" }}>
        <thead style={{ border: "1px solid #f0f0f0 " }}>
          <tr style={{ backgroundColor: "#fafafa", height: "80px" }}>
            <th>Desde</th>
            <th>Incluye desde?</th>
            <th>Hasta</th>
            <th>Incluye hasta?</th>
            <th>Color</th>
            <th>Etiqueta</th>
            <th></th>
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
                <td style={{ paddingLeft: "5px" }}>
                  <Form.Item {...restField} name={[name, "fromValue"]} labelCol={{ span: 10 }}>
                    <NumberInput placeholder="Desde" />
                  </Form.Item>
                </td>
                <td style={{ width: "20px" }}>
                  <Form.Item valuePropName="checked" name={[name, "includeFromValue"]}>
                    <Checkbox></Checkbox>
                  </Form.Item>
                </td>
                <td>
                  <Form.Item {...restField} name={[name, "toValue"]} labelCol={{ span: 10 }}>
                    <Input placeholder="Hasta" style={{ width: "150px", marginLeft: "20px" }} />
                  </Form.Item>
                </td>
                <td style={{ width: "20px" }}>
                  <Form.Item valuePropName="checked" name={[name, "includeToValue"]}>
                    <Checkbox></Checkbox>
                  </Form.Item>
                </td>
                <td>
                  <Form.Item style={{ marginLeft: "40px" }} name={[name, "color"]}>
                    <ColorInput />
                  </Form.Item>
                </td>
                <td>
                  <Form.Item {...restField} name={[name, "label"]} labelCol={{ span: 10 }}>
                    <Input placeholder="Etiqueta" style={{ width: "180px", marginLeft: "20px" }} />
                  </Form.Item>
                </td>
                <td>
                  <Form.Item style={{ marginLeft: 40 }}>
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

export { MonitoringConfigColorsForm };
