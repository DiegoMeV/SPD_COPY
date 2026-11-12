import React, { useState, useEffect } from "react";
import { Select, Spin } from "antd";
import { useCommonData } from "../../../hooks/useCommon";
import { useStoreState } from "../../../store";
import { PublicPoliticCategory } from "../../../../graphql/gen/schema";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  category?: PublicPoliticCategory;
};

const SelectPublicPolitics: React.FC<Props> = ({ value, onChange, disabled = false, category }) => {
  const publicPolitics = useStoreState((state) => state.common.publicPolitics);
  const loadingEntity = useStoreState((state) => state.entity.loading);
  const { getPublicPolitics } = useCommonData();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!publicPolitics) {
      getPublicPolitics();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [publicPolitics]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onPublicPoliticsChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loadingEntity.entities) return <Spin />;

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onPublicPoliticsChange}
        value={value}
        disabled={disabled}
        placeholder="Seleccione una política pública"
        showSearch
        allowClear
      >
        {(category
          ? publicPolitics?.filter((publicPolitic) => publicPolitic.category === category)
          : publicPolitics
        )?.map((publicPolitic) => (
          <Option value={publicPolitic.id} key={`${publicPolitic.id}`}>{`${
            publicPolitic.code || ""
          } - ${publicPolitic.name}`}</Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectPublicPolitics };
