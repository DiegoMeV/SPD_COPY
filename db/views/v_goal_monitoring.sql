CREATE OR REPLACE VIEW v_goal_monitoring AS
SELECT mc.tenant_id,
       mr.goal_id, 
       mr.record_status,
       dp.code || ' - ' || dp.name  || ' (' || mc.period || ' - ' || mc.subperiod || ')' period_str
FROM   monitoring_config mc
JOIN   tenant t ON t.id = mc.tenant_id
JOIN   dev_plan dp ON dp.id = mc.dev_plan_id
JOIN   monitoring_record mr ON mr.monitoring_config_id = mc.id;

GRANT SELECT ON v_goal_monitoring TO spd;
GRANT SELECT ON v_goal_monitoring TO public;
COMMIT;


