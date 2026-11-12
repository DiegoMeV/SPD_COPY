-- This is an empty migration.

-- Update goals table to have a tenant_id column
UPDATE goal
SET    tenant_id = (
    SELECT tenant_id
    FROM   dev_plan
    WHERE  dev_plan.id = goal.dev_plan_id
);