/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

/*================================*/
-- Find total customers by countries
select 
	country
    , count(*) as total_customers
from customers
group by country
order by total_customers desc;

/*========================*/
-- Total customers by gender
select
	gender
	, count(*) as total_customers
from customers
group by gender
order by total_customers desc;

/*======================*/
-- total prods by category
select 
	category
	, count(*) as total_prods
from products
group by category
order by total_prods desc;

/*=====================*/
-- avg cost per category
select 
	category
    , avg(cost) as avg_cost
from products
group by category
order by avg_cost desc;

/*=========================*/
-- total revenue by category
select 
	category
    , sum(price) as total_revenue
from sales
left join products
	on sales.product_key = products.product_key
group by category
order by total_revenue desc;

/*========================*/
-- total revenue by customer
select 
	customer_key
    , sum(price) as total_revenue
from sales
group by customer_key
order by total_revenue desc;

/*====================================*/
-- distribution of items sold by country
select 
	country
	, sum(quantity) as items_sold
from sales
left join customers
	on sales.customer_key = customers.customer_key
group by country
order by items_sold desc;