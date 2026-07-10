-- Retrieve distinct CITY names from the STATION table where the ID is an even number.

SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;