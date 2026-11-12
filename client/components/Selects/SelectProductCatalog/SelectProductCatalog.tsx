import React, { useState, useEffect } from "react";
import { Select, Spin } from "antd";
import { useCommonData } from "../../../hooks/useCommon";
import { useStoreState } from "../../../store";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
};

const SelectProductCatalog: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const productsCatalog = useStoreState((state) => state.common.productsCatalog);
  const loading = useStoreState((state) => state.common.loading);
  const { getProductsCatalog } = useCommonData();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!productsCatalog) {
      getProductsCatalog();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [productsCatalog]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onProductCatalogChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loading.productCatalog) return <Spin />;

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onProductCatalogChange}
        value={value}
        disabled={disabled}
        placeholder="Seleccione un indicador"
        filterOption={(input, option) =>
          !!option && (option.children as unknown as string).includes(input)
        }
        filterSort={(optionA, optionB) =>
          !!optionA &&
          (optionA.children as unknown as string)
            .toLowerCase()
            .localeCompare(!!optionB && (optionB.children as unknown as string).toLowerCase())
        }
        showSearch
        allowClear
      >
        {productsCatalog?.map((itemCatalog) => (
          <Option value={itemCatalog.id} key={`unit${itemCatalog.id}`}>
            {`${itemCatalog.code} - ${itemCatalog.name}`}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectProductCatalog };
