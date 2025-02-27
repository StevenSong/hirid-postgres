CREATE TABLE hirid_derived.cbc_components AS
SELECT
    *
FROM
    hirid.observations
WHERE
    var_id IN (
        -- ph
        20000300,
        -- paco2
        20001200,
        -- pao2
        20000200,
        -- base_excess
        20001300,
        -- wbc
        20000700,
        -- hgb
        20000900,
        24000836,
        -- mchc
        24000170,
        -- plt
        20000110
    );

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
    temp.hgb / 10 AS hgb,
    temp.hgb / mchc * 100 AS hct,
    plt
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
            hirid_derived.cbc_components
        GROUP BY
            patient_id,
            obs_time
    ) AS temp;