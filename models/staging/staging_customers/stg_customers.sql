
with source as (

    select *
    from {{ ref('customers') }}

),

renamed_and_cleaned as (

    select
        cast(customer_id as integer) as customer_id,

        nullif(trim(first_name), '') as first_name,

        nullif(trim(last_name), '') as last_name,

        lower(nullif(trim(email), '')) as email,

        nullif(trim(phone), '') as phone,

        nullif(trim(city), '') as city,

        nullif(trim(region), '') as region,

        nullif(trim(country), '') as country,

        try_cast(signup_date as date) as signup_date

    from source

)

select *
from renamed_and_cleaned
