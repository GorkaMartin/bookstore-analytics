select
    order_item_id,
    gross_amount,
    discount_amount,
    net_amount

from {{ ref('fact_sales') }}

where abs(
    net_amount - (gross_amount - discount_amount)
) > 0.01
