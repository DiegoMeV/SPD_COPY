-- This is an empty migration.

UPDATE monitoring_config mc
SET    tenant_id = (
    SELECT tenant_id
    FROM   dev_plan dp
    WHERE  dp.id = mc.dev_plan_id
);