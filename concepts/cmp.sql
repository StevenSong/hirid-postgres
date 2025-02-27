CREATE TABLE hirid_derived.cmp_components AS
SELECT
    *
FROM
    hirid.observations
WHERE
    var_id IN (
        -- bicarbonate
        20004200,
        -- chloride
        24000439,
        24000521,
        -- potassium
        20000500,
        24000520,
        24000833,
        24000867,
        -- sodium
        20000400,
        24000519,
        24000658,
        24000835,
        24000866,
        -- calcium
        20005100,
        -- glucose
        20005110,
        24000523,
        24000585,
        -- creatinine
        20000600,
        -- bun
        20004100,
        -- bilirubin
        20004300,
        -- albumin
        24000605,
        -- alp
        20002700,
        -- ast
        24000330,
        -- alt
        20002600
    );

CREATE TABLE hirid_derived.pivoted_cmp AS
SELECT
    patient_id,
    obs_time,
    bicarbonate,
    chloride,
    potassium,
    sodium,
    -- mmol/L to mg/dL
    calcium / 0.2495 AS calcium,
    -- mmol/L to mg/dL
    glucose / 0.0555 AS glucose,
    -- umol/L to mg/dL
    creatinine / 88.42 AS creatinine,
    -- mmol/L to mg/dL
    bun / 0.3571 AS bun,
    -- umol/L to mg/dL
    bilirubin / 17.1 AS bilirubin,
    -- g/L to g/dL
    albumin / 10 AS albumin,
    alp,
    ast,
    alt
FROM
    (
        SELECT
            patient_id,
            obs_time,
            AVG(
                CASE
                    WHEN var_id IN (20004200) THEN obs_value
                END
            ) AS bicarbonate,
            AVG(
                CASE
                    WHEN var_id IN (24000439, 24000521) THEN obs_value
                END
            ) AS chloride,
            AVG(
                CASE
                    WHEN var_id IN (20000500, 24000520, 24000833, 24000867) THEN obs_value
                END
            ) AS potassium,
            AVG(
                CASE
                    WHEN var_id IN (
                        20000400,
                        24000519,
                        24000658,
                        24000835,
                        24000866
                    ) THEN obs_value
                END
            ) AS sodium,
            AVG(
                CASE
                    WHEN var_id IN (20005100) THEN obs_value
                END
            ) AS calcium,
            AVG(
                CASE
                    WHEN var_id IN (20005110, 24000523, 24000585) THEN obs_value
                END
            ) AS glucose,
            AVG(
                CASE
                    WHEN var_id IN (20000600) THEN obs_value
                END
            ) AS creatinine,
            AVG(
                CASE
                    WHEN var_id IN (20004100) THEN obs_value
                END
            ) AS bun,
            AVG(
                CASE
                    WHEN var_id IN (20004300) THEN obs_value
                END
            ) AS bilirubin,
            AVG(
                CASE
                    WHEN var_id IN (24000605) THEN obs_value
                END
            ) AS albumin,
            AVG(
                CASE
                    WHEN var_id IN (20002700) THEN obs_value
                END
            ) AS alp,
            AVG(
                CASE
                    WHEN var_id IN (24000330) THEN obs_value
                END
            ) AS ast,
            AVG(
                CASE
                    WHEN var_id IN (20002600) THEN obs_value
                END
            ) AS alt
        FROM
            hirid_derived.cmp_components
        GROUP BY
            patient_id,
            obs_time
    );