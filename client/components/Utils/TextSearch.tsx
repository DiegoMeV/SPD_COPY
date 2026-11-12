import React from "react";
import { Typography } from "antd";

type Props = {
  text?: string | null | undefined;
  searchText?: string | null | undefined;
};

const { Text } = Typography;

const TextSearch: React.FC<Props> = ({ text, searchText }) => {
  const strText = text ?? "";
  const strSearchText = searchText ?? "";
  const index = strText.toLocaleLowerCase().indexOf(strSearchText.toLocaleLowerCase());
  const beforeStr = (text ?? "").substring(0, index);
  const afterStr = (text ?? "").slice(index + strSearchText.length);
  const foundStr = (text ?? "").slice(index, index + strSearchText.length);
  return index > -1 ? (
    <span>
      {beforeStr}
      <Text mark>{foundStr}</Text>
      {afterStr}
    </span>
  ) : (
    <span>{strText}</span>
  );
};

export { TextSearch };
