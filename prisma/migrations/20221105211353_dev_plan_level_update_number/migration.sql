-- This is an empty migration.
UPDATE dev_plan_level
SET    level = 1
WHERE  parent_id IS NULL;

UPDATE dev_plan_level
SET    level = 2
WHERE  parent_id IN (
    SELECT id
    FROM   dev_plan_level
    WHERE  level = 1
);

UPDATE dev_plan_level
SET    level = 3
WHERE parent_id IN (
    SELECT id
    FROM   dev_plan_level
    WHERE  level = 2
);

UPDATE dev_plan_level
SET    level = 3
WHERE parent_id IN (
    SELECT id
    FROM   dev_plan_level
    WHERE  level = 3
);

