CREATE TABLE hirid_derived.pivoted_cmp AS
SELECT
    patient_id,
    obs_time,
    bicarbonate,
    chloride,
    potassium,
    sodium,
    -- mmol/L to mg/dL
    calcium / 0.2495,
    -- mmol/L to mg/dL
    glucose / 0.0555,
    -- umol/L to mg/dL
    creatinine / 88.42,
    -- mmol/L to mg/dL
    bun / 0.3571,
    -- umol/L to mg/dL
    bilirubin / 17.1,
    -- g/L to g/dL
    albumin / 10,
    alp,
    ast,
    alt,
    sodium + potassium - chloride - bicarbonate AS anion_gap
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
            hirid.observations
        GROUP BY
            patient_id,
            obs_time
    );