import React from "react";
import { Badge, BadgeProps, Typography } from "antd";

type Props = {
  text: React.ReactNode;
  count?: number;
  type?: "filter" | "title";
  color?: BadgeProps["color"];
  width?: number;
  offset?: [number, number];
};

const { Title, Text } = Typography;

const TextWithBadge: React.FC<Props> = ({
  text,
  count = 0,
  type = "title",
  width = 250,
  color,
  offset,
}) => {
  if (type === "filter") {
    return (
      <span style={{ marginRight: 30, paddingRight: 5 }}>
        <Badge
          count={count}
          overflowCount={9999}
          color={count === 0 ? "red" : color}
          offset={[24, 10]}
          showZero
        >
          <Text ellipsis={true} style={{ width }}>
            {text}
          </Text>
        </Badge>
      </span>
    );
  }
  if (type === "title") {
    return (
      <Badge
        count={count}
        overflowCount={99999}
        color="hwb(205 6% 9%)"
        offset={offset ?? [8 * (`${count}`.length + 1), 10]}
        showZero
      >
        <Title level={5}>{text}</Title>
      </Badge>
    );
  }
  return <></>;
};

export { TextWithBadge };
