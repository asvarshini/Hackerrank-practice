-- Retrieve the names of employees whose monthly salary is greater than 2000 
-- and who have worked for less than 10 months. Sort the results by employee_id in ascending order.

SELECT name
FROM Employee
WHERE salary > 2000
  AND months < 10
ORDER BY employee_id ASC;