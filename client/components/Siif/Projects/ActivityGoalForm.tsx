import React, { useEffect, useState } from "react";
import { Form, FormListFieldData, Input, Select, Space } from "antd";
import { ButtonAdd, ButtonDelete } from "../Buttons";
import { SelectGoalForPlan } from "../Selects";
import { NumberInput } from "../Inputs/NumberInput/NumberInput";
import { GoalType } from "../../../graphql/gen/schema";
import { useDevPlan } from "../DevPlan/hooks";
import { SiifActividadMetaRecord } from "../../store/models/siifProyecto";

const { Option } = Select;

type Props = {
  fields: FormListFieldData[];
  goals?: Array<SiifActividadMetaRecord>;
  onSelect?: (row?: SiifActividadMetaRecord) => void;
  add: (defaultValue?: any, insertIndex?: number | undefined) => void;
  remove: (index: number | number[]) => void;
};

const ActivityGoalForm: React.FC<Props> = ({ fields, add, remove, onSelect, goals = [] }) => {
  const { selectedDevPlanId } = useDevPlan();
  useEffect(() => {
    if (!goals?.length) add();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [goals.length]);

  const [width, setWidth] = useState(window.innerWidth);
  useEffect(() => {
    const handleResize = () => {
      setWidth(window.innerWidth);
    };
    window.addEventListener("resize", handleResize);
    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return (
    <table width={"98%"} style={{ border: "1px solid #f0f0f0 ", margin: "0 auto" }}>
      <colgroup>
        <col style={{ width: "12%" }} />
        <col style={{ width: "68%" }} />
        <col style={{ width: "10%" }} />
        <col style={{ width: "10%" }} />
      </colgroup>
      <thead style={{ border: "1px solid #f0f0f0 " }}>
        <tr style={{ backgroundColor: "#fafafa", height: "3em" }}>
          <th>ID</th>
          <th>Meta</th>
          <th>Ponderación</th>
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
                onSelect?.(goals?.[index]);
              }}
            >
              <td style={{ padding: "5px" }}>
                <Form.Item {...restField} name={[name, "id"]} labelCol={{ span: 10 }}>
                  <Input disabled />
                </Form.Item>
              </td>
              <td style={{ padding: "5px" }}>
                <Form.Item {...restField} name={[name, "goalId"]} labelCol={{ span: 10 }}>
                  {selectedDevPlanId && (
                    <SelectGoalForPlan
                      devPlanId={selectedDevPlanId}
                      goalType={GoalType.Product}
                      width={`${width * 0.19}px`}
                    />
                  )}
                </Form.Item>
              </td>

              <td style={{ padding: "5px" }}>
                <Form.Item {...restField} name={[name, "weighting"]} labelCol={{ span: 10 }}>
                  <NumberInput />
                </Form.Item>
              </td>

              <td style={{ padding: "5px", marginLeft: "10px" }} align="center">
                <Form.Item>
                  <Space>
                    <ButtonAdd title="Nueva meta" onClick={() => add()}></ButtonAdd>
                    <ButtonDelete title="Eliminar meta" onClick={() => remove(name)} />
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

export { ActivityGoalForm };
