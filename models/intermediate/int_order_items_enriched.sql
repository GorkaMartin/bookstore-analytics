
with order_items as (

    select *
    from {{ ref('stg_order_items') }}

),

orders as (

    select *
    from {{ ref('stg_orders') }}

),

joined as (

    select
        oi.order_item_id,
        oi.order_id,
        oi.line_number,
        oi.book_id,

        o.customer_id,
        o.order_date,
        o.order_status,
        o.sales_channel,
        o.shipping_city,
        o.shipping_cost,

        oi.quantity,
        oi.unit_price,
        oi.discount_pct

    from order_items oi

    left join orders o
        on oi.order_id = o.order_id

),

calculated as (

    select
        *,

        cast(
            quantity * unit_price
            as decimal(12,2)
        ) as gross_amount,

        cast(
            quantity * unit_price * discount_pct / 100
            as decimal(12,2)
        ) as discount_amount,

        cast(
            quantity * unit_price
            * (1 - discount_pct / 100)
            as decimal(12,2)
        ) as net_amount

    from joined

)

select *
from calculated
