-- This is an empty migration.

UPDATE monitoring_record_resource mrr
SET     rp = ROUND(mrr.rp::numeric, 2),
        sgp = ROUND(mrr.sgp::numeric, 2),
        cn = ROUND(mrr.cn::numeric, 2),
        cd = ROUND(mrr.cd::numeric, 2),
        sgr = ROUND(mrr.sgr::numeric, 2),
        credit = ROUND(mrr.credit::numeric, 2),
        others = ROUND(mrr.others::numeric, 2),
        management = ROUND(mrr.management::numeric, 2),
        operation = ROUND(mrr.operation::numeric, 2),
        sgp_education = ROUND(mrr.sgp_education::numeric, 2),
        sgp_health = ROUND(mrr.sgp_health::numeric, 2),
        sgp_water = ROUND(mrr.sgp_water::numeric, 2),
        sgp_culture = ROUND(mrr.sgp_culture::numeric, 2),
        sgp_sport = ROUND(mrr.sgp_sport::numeric, 2),
        sgp_free_investment = ROUND(mrr.sgp_free_investment::numeric, 2),
        sgp_free_destination = ROUND(mrr.sgp_free_destination::numeric, 2),
        sgp_school_feeding = ROUND(mrr.sgp_school_feeding::numeric, 2),
        sgp_magdalena_river = ROUND(mrr.sgp_magdalena_river::numeric, 2),
        sgp_early_childhood = ROUND(mrr.sgp_early_childhood::numeric, 2)
WHERE mrr.id IN (
    SELECT t.id FROM (
        SELECT mrr.id, (mrr.sgp_culture + mrr.sgp_early_childhood + mrr.sgp_education + mrr.sgp_free_destination + 
                    mrr.sgp_free_investment + mrr.sgp_health + mrr.sgp_magdalena_river + mrr.sgp_school_feeding +
                    mrr.sgp_sport + mrr.sgp_water) tot,
            ROUND((mrr.sgp_culture + mrr.sgp_early_childhood + mrr.sgp_education + mrr.sgp_free_destination + 
                    mrr.sgp_free_investment + mrr.sgp_health + mrr.sgp_magdalena_river + mrr.sgp_school_feeding +
                    mrr.sgp_sport + mrr.sgp_water)::numeric, 2) tot2dp
        FROM   monitoring_record_resource mrr
    ) t
    WHERE t.tot <> tot2dp
);
       