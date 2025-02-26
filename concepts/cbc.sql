CREATE TABLE hirid_derived.pivoted_cbc AS
SELECT
    patient_id,
    obs_time,
    ph,
    paco2,
    pao2,
    base_excess,
    wbc,
    -- g/L to g/dL
    hgb / 10,
    plt,
    hgb / mchc * 100 AS hct
FROM
    (
        SELECT
            patient_id,
            obs_time,
            AVG(
                CASE
                    WHEN var_id IN (20000300) THEN obs_value
                END
            ) AS ph,
            AVG(
                CASE
                    WHEN var_id IN (20001200) THEN obs_value
                END
            ) AS paco2,
            AVG(
                CASE
                    WHEN var_id IN (20000200) THEN obs_value
                END
            ) AS pao2,
            AVG(
                CASE
                    WHEN var_id IN (20001300) THEN obs_value
                END
            ) AS base_excess,
            AVG(
                CASE
                    WHEN var_id IN (20000700) THEN obs_value
                END
            ) AS wbc,
            AVG(
                CASE
                    WHEN var_id IN (20000900, 24000836) THEN obs_value
                END
            ) AS hgb,
            AVG(
                CASE
                    WHEN var_id IN (24000170) THEN obs_value
                END
            ) AS mchc,
            AVG(
                CASE
                    WHEN var_id IN (20000110) THEN obs_value
                END
            ) AS plt
        FROM
            hirid.observations
        GROUP BY
            patient_id,
            obs_time
    );