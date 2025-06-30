with

source as (

    select * from {{ source('sales', 'order_items') }}

),

order_items as (

    select

        ----------  ids
        id as order_item_id,
        order_id,
        sku as product_id

    from source

)

select * from order_items
