-- Tabla de dimension Order
CREATE OR REPLACE TABLE `proyecto-5-etl-superstore.dataset_superstore.dim_order` AS
SELECT
    CONCAT(order_id, '-', customer_ID) AS ticket_id, 
    order_id,
    customer_ID AS customer_id,
    CAST(order_date AS DATE) AS order_date,  
    weeknum,
    order_priority,
    CAST(ship_date AS DATE) AS ship_date, 
    ship_mode,
    DATE_DIFF(CAST(ship_date AS DATE), CAST(order_date AS DATE), DAY) AS ship_time_days,  
    city,
    region
FROM 
    `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY
    order_id,
    customer_ID,
    order_date,
    weeknum,
    order_priority,
    ship_date,
    ship_mode,
    ship_time_days,
    city,
    region;
