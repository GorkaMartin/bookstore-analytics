
with source as (

    select *
    from {{ ref('books') }}

),

renamed_and_cleaned as (

    select
        cast(book_id as integer) as book_id,

        nullif(trim(title), '') as title,

        cast(author_id as integer) as author_id,

        cast(category_id as integer) as category_id,

        try_cast(publication_year as integer) as publication_year,

        try_cast(list_price as decimal(10,2)) as list_price,

        cast(isbn as varchar) as isbn,

        lower(nullif(trim(language), '')) as language

    from source

)

select *
from renamed_and_cleaned
