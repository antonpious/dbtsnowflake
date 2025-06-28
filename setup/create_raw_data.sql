create database dbtsnowflake;

create schema raw;


create table customers
(
    id int,
    first_name varchar,
    last_name varchar
);

select * from raw.customers;

-- the copy doesn't take a relative name
copy into dbtsnowflake.raw.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 


create table orders
(
    id integer,
    user_id integer,
    order_date date,
    status varchar,
    _etl_loaded_at timestamp default current_timestamp
);

copy into dbtsnowflake.raw.orders(id, user_id, order_date, status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

select * from raw.orders;


create table payments
(
    id integer,
    order_id integer,
    payment_method varchar,
    status varchar,
    amount integer,
    created date,
    _batched_at timestamp default current_timestamp
);


copy into dbtsnowflake.raw.payments(id, order_id, payment_method, status, amount, created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

select * from raw.payments;