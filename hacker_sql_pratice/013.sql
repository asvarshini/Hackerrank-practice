# Department Top Three Salaries

## Question

Write a SQL query to find the employees who earn the top 3 highest unique salaries in each department. Return the Department name, Employee name, and Salary.

---

# Solution 1: Using Subquery

sql
SELECT Department, Employee, Salary
FROM (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY d.id
            ORDER BY e.salary DESC
        ) AS `rank`
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id
) AS ranked
WHERE `rank` <= 3;


# solution 2: using ctc

WITH ranked AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY d.id
            ORDER BY e.salary DESC
        ) AS `rank`
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id
)
SELECT Department, Employee, Salary
FROM ranked
WHERE `rank` <= 3;
