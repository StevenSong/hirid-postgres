SET
	search_path = hirid;

WITH expected AS (
	SELECT
		'observations_table' AS tbl,
		776921131 AS row_count
	UNION
	ALL
	SELECT
		'pharma_records' AS tbl,
		16270399 AS row_count
),
observed AS (
	SELECT
		'observations_table' AS tbl,
		count(*) AS row_count
	FROM
		observations
	UNION
	ALL
	SELECT
		'pharma_records' AS tbl,
		count(*) AS row_count
	FROM
		pharma
)
SELECT
	exp.tbl,
	exp.row_count AS expected_count,
	obs.row_count AS observed_count,
	CASE
		WHEN exp.row_count = obs.row_count THEN 'PASSED'
		ELSE 'FAILED'
	END AS ROW_COUNT_CHECK
FROM
	expected exp
	INNER JOIN observed obs ON exp.tbl = obs.tbl
ORDER BY
	exp.tbl;