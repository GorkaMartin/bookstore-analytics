
with source as (

    select *
    from {{ ref('orders') }}

),

renamed_and_cleaned as (

    select
        cast(order_id as integer) as order_id,

        cast(customer_id as integer) as customer_id,

        try_cast(order_date as date) as order_date,

        lower(nullif(trim(order_status), '')) as order_status,

        lower(nullif(trim(sales_channel), '')) as sales_channel,

        nullif(trim(shipping_city), '') as shipping_city,

        try_cast(shipping_cost as decimal(10,2)) as shipping_cost

    from source

)

select *
from renamed_and_cleaned
