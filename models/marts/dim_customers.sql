with customers as (

    select * from {{ ref('stg_customers') }}

)

select
    customer_unique_id,
    min(customer_id)     as customer_id,
    max(city)            as city,
    max(state)           as state,
    max(zip_code_prefix) as zip_code_prefix

from customers
group by customer_unique_id