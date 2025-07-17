/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/

with cost_segment as (
	select 
		product_name
		, cost
		, case 	
			when cost < 100 then 'Below 100'
			when cost <= 500 then '100 to 500'
			when cost <= 1000 then '501 to 1000'
			else 'Above 1000' 
			end as segment
	from products
    )
    
select 
	distinct segment
	, count(product_name) over ( partition by segment ) as total_products
from cost_segment
order by total_products desc;