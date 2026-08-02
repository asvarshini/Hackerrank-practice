SQL INTERVIEW PRACTICE
======================

Question 1: Top 3 Employees With Highest Salary
------------------------------------------------

Question:
You have an Employees table:

emp_id | employee_name | salary
101    | Alice         | 95000
102    | Bob           | 87000
103    | Charlie       | 91000
104    | David         | 76000
105    | Eva           | 99000

Write a SQL query to fetch the top 3 employees with the highest salaries.

My Answer:
SELECT * FROM Employees ORDER BY salary DESC LIMIT 3;

Evaluation:
PASSED

Correct Answer:
SELECT *
FROM Employees
ORDER BY salary DESC
LIMIT 3;

Score: 1/1

Concept:
ORDER BY, DESC, LIMIT


==================================================

Question 2: Customers With More Than 3 Orders
---------------------------------------------

Question:
You have an Orders table:

order_id | customer_id | order_date
201      | 1           | 2024-12-15
202      | 2           | 2024-12-10
203      | 1           | 2024-12-21
204      | 3           | 2024-12-20
205      | 1           | 2024-12-22
206      | 2           | 2024-12-25
207      | 1           | 2024-12-27

Write a SQL query to find customers who have placed more than 3 orders in the last 30 days.

Assume today's date is 2024-12-30.

My Answer:
select count(customer_id) as total_orders
from Orders
where order_date >= now() - INTERVAL 30 DAY
group by customer_id
having total_irders >3;

Evaluation:
PARTIALLY CORRECT

What I did correctly:
- Used COUNT()
- Used WHERE for date filtering
- Used GROUP BY customer_id
- Used HAVING for filtering groups

Problems:
1. customer_id should also be selected.
2. "total_irders" is a typo. It should be "total_orders".
3. Since the question says today's date is 2024-12-30, using NOW() is not ideal.

Correct Answer:
SELECT customer_id,
       COUNT(customer_id) AS total_orders
FROM Orders
WHERE order_date >= '2024-11-30'
GROUP BY customer_id
HAVING COUNT(customer_id) > 3;

Score: 0.5/1

Concept:
COUNT(), GROUP BY, HAVING, date filtering


==================================================

Question 3: First and Last Purchase Date
-----------------------------------------

Question:
You have a Transactions table:

transaction_id | customer_id | purchase_date
301            | 1           | 2024-01-10
302            | 2           | 2024-01-12
303            | 1           | 2024-02-15
304            | 2           | 2024-02-20
305            | 1           | 2024-03-05

Write a SQL query to retrieve the first and last purchase date for each customer.

My Answer:
select customer_id,
       min(purchase_date) as first_purchase_date,
       max(purchase_date) as last_purchase_date
from Transactions
group by customer_id;

Evaluation:
PASSED

Correct Answer:
SELECT customer_id,
       MIN(purchase_date) AS first_purchase_date,
       MAX(purchase_date) AS last_purchase_date
FROM Transactions
GROUP BY customer_id;

Score: 1/1

Concept:
MIN(), MAX(), GROUP BY


==================================================

Question 4: Weekend Orders
---------------------------

Question:
You have an Orders table:

order_id | customer_id | order_date
401      | 1           | 2024-02-10
402      | 2           | 2024-02-18
403      | 3           | 2024-02-16
404      | 1           | 2024-02-21

Write a SQL query to fetch all orders that were placed on weekends
(Saturday or Sunday).

My Answer:
select * from Orders
where DAYOFWEEK(order_date) IN (1,7);

Evaluation:
PASSED

Correct Answer:
SELECT *
FROM Orders
WHERE DAYOFWEEK(order_date) IN (1, 7);

In MySQL:
1 = Sunday
7 = Saturday

Score: 1/1

Concept:
DAYOFWEEK(), IN, date filtering


==================================================

Question 5: Average Sales Amount by Region
-------------------------------------------

Question:
You have a Sales table:

