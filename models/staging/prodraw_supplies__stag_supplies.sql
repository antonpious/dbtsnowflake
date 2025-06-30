with

source as (
    select * from {{ source('sales','supplies') }}

),

supplies as (
    select
    {{ dbt_utils.generate_surrogate_key(['id','sku']) }} as supply_uuid, 
    id as supply_id,
    sku as product_id,

    {{ cents_to_dollars('cost')}} as supply_cost,
    name as supply_name,
    perishable as is_perishable_supply
    from source
)

select * from supplies
