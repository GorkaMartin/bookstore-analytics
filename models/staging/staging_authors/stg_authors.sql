
with source as (

    select *
    from {{ ref('authors') }}

),

renamed_and_cleaned as (

    select
        cast(author_id as integer) as author_id,

        nullif(trim(author_name), '') as author_name,

        nullif(trim(country), '') as country,

        try_cast(birth_year as integer) as birth_year

    from source

)

select *
from renamed_and_cleaned
