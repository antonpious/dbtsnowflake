with

customers as (

    select * from {{ ref('prodraw_customers__stag_customers') }}

),

orders as (

    select * from {{ ref('dm_orders') }}

),

customer_orders_summary as (

    select
        orders.customer_id,

        count(distinct orders.order_id) as count_lifetime_orders,
        count(distinct orders.order_id) > 1 as is_repeat_buyer,
        min(orders.ordered_at) as first_ordered_at,
        max(orders.ordered_at) as last_ordered_at,
        sum(orders.subtotal) as lifetime_spend_pretax,
        sum(orders.tax_paid) as lifetime_tax_paid,
        sum(orders.order_total) as lifetime_spend

    from orders

    group by orders.customer_id

),

customer_orders_aggregate as (

    select
        customers.*,

        customer_orders_summary.count_lifetime_orders,
        customer_orders_summary.first_ordered_at,
        customer_orders_summary.last_ordered_at,
        customer_orders_summary.lifetime_spend_pretax,
        customer_orders_summary.lifetime_tax_paid,
        customer_orders_summary.lifetime_spend,

        case
            when customer_orders_summary.is_repeat_buyer then 'returning'
            else 'new'
        end as customer_type

    from customers

    join customer_orders_summary
        on customers.customer_id = customer_orders_summary.customer_id

)
-- we can't put a semi colon at the end
-- it gives a compilation error
select * from customer_orders_aggregate