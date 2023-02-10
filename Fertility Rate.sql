/*
Global Fertility rate and birth death growth rate Case study,Data analysis,1950 to 2050
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
  
  
Output:

  
  [{
  "country_name": "Rwanda",
  "year": "1978",
  "Max_total_fertility_rate": "8.07"
}]
  

--
-- Maximum and Minimum fertility rate for all the age groups by countries in descending order
--


Input:

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


Output:

 [{
  "country_name": "Zimbabwe",
  "max_fertility_rate_15_19": "133.0",
  "min_fertility_rate_15_19": "97.6",
  "max_fertility_rate_20_24": "294.0",
  "min_fertility_rate_20_24": "195.2",
  "max_fertility_rate_25_29": "303.0",
  "min_fertility_rate_25_29": "172.0",
  "max_fertility_rate_30_34": "268.0",
  "min_fertility_rate_30_34": "135.0",
  "max_fertility_rate_35_39": "217.0",
  "min_fertility_rate_35_39": "86.0",
  "max_fertility_rate_40_44": "107.0",
  "min_fertility_rate_40_44": "32.7",
  "max_fertility_rate_45_49": "37.0",
  "min_fertility_rate_45_49": "5.8"}
  
  ........]
  


--
--	Maximum and Minimum gross reproduction rate in ascending order (Female life births per woman)
--


Input:

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

Output:

[{
  "country_name": "Afghanistan",
  "Max_gross_reproduction_rate": "3.9024",
  "Min_gross_reproduction_rate": "2.2088"
 
 .........]


--
-- Average Fertility Rate 
--


Input:

SELECT
  country_name,
  AVG(total_fertility_rate) AS average_total_fertility_rate
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
GROUP BY
  1
ORDER BY
  1 ASC;
  
Output:

[{
  "country_name": "Afghanistan",
  "average_total_fertility_rate": "5.4135416666666654"
 
 ...........]

--
--  Total Fertility Rate greater than 2.1
--

Input:


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

Input:

SELECT
  DISTINCT (country_name),
  sex_ratio_at_birth
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year = 2022
  AND sex_ratio_at_birth < 1.0
ORDER BY
  1 ASC,
  2 ASC;


--
--  Highest Age-specific fertility rate for age 25-29 (births per 1,000 population) between 1950 to 2050
--


Input:


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
  3 DESC
LIMIT
  1;


--
-- Merging the tables
--

Input:

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
  
  
  Output:
  
  
  
  
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
  MAX (total_fertility_rate) AS max_total_fertility_rate,
  MIN (total_fertility_rate) AS min_total_fertility_rate,
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
  2,
  1
ORDER BY
  2 ASC;
  
  
  Ouput:
  
  [{
  "country_code": "AF",
  "country_name": "Afghanistan",
  "max_crude_birth_rate": "54.44",
  "max_crude_death_rate": "24.34",
  "min_crude_birth_rate": "34.9",
  "min_crude_death_rate": "11.96",
  "max_total_fertility_rate": "8.0",
  "min_total_fertility_rate": "2.75",
  "max_net_migration": "116.76",
  
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
  
  
  
  
