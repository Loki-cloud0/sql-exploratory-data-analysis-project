/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Retrieve a list of all tables in the database
select 
	table_catalog
    , table_schema
    , table_name
    , table_type
FROM information_schema.tables;

-- Retrieve all columns for table 'customers'
select
	column_name
    , data_type
    , is_nullable
    , character_maximum_length
from information_schema.columns
where table_name = 'customers';

-- Retrieve all columns for table 'products'
select
	column_name
    , data_type
    , is_nullable
    , character_maximum_length
from information_schema.columns
where table_name = 'products';

-- Retrieve all columns for table 'sales'
select
	column_name
    , data_type
    , is_nullable
    , character_maximum_length
from information_schema.columns
where table_name = 'sales';