import React, { useState, useEffect } from "react";
import { Select, Spin } from "antd";
import { useCommonData } from "../../../hooks/useCommon";
import { useStoreState } from "../../../store";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  width?: number | string;
};

const SelectProductSector: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  width = 400,
}) => {
  const productsSectors = useStoreState((state) => state.common.productSectors);
  const loading = useStoreState((state) => state.common.loading);
  const { getProductSectors } = useCommonData();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!productsSectors) {
      getProductSectors();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [productsSectors]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onProductSectorsChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loading.productSectors) return <Spin />;

  return (
    <span>
      <Select style={{ width }} onChange={onProductSectorsChange} value={value} disabled={disabled}>
        {productsSectors?.map((productSector) => (
          <Option
            value={productSector.id}
            key={`productSector${productSector.id}`}
          >{`${productSector.code} - ${productSector.name}`}</Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectProductSector };
