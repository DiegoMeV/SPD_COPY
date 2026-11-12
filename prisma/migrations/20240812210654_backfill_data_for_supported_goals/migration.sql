-- This is an empty migration.

UPDATE monitoring_config
SET    goal_types = ARRAY['PRODUCT', 'RESULT']::"GoalType"[]
WHERE  goal_types IS NULL;