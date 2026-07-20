with products as (

    select * from {{ ref('stg_products') }}

),

categories as (

    select * from {{ ref('stg_product_categories') }}

)

select
    products.product_id,
    products.category_name,
    categories.category_name_english,
    products.weight_g,
    products.length_cm,
    products.height_cm,
    products.width_cm

from products
left join categories
    on products.category_name = categories.category_name