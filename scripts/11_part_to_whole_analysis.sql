/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

/*
=============================================================
-- Which categories contribute the most to the overall sales?
=============================================================
*/
select
	distinct category
	, sum(price) over ( partition by category) as total_sales
	, concat(round(((sum(price) over ( partition by category) * 100)) / sum(price) over (), 2), '%') as percent_of_total
from sales
left join products
	using(product_key)
order by total_sales desc;

/*
============================================================
-- Which customers contribute the most to the overall sales?
============================================================
*/
select
	distinct sales.customer_key
	, sum(price) over ( partition by sales.customer_key ) as total_spending
	, round(sum(price) over ( partition by sales.customer_key ) * 100 / sum(price) over(), 2) as percent_of_total
from sales
left join customers
	using(customer_key)
order by total_spending desc;


/*
===========================================================
-- Which products contribute the most to the overall sales?
===========================================================
*/
with total_sales_by_product as (
select 
	distinct product_name
	, sum(price) over ( partition by product_name ) as total_sales
from sales
left join products
	on sales.product_key = products.product_key
    ) 

select 
	product_name
	, total_sales
	, round(total_sales * 100 / sum(total_sales) over(), 2) as percent_of_total
from total_sales_by_product
order by total_sales desc;

/*
==========================================================
-- Which months contribute the most to the overall sales?
==========================================================
*/
with total_sales_by_month as (
	select 
	distinct month(order_date) as `month`
	, sum(price) over ( partition by month(order_date) ) as total_sales
from sales
where order_date != ''
    ) 

select 
	`month`
	, total_sales
	, round(total_sales * 100 / sum(total_sales) over(), 2) as percent_of_total
from total_sales_by_month
order by total_sales desc;
