import React from "react";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { Form, Select } from "antd";
import { spentDocMap } from "../../../utils/uiUtils";
import { FormInstance } from "antd/lib/form/Form";
import { SpentDoc } from "../../../../graphql/gen/schema";

const { Option } = Select;
type Props = {
  form: FormInstance<any>;
  filterSpentDoc?: SpentDoc;
};

const DashboardGoalsFilters: React.FC<Props> = ({ form, filterSpentDoc }) => {
  const { currentMonitoring } = useMonitoringConfig();

  return (
    <>
      <Form.Item label="Documento Ejecución" name="spentDoc">
        <Select>
          {currentMonitoring?.spentDocs?.map((spentDoc) => (
            <Option value={spentDoc} key={`spentDoc${spentDoc}`}>
              {spentDocMap[spentDoc]?.tag}
            </Option>
          ))}
        </Select>
      </Form.Item>
    </>
  );
};

export { DashboardGoalsFilters };
