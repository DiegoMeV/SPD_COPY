import React from "react";
import { useProyectoDetail } from "./hooks";
import { ContentLoading } from "../../Utils/ContentLoading";
import { Descriptions, Tree } from "antd";
import { DownOutlined } from "@ant-design/icons";
import { ProjectDetailsTabs } from "./ProjectDetailsTabs";
import { num2Money } from "../../../utils/formatUtils";

type Props = {
  projectNumber: string;
};

const ProjectDetails: React.FC<Props> = ({ projectNumber }) => {
  const { data, loading, error, treeLevels, treeKeys } = useProyectoDetail(projectNumber);

  return (
    <ContentLoading loading={loading} error={error}>
      {data && (
        <>
          <Descriptions bordered>
            <Descriptions.Item label="Proyecto" span={1}>
              {data.proyecto}
            </Descriptions.Item>
            <Descriptions.Item label="Entidad" span={1}>
              {`${data.entity?.code} - ${data.entity?.name}`}
            </Descriptions.Item>
            <Descriptions.Item label="Valor" span={1}>
              {num2Money(data.valorProyecto ?? 0)}
            </Descriptions.Item>
            <Descriptions.Item label="Nombre" span={3}>
              {data.nombre}
            </Descriptions.Item>

            <Descriptions.Item
              label={data.devPlan?.config?.levels?.slice(-1)?.singularName ?? "Subprograma"}
              span={3}
            >
              <Tree
                defaultExpandAll
                showLine
                switcherIcon={<DownOutlined />}
                treeData={treeLevels}
                titleRender={(nodeData) => `${nodeData.code} ${nodeData.title}`}
                expandedKeys={treeKeys}
              ></Tree>
            </Descriptions.Item>
          </Descriptions>
          <ProjectDetailsTabs project={data} />
        </>
      )}
    </ContentLoading>
  );
};

export { ProjectDetails };
