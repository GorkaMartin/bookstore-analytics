
with source as (

    select *
    from {{ ref('order_items') }}

),

renamed_and_cleaned as (

    select
        cast(order_item_id as integer) as order_item_id,

        cast(order_id as integer) as order_id,

        cast(line_number as integer) as line_number,

        cast(book_id as integer) as book_id,

        cast(quantity as integer) as quantity,

        try_cast(unit_price as decimal(10,2)) as unit_price,

        try_cast(discount_pct as decimal(5,2)) as discount_pct

    from source

)

select *
from renamed_and_cleaned
