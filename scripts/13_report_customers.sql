/*======================================================================================================
1. CUSTOMER REPORT
========================================================================================================
Purpose:
  - This report consolidates key customer metrics and behaviors
  
Highlights:
  1. Gather only the essential fields to form the base query for efficent use of memory
  2. Segment customers into tiers (VIPs, Regular, New) and age groups
  3. Aggregate customer-level metrics
	- total orders
    - total sales
    - total quantity purchased
    - total products
	- customer tenure (lifespan)
  4. Calculate KPIs
	- recency (days or months since last order)
	- average order value
    - average monthly spend
======================================================================================================*/

create or replace view report_customers as 
with base_query as (
/*==========================================================
1. Base_query: retireves all necessary columns from tables
==========================================================*/

	select 
		order_number
		, product_key
		, order_date
		, sales_amount
		, quantity
		, price
		, sales.customer_key
		, customer_id
		, concat(first_name, ' ', last_name) as name
		, country
		, gender
		, timestampdiff(year, birthdate, curdate()) as age
	from sales
	join customers
	on sales.customer_key = customers.customer_key
	where order_date != '' and birthdate != ''
)

, customer_aggregation as (
/*==========================================================
2. Aggregates customer level_metrics
==========================================================*/

	select 
		customer_key
		, name
        , age
		, count(distinct order_number) as total_orders
		, count(distinct product_key) as total_products
		, max(order_date) as last_order_date
		, timestampdiff(month, min(order_date), max(order_date)) as lifespan
		, sum(quantity) as total_units
		, sum(price) as total_spent
	from base_query
	group by customer_key, name, age
    )

-- putting all analysis into a single table
select 
	customer_key
	, name
    , age
-- segmenting age into categories
    , case
		when age < 20 then 'Under 20'
        when age < 30 then 'Under 30'
        when age < 40 then 'Under 40'
        when age < 50 then 'Under 50'
        else '50+'
        end as age_cagetory
-- segmenting customers into tiers: VIP, Regular, New
    , case
		when ((lifespan / 365) >= 1) and (total_spent > 5000) then 'VIP'
		when ((lifespan / 365) >= 1) and (total_spent <= 5000) then 'Regular'
		else 'New'
		end as tier
	, total_orders
	, total_products
	, timestampdiff(month, last_order_date, curdate()) as recency
	, lifespan
	, total_units
	, total_spent
    , case when total_orders = 0 then 0
		else round(total_spent / total_orders, 2)
        end as avg_order_value
	, case when lifespan = 0 then total_spent
		else round(total_spent / lifespan, 2)
        end as avg_monthly_spending
from customer_aggregation;