-- Retrieve the city with the shortest name and the city with the longest name,
-- along with their lengths. If there is a tie, return the city that comes first alphabetically.

-- Longest city name
SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
LIMIT 1;

-- Shortest city name
SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY), CITY
LIMIT 1;