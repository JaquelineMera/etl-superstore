CREATE OR REPLACE TABLE `proyecto-5-etl-superstore.dataset_superstore.table_competence` AS
SELECT
  CONCAT(LPAD(CAST(ROW_NUMBER() OVER (ORDER BY company) AS STRING), 3, '0'), '-', company) AS competence_id,
  company,
  headquarters,
  served_countries,
  number_of_locations,
  number_of_employees
FROM
  `proyecto-5-etl-superstore.dataset_superstore.competence`
ORDER BY company ASC;
