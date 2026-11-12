import React, { useState } from "react";
import { Select } from "antd";
import { SpdRole } from "../../../../graphql/gen/schema";
import { SPDRoleMap } from "../../../utils/uiUtils";

const { Option } = Select;

type Props = {
  value?: SpdRole;
  onChange?: (value?: SpdRole) => void;
  disabled?: boolean;
};

const SelectSPDRole: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setSpdRole] = useState<SpdRole | undefined>();

  const triggerChange = (changedValue?: SpdRole) => {
    onChange?.(changedValue);
  };

  const onSpdRoleChange = (value?: SpdRole) => {
    setSpdRole(value as SpdRole);
    triggerChange(value as SpdRole);
  };

  return (
    <span>
      <Select style={{ width: 400 }} onChange={onSpdRoleChange} value={value} disabled={disabled}>
        <Option value={SpdRole.Operator} key={`SpdRole.Operator`}>
          {SPDRoleMap[SpdRole.Operator]?.tag}
        </Option>
        <Option value={SpdRole.Validator} key={`SpdRole.Validator`}>
          {SPDRoleMap[SpdRole.Validator]?.tag}
        </Option>
        <Option value={SpdRole.Auditor} key={`SpdRole.Auditor`}>
          {SPDRoleMap[SpdRole.Auditor]?.tag}
        </Option>
        <Option value={SpdRole.Admin} key={`SpdRole.Admin`}>
          {SPDRoleMap[SpdRole.Admin]?.tag}
        </Option>
      </Select>
    </span>
  );
};

export { SelectSPDRole };
