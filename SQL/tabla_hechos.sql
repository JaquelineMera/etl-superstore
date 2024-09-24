-- Tabla de hechos Ventas
CREATE OR REPLACE TABLE
  `proyecto-5-etl-superstore.dataset_superstore.tabla_hechos` AS
SELECT
  CONCAT(order_id, '-', customer_ID) AS ticket_id,
  customer_ID AS customer_id,
  product_id,
  CONCAT(state, '_', country) AS market_id,
  quantity,
  sales,
  discount,
  profit,
  shipping_cost,
  year
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY
  ticket_id,
  order_id,
  customer_ID,
  product_id,
  market_id,
  quantity,
  sales,
  discount,
  profit,
  shipping_cost,
  year;
