import React from 'react';
import { PublicPoliticsLoader } from '../PublicPoliticsLoader';
import { useRowSelection } from '../../../hooks/useTable';
import { Row, Col } from 'antd';
import { GoalsForPublicPolitic } from '../../Goals/GoalsForPublicPolitic/GoalsForPublicPolitic';
import { useStoreState } from '../../../store';


const PublicPoliticActions: React.FC = () => {
    const selectedPublicPolitic = useStoreState((state) => state.publicPolitic.selectedPublicPolitic);

    return (
        <Row gutter={[8, 0]}>
            <Col span={10}>
                <PublicPoliticsLoader localization="territorial" selectable />
            </Col>
            {selectedPublicPolitic && (
                <Col span={14}>
                    <GoalsForPublicPolitic />
                </Col>
            )}
        </Row>
    );
};

export { PublicPoliticActions };