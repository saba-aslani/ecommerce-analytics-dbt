with source as (

    select * 
    from {{ source('olist', 'customers') }}

),

renamed as (

    select 
        customer_id,
        customer_unique_id,
        cast(customer_zip_code_prefix as varchar(5)) as zip_code_prefix,
        customer_city as city,
        customer_state as state
        
    from source
)

select *
from renamed