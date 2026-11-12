-- This is an empty migration.

-- Duplicated Records
DELETE FROM monitoring_record_resource mrr
WHERE mrr.monitoring_record_id IN (
    SELECT mr.id
    FROM   monitoring_record mr
    WHERE  mr.goal_id IN (
        SELECT t.goal_id
        FROM (
            SELECT mr.goal_id, COUNT(1)
            FROM   monitoring_record mr
            WHERE  mr.monitoring_config_id = 4
            GROUP BY mr.goal_id
            HAVING COUNT(1) > 1
        ) t
    ) 
    AND EXISTS (
        SELECT 1
        FROM   monitoring_record mr2
        WHERE  mr2.monitoring_config_id = mr.monitoring_config_id
        AND    mr2.goal_id = mr.goal_id
        AND    mr2.id > mr.id
    ) 
);

DELETE FROM  monitoring_record mr
    WHERE  mr.goal_id IN (
        SELECT t.goal_id
        FROM (
            SELECT mr.goal_id, COUNT(1)
            FROM   monitoring_record mr
            WHERE  mr.monitoring_config_id = 4
            GROUP BY mr.goal_id
            HAVING COUNT(1) > 1
        ) t
    ) 
    AND EXISTS (
        SELECT 1
        FROM   monitoring_record mr2
        WHERE  mr2.monitoring_config_id = mr.monitoring_config_id
        AND    mr2.goal_id = mr.goal_id
        AND    mr2.id > mr.id
    );

-- Set the real status for reported goals
UPDATE monitoring_record
SET    record_status = 'REPORTED'
WHERE monitoring_config_id = 4
AND id IN  (
    SELECT mrr.monitoring_record_id
    FROM   monitoring_record_resource mrr
    WHERE  mrr.resource_type = 'COMMITMENT'
);

-- sgp doesnt correspond with details

UPDATE monitoring_record_resource AS mrr
SET    sgp = t.spg_discriminated 
FROM (
    SELECT  mrr.id, g.goal_type, g.id goal_id, g.code, mrr.sgp, (mrr.sgp_culture + mrr.sgp_early_childhood + mrr.sgp_education + mrr.sgp_free_destination + 
             mrr.sgp_free_investment + mrr.sgp_health + mrr.sgp_magdalena_river + mrr.sgp_school_feeding +
             mrr.sgp_sport + mrr.sgp_water) spg_discriminated
    FROM    monitoring_record_resource mrr
    JOIN    monitoring_record mr ON mr.id = mrr.monitoring_record_id
    JOIN    monitoring_config mc ON mc.id = mr.monitoring_config_id
    JOIN    goal g ON g.id = mr.goal_id
    WHERE   mc.id = 4
) t
WHERE    mrr.id = t.id
AND      mrr.sgp <> t.spg_discriminated;