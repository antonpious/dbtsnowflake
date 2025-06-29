-- copy data from raw customers table
-- into staging customers table
-- by renaming the columns

with
source as (

    select * from {{ source('sales', 'customers')}}

),

renamed as (
    select 
        ----- id
        id as customer_id,
        ----- name
        name as customer_name
    from source
)

select * from renamed

