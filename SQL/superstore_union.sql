-- Tabla de union
CREATE OR REPLACE TABLE
  proyecto-5-etl-superstore.dataset_superstore.superstore_union AS
WITH dim_order_unique AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY ticket_id ORDER BY ticket_id) AS rn 
  FROM `proyecto-5-etl-superstore.dataset_superstore.dim_order`
),
dim_customer_unique AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS rn 
  FROM `proyecto-5-etl-superstore.dataset_superstore.dim_customer`
),
dim_product_unique AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY product_id) AS rn  
  FROM `proyecto-5-etl-superstore.dataset_superstore.dim_product`
),
dim_market_unique AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY market_id ORDER BY market_id) AS rn  
  FROM `proyecto-5-etl-superstore.dataset_superstore.dim_market`
)

SELECT 
  h.ticket_id,
  h.quantity,
  h.sales,
  h.discount,
  h.profit,
  h.shipping_cost,
  h.year,
  o.order_id,
  o.order_date,
  o.weeknum,
  o.ship_time_days,
  o.order_priority,
  o.ship_date,
  o.ship_mode,
  o.city,
  o.region, 
  h.customer_id,
  c.customer_name,
  c.segment, 
  h.product_id,  
  p.product_name,
  p.category,
  p.sub_category,
  h.market_id,
  m.state,
  m.country,
  m.market,
  m.market2,
FROM `proyecto-5-etl-superstore.dataset_superstore.tabla_hechos` AS h
LEFT JOIN dim_order_unique AS o
  ON h.ticket_id = o.ticket_id AND o.rn = 1  
LEFT JOIN dim_customer_unique AS c
  ON h.customer_id = c.customer_id AND c.rn = 1  
LEFT JOIN dim_product_unique AS p
  ON h.product_id = p.product_id AND p.rn = 1  
LEFT JOIN dim_market_unique AS m
  ON h.market_id = m.market_id AND m.rn = 1;  
