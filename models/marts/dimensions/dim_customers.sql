
with customers as (

    select *
    from {{ ref('stg_customers') }}

),

final as (

    select
        {{ generate_surrogate_key('customer_id') }} as customer_key,

        customer_id,

        first_name,
        last_name,
        email,
        phone,
        city,
        region,
        country,
        signup_date

    from customers

)

select *
from final
