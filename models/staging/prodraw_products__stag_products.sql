with 

source as (
    select * from {{ source('sales', 'products') }}
),

products as (
    select 
        sku as product_id,
        name as product_name,
        type as product_type,
        -- make sure that the column name is quoted
        {{ cents_to_dollars('price') }} as product_price,
        description as product_description,
        coalesce(type = 'jaffle', false) as is_food_item,
        coalesce(type = 'beverage', false) as is_drink_item
    from source
)


select * from products