sales_id | region | sales_amount
501      | North  | 60000
502      | South  | 70000
503      | North  | 80000
504      | West   | 90000

Write a SQL query to find the average sales amount for each region.

My Answer:
select sales_id, region, avg(sales_amount)
from Sales
group by region;

Evaluation:
PARTIALLY CORRECT

What I did correctly:
- Used AVG()
- Used GROUP BY region

Problem:
sales_id is included in SELECT but is not included in GROUP BY
and is not an aggregate.

Correct Answer:
SELECT region,
       AVG(sales_amount) AS average_sales
FROM Sales
GROUP BY region;

Score: 0.5/1

Concept:
AVG(), GROUP BY


==================================================

Question 6: Employee Name and Department Name
----------------------------------------------

Question:
You have two tables.

Employees:

emp_id | employee_name | department_id
1      | Alice         | 10
2      | Bob           | 20
3      | Charlie       | 10
4      | David         | 30

Departments:

department_id | department_name
10            | IT
20            | HR
30            | Finance

Write a SQL query to display each employee's name along with
their department name.

My Answer:
select e.employee_name, d.department_name
from Employees e
join Departments d
on e.department_id = d.department_id;

Evaluation:
PASSED

Correct Answer:
SELECT e.employee_name,
       d.department_name
FROM Employees e
JOIN Departments d
ON e.department_id = d.department_id;

Score: 1/1

Concept:
INNER JOIN, table aliases, JOIN condition


==================================================

Question 7: Highest Salary in Each Department
----------------------------------------------

Question:
You have an Employees table:

emp_id | employee_name | department_id | salary
1      | Alice         | 10            | 80000
2      | Bob           | 20            | 60000
3      | Charlie       | 10            | 95000
4      | David         | 30            | 70000
5      | Eva           | 20            | 85000

Find the employee(s) who have the highest salary in each department.

The query should also handle ties.

My Answer:
select * from employee_name,emp_id
from Employees
order by salary DESC
limit 1;

Evaluation:
FAILED

Problems:
1. The SQL syntax is incorrect.
2. The query finds the highest salary overall, not the highest salary
   in each department.
3. LIMIT 1 returns only one employee.
4. The question requires handling ties.

Correct Answer:
SELECT emp_id,
       employee_name,
       department_id,
       salary
FROM (
    SELECT *,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM Employees
) t
WHERE salary_rank = 1;

Score: 0/1

Concept:
GROUP-WISE MAXIMUM, RANK(), PARTITION BY, Window Functions


==================================================

Question 8: Customers Who Never Placed an Order
------------------------------------------------

Question:
You have two tables.

Customers:

customer_id | customer_name
1            | Alice
2            | Bob
3            | Charlie
4            | David

Orders:

order_id | customer_id | amount
101      | 1           | 500
102      | 1           | 300
103      | 2           | 700
104      | 3           | 200

Find all customers who have never placed an order.

My Answer:
SELECT c.customer_id, c.customer_name
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

Evaluation:
PASSED

Correct Answer:
SELECT c.customer_id,
       c.customer_name
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

Score: 1/1

Concept:
LEFT JOIN, IS NULL, finding unmatched records


==================================================

Question 9: Departments With Average Salary Greater Than 70,000
----------------------------------------------------------------

Question:
You have an Employees table:

emp_id | employee_name | department_id | salary
1      | Alice         | 10            | 80000
2      | Bob           | 10            | 60000
3      | Charlie       | 20            | 90000
4      | David         | 20            | 70000
5      | Eva           | 30            | 50000

Find the average salary of each department, but return only the
departments whose average salary is greater than 70,000.

My Answer:
select department_id, avg(salary) as avg_sal
from Employess
where avg_sal >70,000;

Evaluation:
FAILED

Problems:
1. GROUP BY department_id is missing.
2. Aggregate results cannot be filtered using WHERE.
3. HAVING should be used instead.
4. "70,000" is not valid SQL numeric syntax. Use 70000.
5. "Employess" is a spelling mistake; the table is Employees.

