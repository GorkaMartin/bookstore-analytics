select
    order_item_id,
    gross_amount,
    discount_amount,
    net_amount

from {{ ref('fact_sales') }}

where
    gross_amount < 0
    or discount_amount < 0
    or net_amount < 0
