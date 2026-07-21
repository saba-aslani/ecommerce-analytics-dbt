{% snapshot orders_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='check',
        check_cols=['order_status']
    )
}}

select
    order_id,
    customer_id,
    order_status,
    ordered_at
from {{ ref('stg_orders') }}

{% endsnapshot %}