/*
Global Fertility rate Case study,Data analysis,1950 to 2050
*/


-- ---------------------------------------------------------

--
--	Maximum total fertility rate from 1950 to 2023 
--

Input: 

SELECT
  country_name,
  year,
  MAX (total_fertility_rate) AS Max_total_fertility_rate
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year BETWEEN 1950
  AND 2023
GROUP BY
  country_name,
  year
ORDER BY
  Max_total_fertility_rate DESC
LIMIT
  1;
  
  
  output:
  
  
  

--
-- Maximum and Minimum fertility rate for all the age groups by countries in descending order
--


SELECT
  country_name,
  MAX(fertility_rate_15_19) AS max_fertility_rate_15_19,
  MIN(fertility_rate_15_19) AS min_fertility_rate_15_19,
  MAX(fertility_rate_20_24) AS max_fertility_rate_20_24,
  MIN(fertility_rate_20_24) AS min_fertility_rate_20_24,
  MAX(fertility_rate_25_29) AS max_fertility_rate_25_29,
  MIN(fertility_rate_25_29) AS min_fertility_rate_25_29,
  MAX(fertility_rate_30_34) AS max_fertility_rate_30_34,
  MIN(fertility_rate_30_34) AS min_fertility_rate_30_34,
  MAX(fertility_rate_35_39) AS max_fertility_rate_35_39,
  MIN(fertility_rate_35_39) AS min_fertility_rate_35_39,
  MAX(fertility_rate_40_44) AS max_fertility_rate_40_44,
  MIN(fertility_rate_40_44) AS min_fertility_rate_40_44,
  MAX(fertility_rate_45_49) AS max_fertility_rate_45_49,
  MIN(fertility_rate_45_49) AS min_fertility_rate_45_49,
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year BETWEEN 1950
  AND 2023
GROUP BY
  country_name
ORDER BY
  country_name DESC;



--
--	Maximum and Minimum gross reproduction rate in ascending order (Female life births per woman)
--



SELECT
  country_name,
  MAX(gross_reproduction_rate) AS Max_gross_reproduction_rate,
  MIN(gross_reproduction_rate) AS Min_gross_reproduction_rate
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year BETWEEN 1950
  AND 2023
GROUP BY
  country_name
ORDER BY
  country_name ASC;


--
-- Average Fertility Rate 
--


SELECT
  country_name,
  AVG(total_fertility_rate) AS average_total_fertility_rate
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
GROUP BY
  country_name
ORDER BY
  country_name ASC;

--
--  Total Fertility Rate greater than 2.1
--


SELECT
  country_name,
  total_fertility_rate
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year = 2022
  AND total_fertility_rate > 2.1
ORDER BY
  total_fertility_rate ASC;

--
--	Countries where the sex ratio at birth is less than 1.0 in 2022
--


SELECT
  DISTINCT (country_name),
  sex_ratio_at_birth
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year = 2022
  AND sex_ratio_at_birth < 1.0
ORDER BY
  country_name ASC,
  sex_ratio_at_birth ASC;


--
--  Highest Age-specific fertility rate for age 25-29 (births per 1,000 population) between 1950 to 2050
--


SELECT
  country_name,
  year,
  MAX (fertility_rate_25_29) AS max_fertility_rate_25_29
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year BETWEEN 1950
  AND 2023
GROUP BY
  country_name,
  year
ORDER BY
  max_fertility_rate_25_29 DESC
LIMIT
  1;


--
-- Merging the data
--

SELECT
  *
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates` AS age_specific_fertility_rates
INNER JOIN
  `bigquery-public-data.census_bureau_international.birth_death_growth_rates` AS birth_death_growth_rates
ON
  age_specific_fertility_rates.country_name = birth_death_growth_rates.country_name
  AND age_specific_fertility_rates.country_code = birth_death_growth_rates.country_code
ORDER BY
  age_specific_fertility_rates.country_name ASC;
  
  --
  -- Maximum and minimum crude birth rate, crude death rate, total fertility rate and net migration between 1950 to 2023
  --
  
  
SELECT
  birth_death_growth_rates.country_code,
  birth_death_growth_rates.country_name,
  MAX(crude_birth_rate) AS max_crude_birth_rate,
  MAX(crude_death_rate) AS max_crude_death_rate,
  MIN(crude_birth_rate) AS min_crude_birth_rate,
  MIN(crude_death_rate) AS min_crude_death_rate,
  MAX (total_fertility_rate) AS Max_total_fertility_rate,
  MIN (total_fertility_rate) AS Min_total_fertility_rate,
  MAX(net_migration) AS max_net_migration,
  MIN(net_migration) AS min_net_migration,
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates` AS age_specific_fertility_rates
INNER JOIN
  `bigquery-public-data.census_bureau_international.birth_death_growth_rates` AS birth_death_growth_rates
ON
  age_specific_fertility_rates.country_name = birth_death_growth_rates.country_name
  AND age_specific_fertility_rates.country_code = birth_death_growth_rates.country_code
WHERE
  birth_death_growth_rates.year BETWEEN 1950
  AND 2023
GROUP BY
  birth_death_growth_rates.country_name,
  birth_death_growth_rates.country_code
ORDER BY
  birth_death_growth_rates.country_name ASC;
  
  
  --
  -- Average net migration
  --
  
  
 SELECT
  country_name,
  AVG(net_migration)
FROM
  `bigquery-public-data.census_bureau_international.birth_death_growth_rates`
GROUP BY
  country_name
  ORDER BY 
  country_name;
  
  
  
  
