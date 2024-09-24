  -- Tabla de dimension Customer
CREATE OR REPLACE TABLE
  `proyecto-5-etl-superstore.dataset_superstore.dim_customer` AS
SELECT
  customer_ID AS customer_id,
  customer_name,
  segment
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY
  customer_ID,
  customer_name,
  segment;