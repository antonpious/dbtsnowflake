with

order_items as (
    select * from {{ ref('prodraw_order_items__stag_order_items') }}

),

orders as(
    select * from {{ ref('prodraw_orders__stag_orders') }}
),

products as (
    select * from {{ ref('prodraw_products__stag_products') }}
),

supplies as (
    select * from {{ ref('prodraw_supplies__stag_supplies') }}
),

order_supplies_summary  as (
    select 
        product_id,
        sum(supply_cost) as supply_cost
    from supplies
    group by product_id
),

-- there is no need for left join
-- as all records have its corresponding records
-- in other tables.

shop_aggregate as (
    select
        order_items.*,
        orders.ordered_at,

        products.product_name,
        products.product_price,
        products.is_food_item,
        products.is_drink_item,

        order_supplies_summary.supply_cost
    from order_items
    left join orders 
        on order_items.order_id = orders.order_id
    left join products 
        on order_items.product_id = products.product_id
    left join order_supplies_summary
        on order_items.product_id = order_supplies_summary.product_id

)

select * from shop_aggregate



