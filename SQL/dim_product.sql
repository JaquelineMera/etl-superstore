-- Tabla de dimension Producto
CREATE OR REPLACE TABLE `proyecto-5-etl-superstore.dataset_superstore.dim_product` AS
SELECT
    product_id,
    product_name,
    category,
    sub_category
FROM 
    `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY
    product_id,
    product_name,
    category,
    sub_category;
