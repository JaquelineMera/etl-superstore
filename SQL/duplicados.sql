-- Query para contar duplicados, por etiqueta de columna

-- Para category
-- Office Supplies 31,273; Technology 10,141; Furniture 9,876
SELECT 
  category, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  category
ORDER BY 
  total_count DESC;

-- Para city
-- City - 3,636
SELECT 
  city, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  city
ORDER BY 
  total_count DESC;

-- Para country
-- Country - 147
SELECT 
  country, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  country
ORDER BY 
  total_count DESC;

-- Para customer_ID
-- Customer_ID - 4,873
SELECT 
  customer_ID, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  customer_ID
ORDER BY 
  total_count DESC;

-- Para customer_name
-- Customer_name - 795
SELECT 
  customer_name, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  customer_name
ORDER BY 
  total_count DESC;

-- Para discount
-- Discount - 23 diferentes, 29,470 no tiene descuento
-- Descuentos más frecuentes 0.2 5039; 0.1 4068; 0.4 3281 y 0.6 2029
SELECT 
  discount, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  discount
ORDER BY 
  total_count DESC;

-- Para market
-- Market - 7 regiones, APAC, LATAM, EU, US, EMEA, Africa y Canada
SELECT 
  market, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  market
ORDER BY 
  total_count DESC;

-- Para unknown
-- Unknown Solo tiene el valor de 1
SELECT 
  unknown, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  unknown
ORDER BY 
  total_count DESC;

-- Para order_date
-- Order_date de 2011-01-01 a 2014-12-31
-- 2014-06-18 día con más ventas 135
SELECT 
  order_date, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  order_date
ORDER BY 
  total_count DESC;

-- Para order_id
-- Order_id 25035
-- Porqué el order_id se repite
SELECT 
  order_id, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  order_id
ORDER BY 
  total_count DESC;

-- Para order_priority
-- Order_priority 4
-- Medium 29,433; High 15,501; Critical 3,932; Low 2,424
SELECT 
  order_priority, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  order_priority
ORDER BY 
  total_count DESC;

-- Para product_id
-- Product_id 10,292
SELECT 
  product_id, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  product_id
--HAVING
--COUNT(*) > 1
ORDER BY 
  total_count DESC;

-- Para product_name
-- Proudct_name 3,788 Hay productos con el mismo nombre, pero diferente id
SELECT 
  product_name, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  product_name
ORDER BY 
  total_count DESC;

-- Para profit
-- La mayoria de productos no tiene ganancia, su valor es 0 (rango -6599 a +8399)
-- Hay productos con profit negativo
SELECT 
  profit, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  profit
ORDER BY 
  total_count DESC;

-- Para quantity
-- Quantity la mayoria pide 2, rango es de 1 a 13
SELECT 
  quantity, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  quantity
ORDER BY 
  total_count DESC;

-- Para region
-- Region, hay 13 regiones
-- Central* 11117; South* 6645; EMEA 5029; North* 4785 Africa 4587; Oceania 3487; West* 3203;
-- Southeast Asia 3129; East 2848; North Asia 2338; Central Asia 2048;Caribbean 1690;Canada 384
SELECT 
  region, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  region
ORDER BY 
  total_count DESC;

-- Para row_id
-- Row_id 51290, no se repiten 
SELECT 
  row_id, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  row_id
ORDER BY 
  total_count DESC;

-- Para sales
-- Sales 2,246
-- Hacer sumatorias de venta  
SELECT 
  sales, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  sales
ORDER BY 
  total_count DESC;

-- Para segment
-- Segment 3 diferentes, cosumer 26,518; Corporate 15,429; Home Office 9,343 
SELECT 
  segment, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  segment
ORDER BY 
  total_count DESC;

-- Para ship_date
-- Ship_date 2011-01-03 a 2015-01-07; 2014-11-22 más envios 
SELECT 
  ship_date, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  ship_date
ORDER BY 
  total_count DESC;

-- Para ship_mode
-- Ship_mode Standard Class 30,775; Second Class 10,309; First Class 7,505; Same Day 2,701 
SELECT 
  ship_mode, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  ship_mode
ORDER BY 
  total_count DESC;

-- Para shipping_cost
-- Shipping_cost 16,877 (933.57 a 0.002) 
SELECT 
  shipping_cost, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  shipping_cost
ORDER BY 
  total_count DESC;

-- Para state
-- State 1094 diferentes 
SELECT 
  state, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  state
ORDER BY 
  total_count DESC;

-- Para sub_category
-- Sub_category 17 tipos de cosas en venta (departamentos) 
SELECT 
  sub_category, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  sub_category
ORDER BY 
  total_count DESC;

-- Para year
-- Year 2014 17,531; 2013 13,799; 2012 10,962; 2011 8,998 
SELECT 
  year, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  year
ORDER BY 
  total_count DESC;

-- Para market2
-- Market2 6 regiones, APAC, LATAM, EU, North America (US y Canada) EMEA, Africa 
SELECT 
  market2, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  market2
ORDER BY 
  total_count DESC;

-- Para weeknum
-- Weeknum 53 igual que el número de semanas
SELECT 
  weeknum, 
  COUNT(*) AS total_count
FROM 
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY 
  weeknum
ORDER BY 
  total_count DESC;

--Query contar cuantos rows distintos hay - 51,290
SELECT DISTINCT * FROM `proyecto-5-etl-superstore.dataset_superstore.superstore`; 

-- Query por duplicados por combinación
  SELECT 
    order_id, 
    customer_ID,
    country, 
    COUNT(*) AS products_count
  FROM 
    `proyecto-5-etl-superstore.dataset_superstore.superstore`
  GROUP BY 
    order_id,
    customer_ID,
    country;
-- HAVING 
-- COUNT(*) > 1;


--Query tabla duplicados, no hay
  SELECT 
    category,
    city,
    country,
    customer_ID,
    customer_name,
    discount,
    market,
    unknown,
    order_date,
    order_id,
    order_priority,
    product_id,
    product_name,
    profit,
    quantity,
    region,
    row_id,
    sales,
    segment,
    ship_date,
    ship_mode,
    shipping_cost,
    state,
    sub_category,
    year,
    market2,
    weeknum,
    COUNT(*) AS duplicate_count
  FROM 
    `proyecto-5-etl-superstore.dataset_superstore.superstore`
  GROUP BY 
    category,
    city,
    country,
    customer_ID,
    customer_name,
    discount,
    market,
    unknown,
    order_date,
    order_id,
    order_priority,
    product_id,
    product_name,
    profit,
    quantity,
    region,
    row_id,
    sales,
    segment,
    ship_date,
    ship_mode,
    shipping_cost,
    state,
    sub_category,
    year,
    market2,
    weeknum
  HAVING 
    COUNT(*) > 1
