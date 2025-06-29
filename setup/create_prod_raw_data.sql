-- This has the full production data

create schema prodraw;



create table customers
(
    id varchar,
    name varchar
);

copy into dbtsnowflake.prodraw.customers(id, name)
from 's3://dbt-tutorial-public/long_term_dataset/raw_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
); 

select * from customers limit 10;

drop table raw_orders;

create table orders
(
    id varchar,
    customer varchar,
    ordered_at date,
    store_id text,
    subtotal integer,
    tax_paid integer,
    order_total integer
);

copy into dbtsnowflake.prodraw.orders(id, customer, ordered_at, store_id, subtotal, tax_paid, order_total)
from 's3://dbt-tutorial-public/long_term_dataset/raw_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

select * from orders limit 10;


drop table raw_order_items;

create table order_items(
    id varchar,
    order_id varchar,
    sku varchar
);


copy into dbtsnowflake.prodraw.order_items(id, order_id, sku)
from 's3://dbt-tutorial-public/long_term_dataset/raw_order_items.csv'
file_format = (
    type = 'CSV',
    field_delimiter = ','
    skip_header = 1
);


select * from order_items limit 10;


/*
products
(sku text, name text, type text, price int, description text)
s3://dbt-tutorial-public/long_term_dataset/raw_products.csv
*/


drop table raw_products;

create table products( 
    sku varchar,
    name varchar,
    type varchar,
    price int,
    description varchar
);

copy into dbtsnowflake.prodraw.products (sku, name, type, price, description)
from 's3://dbt-tutorial-public/long_term_dataset/raw_products.csv'
file_format = (
    type ='CSV',
    field_delimiter = ','
    skip_header = 1
);


/*
supplies
(id text, name text, cost int, perishable boolean, sku text)
s3://dbt-tutorial-public/long_term_dataset/raw_supplies.csv
*/


select * from products limit 10;

create table supplies(
    id varchar,
    name varchar,
    cost integer,
    perishable boolean,
    sku varchar
);


copy into dbtsnowflake.prodraw.supplies(id, name, cost, perishable, sku)
from 's3://dbt-tutorial-public/long_term_dataset/raw_supplies.csv'
file_format = (
    type = 'CSV',
    field_delimiter = ','
    skip_header = 1  
);




/*
raw_stores
(id text, name text, opened_at datetime, tax_rate float)
s3://dbt-tutorial-public/long_term_dataset/raw_stores.csv
*/

create table stores(
    id varchar,
    name varchar,
    opened_at date,
    tax_rate float
);


copy into dbtsnowflake.prodraw.stores( id, name, opened_at, tax_rate)
from 's3://dbt-tutorial-public/long_term_dataset/raw_stores.csv'
file_format = (
    type = 'CSV',
    field_delimiter = ','
    skip_header = 1
);

select * from stores limit 10;