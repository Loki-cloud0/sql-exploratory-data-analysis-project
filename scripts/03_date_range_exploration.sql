/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
select 
	min(order_date) as first_order_date
    , max(order_date) as last_order_date
    , timestampdiff(month, min(order_date), max(order_date)) as order_range_months
from sales
where order_date != '';

-- Find the youngest and oldest customer based on birthdate
select 
	timestampdiff(year, min(birthdate), curdate()) as oldest_customer
    , timestampdiff(year, max(birthdate), curdate()) as youngest_customer
from customers
where birthdate != ''