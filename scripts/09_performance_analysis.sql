/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

select
	product_name
	, `year`
	, total_sales
	, avg(total_sales) over(partition by product_name) as avg_sales
	, total_sales - avg(total_sales) over(partition by product_name) as diff_from_avg
	, case 
	when (total_sales - avg(total_sales) over(partition by product_name)) > 0 then 'Above avg'
	when (total_sales - avg(total_sales) over(partition by product_name)) < 0 then 'Below avg'
	when (total_sales - avg(total_sales) over(partition by product_name)) = 0 then 'Avg'
	end as threshold1
	, ifnull(lag(total_sales) over(partition by product_name order by `year`), 0) as prev_yr_sales
	, ifnull(total_sales - lag(total_sales) over(partition by product_name order by `year`), 0) as diff_from_prev_yr
	, case
	when total_sales - lag(total_sales) over(partition by product_name order by `year`) > 0 then 'Inc'
	when total_sales - lag(total_sales) over(partition by product_name order by `year`) < 0 then 'Dec'
end as than_prev_yr
from
	(
	select
		product_name
		, year(order_date) as `year`
		, sum(price) as total_sales
	from sales
	left join products
		on sales.product_key = products.product_key
	where order_date != ''
	group by product_name, `year`
	order by product_name, `year`
    )t;