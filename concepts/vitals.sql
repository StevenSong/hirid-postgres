CREATE TABLE hirid_derived.pivoted_vitals AS
SELECT
    patient_id,
    obs_time,
    AVG(
        CASE
            WHEN var_id IN (200) THEN obs_value
        END
    ) AS hr,
    AVG(
        CASE
            WHEN var_id IN (300, 310, 5685) THEN obs_value
        END
    ) AS rr,
    AVG(
        CASE
            WHEN var_id IN (100) THEN obs_value
        END
    ) AS sbp,
    AVG(
        CASE
            WHEN var_id IN (120) THEN obs_value
        END
    ) AS dbp,
    AVG(
        CASE
            WHEN var_id IN (600) THEN obs_value
        END
    ) AS sbp_ni,
    AVG(
        CASE
            WHEN var_id IN (620) THEN obs_value
        END
    ) AS dbp_ni,
    AVG(
        CASE
            WHEN var_id IN (4000, 8280) THEN obs_value
        END
    ) AS spo2
FROM
    hirid.observations
GROUP BY
    patient_id,
    obs_time;