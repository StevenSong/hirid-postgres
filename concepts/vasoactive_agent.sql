CREATE TABLE hirid_derived.vasoactive_agent AS
SELECT
    patient_id,
    infusion_id,
    var_id,
    MIN(given_time) AS start_time,
    MAX(given_time) AS end_time
FROM
    pharma
GROUP BY
    patient_id,
    infusion_id,
    var_id;

CREATE TABLE hirid_derived.pivoted_vasoactive AS
SELECT
    patient_id,
    start_time,
    end_time,
    MAX(
        CASE
            WHEN var_id IN (71, 1000750, 1000649, 1000650, 1000655) THEN 1
            ELSE 0
        END
    ) AS epinephrine,
    MAX(
        CASE
            WHEN var_id IN (1000462, 1000656, 1000657, 1000658) THEN 1
            ELSE 0
        END
    ) AS norepinephrine,
    MAX(
        CASE
            WHEN var_id IN (112, 113) THEN 1
            ELSE 0
        END
    ) AS vasopressin,
    MAX(
        CASE
            WHEN var_id IN (426) THEN 1
            ELSE 0
        END
    ) AS dobutamine,
    MAX(
        CASE
            WHEN var_id IN (1000441) THEN 1
            ELSE 0
        END
    ) AS milrinone
FROM
    hirid_derived.vasoactive_agent
GROUP BY
    patient_id,
    start_time,
    end_time;