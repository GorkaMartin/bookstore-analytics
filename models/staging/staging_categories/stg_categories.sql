
with source as (

    select *
    from {{ ref('categories') }}

),

renamed_and_cleaned as (

    select
        cast(category_id as integer) as category_id,

        nullif(trim(category_name), '') as category_name,

        nullif(trim(category_description), '') as category_description

    from source

)

select *
from renamed_and_cleaned
