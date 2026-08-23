-- For each date, find the number of unique products sold and list the unique products in alphabetical order, separated by commas.
# Write your MySQL query statement below
select sell_date,count(Distinct product) as num_sold,
group_concat(distinct product order by product SEPARATOR ',') as products
from Activities
group by sell_date
order by sell_date;