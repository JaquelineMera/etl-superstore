-- Query para inconsistencias numéricas
SELECT
  'discount' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(discount AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(discount AS FLOAT64) IS NULL
  AND discount IS NOT NULL

UNION ALL

SELECT
  'profit' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(profit AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(profit AS FLOAT64) IS NULL
  AND profit IS NOT NULL

UNION ALL

SELECT
  'quantity' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(quantity AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(quantity AS FLOAT64) IS NULL
  AND quantity IS NOT NULL

UNION ALL

SELECT
  'row_id' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(row_id AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(row_id AS FLOAT64) IS NULL
  AND row_id IS NOT NULL

UNION ALL

SELECT
  'sales' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(sales AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(sales AS FLOAT64) IS NULL
  AND sales IS NOT NULL

UNION ALL

SELECT
  'shipping_cost' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(shipping_cost AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(shipping_cost AS FLOAT64) IS NULL
  AND shipping_cost IS NOT NULL

UNION ALL

SELECT
  'year' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(year AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(year AS FLOAT64) IS NULL
  AND year IS NOT NULL

UNION ALL

SELECT
  'weeknum' AS variable,
  COUNT(*) AS count_inconsistent,
  ARRAY_AGG(CAST(weeknum AS STRING)) AS inconsistent_values
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
WHERE
  SAFE_CAST(weeknum AS FLOAT64) IS NULL
  AND weeknum IS NOT NULL
