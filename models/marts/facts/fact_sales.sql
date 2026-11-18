
with order_items as (

    select *
    from {{ ref('int_order_items_enriched') }}

),

customers as (

    select *
    from {{ ref('dim_customers') }}

),

books as (

    select *
    from {{ ref('dim_books') }}

),

dates as (

    select *
    from {{ ref('dim_date') }}

),

final as (

    select
        -- Identificadores de la línea y del pedido
        O.order_item_id,
        O.order_id,
        O.line_number,

        -- Claves de las dimensiones
        C.customer_key,
        B.book_key,
        D.date_key,

        -- Contexto del pedido
        O.order_status,
        O.sales_channel,
        O.shipping_city,

        -- Métricas
        O.quantity,
        O.unit_price,
        O.gross_amount,
        O.discount_amount,
        O.net_amount

    from order_items O

    left join customers C
        on O.customer_id = C.customer_id

    left join books B
        on O.book_id = B.book_id

    left join dates D
        on O.order_date = D.date_day

)

select *
from final
