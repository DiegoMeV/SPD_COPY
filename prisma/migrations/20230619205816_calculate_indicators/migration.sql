-- This is an empty migration.

-- Calculate physical indicators
UPDATE monitoring_record mr
SET    physical_indicator = LEAST(ROUND((mr.goal_achieved_value / mr.goal_value)::numeric, 4), 1.0)
WHERE  mr.monitoring_config_id = 4
AND    mr.goal_value IS NOT NULL
AND    mr.goal_value <> 0
AND    physical_indicator IS NULL;

UPDATE monitoring_record_resource mrr
SET    financial_indicator = LEAST(ROUND(((mrr.capital + mrr.cd + mrr.cn + mrr.credit + mrr.de + mrr.operation + mrr.management + mrr.monopoly + mrr.others + mrr.rp + mrr.sgp + mrr.sgr)/ mrra.total_resources)::numeric, 4), 1.0) 
FROM (
    SELECT mrra.*, mrra.capital + mrra.cd + mrra.cn + mrra.credit + mrra.de + mrra.operation + mrra.management + mrra.monopoly + mrra.others + mrra.rp + mrra.sgp + mrra.sgr total_resources
    FROM   monitoring_record_resource mrra
    JOIN   monitoring_record mr ON mrra.monitoring_record_id = mr.id
    WHERE  mrra.capital + mrra.cd + mrra.cn + mrra.credit + mrra.de + mrra.operation + mrra.management + mrra.monopoly + mrra.others + mrra.rp + mrra.sgp + mrra.sgr > 0
    AND    mrra.resource_type = 'DEFINITIVE'
) mrra
WHERE mrr.monitoring_record_id = mrra.monitoring_record_id
AND   mrr.resource_type IN ('COMMITMENT', 'OBLIGATION')
AND   mrr.financial_indicator IS NULL;
  