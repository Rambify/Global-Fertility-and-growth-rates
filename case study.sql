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
--  Number of countries with Total Fertility Rate greater than 2.1
--

Input:


SELECT
  COUNT(DISTINCT(total_fertility_rate)) AS Number_of_countries
FROM
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
WHERE
  year = 2022
  AND total_fertility_rate > 2.1
  
  Output:
  
[{
  "Number_of_countries": "94"
}]
  

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


Output:

[{
  "country_name": "Kazakhstan",
  "sex_ratio_at_birth": "0.9368"
}, {
  "country_name": "Nauru",
  "sex_ratio_at_birth": "0.8333"
}, {
  "country_name": "United States",
  "sex_ratio_at_birth": "-9.0"
}]


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
  AND 2050
GROUP BY
  country_name,
  year
ORDER BY
  3 DESC
LIMIT
  1;


Output:

[{
  "country_name": "Pakistan",
  "year": "1987",
  "max_fertility_rate_25_29": "369.2"
}]


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
  "max_total_fertility_rate": "8.0",
  "min_total_fertility_rate": "2.75",
  "max_net_migration": "116.76",
  "min_net_migration": "-156.85"
   
   .....]
   
   
  --
  -- Average net migration
  --
  
  Input:
  
 SELECT
  country_name,
  AVG(net_migration) AS average_net_migration
FROM
  `bigquery-public-data.census_bureau_international.birth_death_growth_rates`
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
  "average_net_migration": "-5.74822222222222"
}, {
   
   ....]
   
   
  
  --
  -- Join the columns from two tabes
  --
  
  Input:
  
  
   
     SELECT
  age.country_name,
  age.total_fertility_rate,
  birth.growth_rate
FROM (
  SELECT
    country_name,
    total_fertility_rate
  FROM
    `bigquery-public-data.census_bureau_international.age_specific_fertility_rates`
  WHERE
    year = 2022
    AND total_fertility_rate < 2.1 ) age
INNER JOIN (
  SELECT
    country_name,
    growth_rate
  FROM
    `bigquery-public-data.census_bureau_international.birth_death_growth_rates`
  WHERE
    year = 2022 ) birth
ON
  age.country_name = birth.country_name
ORDER BY
  1 ASC,
  2 ASC;
  
  
  
  Output:
  
 [{
  "country_name": "Albania",
  "total_fertility_rate": "1.5406",
  "growth_rate": "0.217"
}, {
   
   .....]
  
  -------------------------------------------------------------------------------
  
