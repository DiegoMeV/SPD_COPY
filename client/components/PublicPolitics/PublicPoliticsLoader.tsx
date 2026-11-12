import React from "react";
import { Spin, Result } from "antd";
import { PublicPoliticsTable } from "./PublicPoliticsTable";
import { useSearchPublicPoliticsQuery } from "../../../graphql/gen/hooks";
import { PublicPoliticLocalization } from "../../types/publicPolitic";
import { PublicPoliticCategory } from "../../../graphql/gen/schema";

type Props = {
  localization: PublicPoliticLocalization;
  selectable?: boolean;
};

const PublicPoliticsLoader: React.FC<Props> = ({ localization, selectable = false }) => {
  const { loading, error, data } = useSearchPublicPoliticsQuery({
    variables: {
      data: {
        categories:
          localization === "national"
            ? [PublicPoliticCategory.Peace, PublicPoliticCategory.Victims]
            : [PublicPoliticCategory.Territory],
      },
    },
    fetchPolicy: "cache-and-network",
  });

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  return (
    <PublicPoliticsTable
      data={data?.searchPublicPolitics?.items}
      title={`Políticas Públicas ${localization === "national" ? "Nacionales" : "Territoriales"}`}
      localization={localization}
      selectable={selectable}
    />
  );
};

export { PublicPoliticsLoader };
