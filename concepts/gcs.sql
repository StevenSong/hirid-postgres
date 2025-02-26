CREATE TABLE hirid_derived.gcs AS
SELECT
    *
FROM
    observations
WHERE
    var_id IN (
        -- verbal
        10000100,
        -- motor
        10000200,
        -- eye
        10000300
    );

CREATE TABLE hirid_derived.pivoted_gcs AS
SELECT
    *,
    gcs_motor + gcs_eye + gcs_verbal AS gcs
FROM
    (
        SELECT
            patient_id,
            obs_time,
            AVG(
                CASE
                    WHEN var_id = 10000100 THEN obs_value
                END
            ) AS gcs_verbal,
            AVG(
                CASE
                    WHEN var_id = 10000200 THEN obs_value
                END
            ) AS gcs_motor,
            AVG(
                CASE
                    WHEN var_id = 10000300 THEN obs_value
                END
            ) AS gcs_eye
        FROM
            gcs
        GROUP BY
            patient_id,
            obs_time
    );