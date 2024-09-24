  -- Tabla de dimension Market
CREATE OR REPLACE TABLE
  `proyecto-5-etl-superstore.dataset_superstore.dim_market` AS
SELECT
  CONCAT(state, '_', country) AS market_id,
  -- Genera market_id como concatenación de state y country state,
  state,
  country,
  market,
  market2
FROM
  `proyecto-5-etl-superstore.dataset_superstore.superstore`
GROUP BY
  state,
  country,
  market,
  market2;