/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.
===============================================================================
*/

-- 5 products with highest revenue (by revenue)
select
product_name
, sum(price) as revenue
from sales
left join products
	on sales.product_key = products.product_key
group by product_name
order by revenue desc
limit 5;

-- Worst 5 performing products (by revenue)
select 
product_name
, count(quantity) as items_sold
, sum(price) as revenue
, sum(price) - (sum(quantity * cost)) as profit
from sales
left join products
	on sales.product_key = products.product_key
group by product_name
order by profit desc; 

-- Top 10 customers by revenue
select 
first_name
, last_name
, sum(price) as revenue
from sales
left join customers
	on sales.customer_key = customers.customer_key
group by first_name, last_name
order by revenue desc
limit 10;