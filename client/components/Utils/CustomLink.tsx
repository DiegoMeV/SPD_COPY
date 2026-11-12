import React from "react";
import { Space } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faArrowUpRightFromSquare } from "@fortawesome/free-solid-svg-icons";
import Link from "next/link";

type Props = {
  href: string;
  target?: React.HTMLAttributeAnchorTarget | undefined;
  children?: string | React.ReactNode;
};

const CustomLink: React.FC<Props> = ({ href, target = "_blank", children }) => {
  return (
    <Link target={target} href={href}>
      <Space>
        <span>{children}</span>
        <span>
          <FontAwesomeIcon icon={faArrowUpRightFromSquare} />
        </span>
      </Space>
    </Link>
  );
};

export { CustomLink };
