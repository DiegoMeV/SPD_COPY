-- dev plan levels
SELECT * FROM (
    select vesp.nit_compania "tenantKey", 
           vesp.id "id", 
           pd.plan "devPlanCode",
           vesp.consecutivo "code",
           vesp.codigo_txt "fullCode",
           vesp.nombre "name",
           vesp.nivel "level",
           vesp.id_padre "parentId"
    from V_ESTRUCTURA_PLAN vesp
    JOIN plan_desarrollo pd on pd.id = vesp.id_plan_desarrollo
    WHERE vesp.nivel = 1
    AND   pd.plan <> 0
    UNION ALL
    select vesp.nit_compania "tenantKey", 
           vesp.id "id", 
           pd.plan "devPlanCode",
           vesp.consecutivo "code",
           vesp.codigo_txt "fullCode",
           vesp.nombre "name",
           vesp.nivel "level",
           vesp.id_padre "parentId"
    from V_ESTRUCTURA_PLAN vesp
    JOIN plan_desarrollo pd on pd.id = vesp.id_plan_desarrollo
    WHERE vesp.nivel = 2
    AND   pd.plan <> 0
    UNION ALL
    select vesp.nit_compania "tenantKey", 
           vesp.id "id", 
           pd.plan "devPlanCode",
           vesp.consecutivo "code",
           vesp.codigo_txt "fullCode",
           vesp.nombre "name",
           vesp.nivel "level",
           vesp.id_padre "parentId"
    from V_ESTRUCTURA_PLAN vesp
    JOIN plan_desarrollo pd on pd.id = vesp.id_plan_desarrollo
    WHERE vesp.nivel = 3
    AND   pd.plan <> 0
    UNION ALL
    select vesp.nit_compania "tenantKey", 
           vesp.id "id", 
           pd.plan "devPlanCode",
           vesp.consecutivo "code",
           vesp.codigo_txt "fullCode",
           vesp.nombre "name",
           vesp.nivel "level",
           vesp.id_padre "parentId"
    from V_ESTRUCTURA_PLAN vesp
    JOIN plan_desarrollo pd on pd.id = vesp.id_plan_desarrollo
    WHERE vesp.nivel = 4
    AND   pd.plan <> 0
)
ORDER BY  "devPlanCode", "level", "code";


-- entities
SELECT nit_compania "tenantKey",
       codigo_ent_pry "code",
       nombre_ent_pry "name",
       id "id",
       DECODE(activa, 'N', 'false', 'true') "isActive"
FROM   entidades_pry;