Correct Answer:
SELECT department_id,
       AVG(salary) AS avg_sal
FROM Employees
GROUP BY department_id
HAVING AVG(salary) > 70000;

Score: 0/1

Concept:
AVG(), GROUP BY, HAVING


==================================================

Question 10: Customers Spending More Than 1,000
------------------------------------------------

Question:
You have an Orders table:

order_id | customer_id | order_date | amount
1        | 101         | 2024-01-10  | 500
2        | 101         | 2024-02-15  | 700
3        | 102         | 2024-01-20  | 300
4        | 103         | 2024-03-01  | 900
5        | 101         | 2024-03-10  | 400

Find the total amount spent by each customer and display only
customers whose total spending is greater than 1,000.

My Answer:
select customer_id, sum(amount) as am
from Orders
where am >1000
group by customer_id;

Evaluation:
PARTIALLY CORRECT

What I did correctly:
- Used SUM()
- Used GROUP BY customer_id
- Understood that we need to filter based on total spending

Problem:
The aggregate result cannot be filtered using WHERE.
HAVING should be used.

Correct Answer:
SELECT customer_id,
       SUM(amount) AS total_amount
FROM Orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;

Score: 0.5/1

Concept:
SUM(), GROUP BY, HAVING


==================================================

Question 11: Second Highest Salary
-----------------------------------

Question:
You have an Employees table:

emp_id | employee_name | salary
1      | Alice         | 80000
2      | Bob           | 60000
3      | Charlie       | 90000
4      | David         | 70000
5      | Eva           | 85000

Find the second-highest salary from the Employees table.

Status:
PENDING

I had NOT answered this question yet.

The interview was stopped here because I asked for all
questions and answers in copy-paste format.


==================================================
INTERVIEW SCORE SO FAR
==================================================

Question 1  = 1/1
Question 2  = 0.5/1
Question 3  = 1/1
Question 4  = 1/1
Question 5  = 0.5/1
Question 6  = 1/1
Question 7  = 0/1
Question 8  = 1/1
Question 9  = 0/1
Question 10 = 0.5/1
Question 11 = Pending

Total so far = 6.5/10
Percentage = 65%

IMPORTANT:
The final interview result has NOT been decided yet because
Question 11 and any remaining questions are still pending.


==================================================
MAIN TOPICS I NEED TO IMPROVE
==================================================

1. WHERE vs HAVING

WHERE:
Used to filter individual rows before grouping.

HAVING:
Used to filter groups after GROUP BY.

Example:

SELECT department_id,
       AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id
HAVING AVG(salary) > 70000;


2. GROUP BY

When using aggregate functions such as:

COUNT()
SUM()
AVG()
MIN()
MAX()

and we want the result for each group, we generally need GROUP BY.

Example:

SELECT department_id,
       AVG(salary)
FROM Employees
GROUP BY department_id;


3. GROUP-WISE MAXIMUM

Finding the highest value overall is different from finding
the highest value in each group.

Overall highest:

SELECT MAX(salary)
FROM Employees;

Highest salary in each department requires grouping or
window functions.


4. WINDOW FUNCTIONS

Important functions to learn:

RANK()
DENSE_RANK()
ROW_NUMBER()

Example:

RANK() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
)


5. JOINS

Important JOIN types to practice:

INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL OUTER JOIN


==================================================
CURRENT INTERVIEW PERFORMANCE
==================================================

Strong Areas:
- Basic SELECT queries
- ORDER BY
- LIMIT
- MIN()
- MAX()
- JOIN
- LEFT JOIN
- NULL filtering
- Basic GROUP BY
- Basic aggregate functions

Needs Improvement:
- WHERE vs HAVING
- GROUP BY with aggregate functions
- Group-wise maximum
- Window functions
- Handling ties
- More advanced SQL problems