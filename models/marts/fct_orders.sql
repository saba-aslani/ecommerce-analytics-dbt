{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}


with orders as (

    select * from {{ ref('stg_orders') }}

    {% if is_incremental() %}
    where ordered_at > (select max(ordered_at) from {{ this }})
    {% endif %}

),

order_items as (

    select
        order_id,
        count(*)              as item_count,
        sum(price)            as items_total,
        sum(freight_value)    as freight_total
    from {{ ref('stg_order_items') }}
    group by order_id

),

payments as (

    select
        order_id,
        sum(payment_value)    as payment_total
    from {{ ref('stg_order_payments') }}
    group by order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_status,
        orders.ordered_at,
        orders.delivered_at,
        order_items.item_count,
        order_items.items_total,
        order_items.freight_total,
        payments.payment_total
    from orders
    left join order_items on orders.order_id = order_items.order_id
    left join payments     on orders.order_id = payments.order_id

)

select * from final