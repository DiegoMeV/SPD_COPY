import React, { useState } from "react";
import { Select } from "antd";
import { SpentDoc } from "../../../../graphql/gen/schema";

const { Option } = Select;

type Props = {
  value?: SpentDoc[];
  onChange?: (value?: SpentDoc[]) => void;
  disabled?: boolean;
};

const SelectSpentDoc: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setSpentDoc] = useState<SpentDoc[] | undefined>();

  const triggerChange = (changedValue?: SpentDoc[]) => {
    onChange?.(changedValue);
  };

  const onSpentDocChange = (value?: SpentDoc[]) => {
    setSpentDoc(value as SpentDoc[]);
    triggerChange(value as SpentDoc[]);
  };

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onSpentDocChange}
        value={value}
        disabled={disabled}
        defaultValue={[SpentDoc.Obligation]}
        mode="multiple"
      >
        <Option value={SpentDoc.Commitment} key={`SpentDoc.Commitment`}>
          Compromisos
        </Option>
        <Option value={SpentDoc.Obligation} key={`SpentDoc.Obligation`}>
          Obligaciones
        </Option>
        <Option value={SpentDoc.Payment} key={`SpentDoc.Payment`}>
          Pagos
        </Option>
      </Select>
    </span>
  );
};

export { SelectSpentDoc };
