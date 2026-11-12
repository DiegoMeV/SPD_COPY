import React, { CSSProperties, useState } from "react";
import { Input } from "antd";

const { Search } = Input;

type Props = {
  value?: string;
  placeholder?: string;
  onSearch?: (value?: string) => void;
  disabled?: boolean;
  style?: CSSProperties;
  allowClear?: boolean;
};

const SearchInput: React.FC<Props> = ({
  value,
  placeholder,
  onSearch,
  disabled = false,
  style,
  allowClear = true,
}) => {
  const [searchText, setSearchText] = useState<string>(value ?? "");

  const triggerChange = (changedValue?: string) => {
    onSearch?.(changedValue);
  };

  const onSearchChange = (value: string) => {
    triggerChange(value);
  };

  return (
    <Search
      placeholder={placeholder}
      onSearch={onSearchChange}
      style={{ ...style }}
      disabled={disabled}
      allowClear={allowClear}
      value={searchText}
      onChange={(e) => setSearchText(e.target.value)}
    />
  );
};

export { SearchInput };
