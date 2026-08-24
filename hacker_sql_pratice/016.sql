# Nth Highest Salary

-- Question:
-- Find the second highest distinct salary from the Employee table.

-- Method 1: Using Subquery
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);


-- Method 2: Using DENSE_RANK()
SELECT salary AS SecondHighestSalary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS `rank`
    FROM Employee
) AS ranked
WHERE `rank` = 2;


-- Method 3: Using DISTINCT, ORDER BY, and LIMIT
SELECT DISTINCT salary AS SecondHighestSalary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


-- Method 4: Using MAX() and DISTINCT
SELECT MAX(salary) AS SecondHighestSalary
FROM (
    SELECT DISTINCT salary
    FROM Employee
    WHERE salary < (
        SELECT MAX(salary)
        FROM Employee
    )
) AS s;


-- 3rd Highest Salary: Using DENSE_RANK()
SELECT salary AS ThirdHighestSalary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS `rank`
    FROM Employee
) AS ranked
WHERE `rank` = 3;


-- 3rd Highest Salary: Using LIMIT and OFFSET
SELECT DISTINCT salary AS ThirdHighestSalary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;


-- General Pattern: Nth Highest Salary Using DENSE_RANK()
SELECT salary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS `rank`
    FROM Employee
) AS ranked
WHERE `rank` = N;


-- General Pattern: Nth Highest Salary Using LIMIT
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET N - 1;