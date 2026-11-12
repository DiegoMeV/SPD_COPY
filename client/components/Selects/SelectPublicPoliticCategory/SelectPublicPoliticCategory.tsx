import React, { useState, useEffect } from "react";
import { Select } from "antd";
import { PublicPoliticCategory } from "../../../../graphql/gen/schema";

const { Option } = Select;

type Props = {
  value?: PublicPoliticCategory[];
  onChange?: (value?: PublicPoliticCategory[]) => void;
  disabled?: boolean;
};

const SelectPublicPoliticCategory: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setSelectPublicPoliticCategory] = useState<PublicPoliticCategory[] | undefined>();

  const triggerChange = (changedValue?: PublicPoliticCategory[]) => {
    onChange?.(changedValue);
  };

  const onSelectChange = (value?: PublicPoliticCategory[]) => {
    setSelectPublicPoliticCategory(value as PublicPoliticCategory[]);
    triggerChange(value as PublicPoliticCategory[]);
  };

  return (
    <span>
      <Select
        style={{ width: 350 }}
        onChange={onSelectChange}
        value={value}
        disabled={disabled}
        defaultValue={[PublicPoliticCategory.Territory]}>
        <Option value={PublicPoliticCategory.Peace} key={`PublicPoliticCategory.Peace`}>
          Paz
        </Option>
        <Option value={PublicPoliticCategory.Victims} key={`PublicPoliticCategory.Victims`}>
          Víctimas
        </Option>
      </Select>
    </span>
  );
};

export { SelectPublicPoliticCategory };
