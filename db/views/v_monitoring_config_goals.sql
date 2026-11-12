CREATE OR REPLACE VIEW v_monitoring_config_goals AS
SELECT mc.tenant_id,
       t.name tenant_name,
       mc.id monitoring_config_id,
       mc.dev_plan_id,
       mc.period,
       mc.subperiod,
       dp.code dev_plan_code,
       dp.name dev_plan_name,
       dp.code || ' - ' || dp.name  || ' (' || mc.period || ' - ' || mc.subperiod || ')' period_str,
       g.id, 
       g.code, 
       g.name, 
       g.goal_type, 
       g.entity_id, 
       e.name entity_name
FROM   monitoring_config mc
JOIN   tenant t ON t.id = mc.tenant_id
JOIN   dev_plan dp ON dp.id = mc.dev_plan_id
JOIN   goal g ON g.dev_plan_id = dp.id
JOIN   entity e ON e.id = g.entity_id
ORDER BY mc.id DESC;

GRANT SELECT ON v_monitoring_config_goals TO spd;
GRANT SELECT ON v_monitoring_config_goals TO public;
COMMIT;