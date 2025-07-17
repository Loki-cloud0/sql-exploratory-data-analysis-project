/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
select
	`year`
	, `month`
	, total_sales
	, sum(total_sales) over( partition by `year` order by `year`, `month` ) as running_total
	, round(avg_sales, 2) as avg_sales
	, round(avg(avg_sales) over( partition by `year` order by `year`, `month` ), 2) as moving_avg
from (
	select
	year(order_date) as `year`
    , month(order_date) as `month`
	, sum(price) as total_sales
    , avg(price) as avg_sales
	from sales
	where order_date != '' or order_date is null
	group by year(order_date), month(order_date)
	order by year(order_date), month(order_date)) t;
