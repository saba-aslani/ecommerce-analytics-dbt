with source as (
    select *
    from {{ source('olist', 'order_reviews') }}

),
renamed as (
    select 
        review_id,
        order_id,
        review_score as score,
        review_comment_title as comment_title,
        cast(review_creation_date as timestamp) as creation_date,
        cast(review_answer_timestamp as timestamp) as answer_timestamp

    from source

)

select *
from renamed