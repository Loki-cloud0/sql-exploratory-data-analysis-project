/*=====================================================================================================
1. Product report
=======================================================================================================
Purpose:
  - This report consolidates key PRODUCT metrics and behaviors
  
Highlights:
  1. Gather only the essential fields like product_key, product_name, cost and so on.
  2. Segment products by revenue to identify High-, Mid- and Low-performers into tiers (VIPs, Regular, New) and age groups
  3. Aggregate product-level metrics
	- total orders
    - total sales
    - total quantity purchased
    - total customers (unique)
	- lifespan
  4. Calculate KPIs
	- recency (days or months since last order)
	- average order value (AOV)
    - average monthly spend
=====================================================================================================*/


create or replace view report_products as
with base_query as (
--   1. retrieving only the essential fields
	select
	product_name
	, category
	, cost
	, order_number
	, sales.product_key
	, customer_key
	, order_date
	, quantity
	, price
	from sales
	left join products
		on sales.product_key = products.product_key
	where order_date != ''
    )

, product_aggregate as (
-- 2. Segment products by revenue to identify High-, Mid- and Low-performers
-- 3. Aggregate product-level metrics
	select
	product_key
	, product_name
	, category
	, cost
	, count(distinct order_number) as total_orders
	, sum(price) as total_sales
    , case 
		when sum(price) < 50000 then 'Low'
		when sum(price) < 100000 then 'Mid'
        else 'High'
        end as revenue_performance
	, sum(quantity) as total_units_sold
	, count(distinct customer_key) as total_customers
    , max(order_date) as last_order_date
	, timestampdiff(month, min(order_date), max(order_date)) as lifespan
	from base_query
	group by product_key
			, product_name
			, category
			, cost
            )
            
select *
, timestampdiff(month, last_order_date, curdate()) as recency
, case
	when total_orders = 0 then 0
    else round(total_sales / total_orders)
    end as avg_order_value
, case
	when lifespan = 0 then total_sales
    else round(total_sales / lifespan)
    end as avg_monthly_sales
from product_aggregate;