with

stores as (
    select * from {{ source('sales', 'stores')}}
),

-- location is a keyword don't use that 
locations as (
    select 
    ---- ids
    id as location_id,
    -- name
    name as location_name,

    ---- rate
    tax_rate,

    --- truncate timestamp
    {{ dbt.date_trunc('day', 'opened_at') }}  as opened_date

    from stores
)

select * from locations
