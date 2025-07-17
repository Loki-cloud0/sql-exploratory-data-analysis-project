/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.
===============================================================================
*/

select 'Total Sales' as measure_name, sum(price) as measure_value
from sales
union all
select 'Quanity Sold' as measure_name, sum(quantity) as measure_value
from sales
union all
select 'Average Order Value' as measure_name, round(sum(price) / count(distinct order_number), 2) as measure_value
from sales
union all
select 'Total Nr of Orders' as measure_name, count(distinct order_number) as measure_value
from sales
union all
select 'Total Nr of Products' as measure_name, count(distinct product_key) as measure_value
from products
union all
select 'Total Nr of Customers' as measure_name, count(*) as measure_value
from customers
union all
select 'Total Customers Who Purchased' as measure_name, count(distinct customer_key) as measure_value
from sales;