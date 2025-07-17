/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.
===============================================================================
*/

-- Sales performance over time (monthly)
select 
	year(order_date) as year
	, month(order_date) as year
	, sum(price) as total_sales
from sales
where order_date != ''
group by year(order_date), month(order_date)
order by year(order_date), month(order_date);

-- Sales performance over time (yearly)
select 
	year(order_date) as year
	, sum(price) as total_sales
from sales
where order_date != ''
group by year(order_date)
order by year(order_date);