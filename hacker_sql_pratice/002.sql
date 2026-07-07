-- Retrieve the NAME of all cities in the USA with a population greater than 120000.

SELECT NAME
FROM CITY
WHERE POPULATION > 120000
  AND COUNTRYCODE = 'USA';