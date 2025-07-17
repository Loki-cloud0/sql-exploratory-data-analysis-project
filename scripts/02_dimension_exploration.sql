/*
===============================================================================
Dimensions (Categories) Exploration
===============================================================================
Purpose:
    - To explore the categorical fields.
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
select 
	distinct country
from customers
order by country;

-- Retrieve a list of unique categories, subcategories, and products
select 
	distinct category
    , subcategory
    , product_name
from products
order by 
	category
    , subcategory
    , product_name;