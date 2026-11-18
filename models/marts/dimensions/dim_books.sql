
with books as (

    select *
    from {{ ref('stg_books') }}

),

authors as (

    select *
    from {{ ref('stg_authors') }}

),

categories as (

    select *
    from {{ ref('stg_categories') }}

),

books_enriched as (

    select
        b.book_id,
        b.title,
        b.isbn,
        b.publication_year,
        b.list_price,
        b.language,

        b.author_id,
        a.author_name,
        a.country as author_country,
        a.birth_year as author_birth_year,

        b.category_id,
        c.category_name,
        c.category_description

    from books b

    left join authors a
        on b.author_id = a.author_id

    left join categories c
        on b.category_id = c.category_id

),

final as (

    select
        {{ generate_surrogate_key('book_id') }} as book_key,
        *
    from books_enriched

)

select *
from final
