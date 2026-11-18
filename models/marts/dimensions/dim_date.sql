
with date_spine as (

    select
        unnest(
            generate_series(
                date '2023-01-01',
                date '2025-12-31',
                interval '1 day'
            )
        )::date as date_day

),

final as (

    select
        cast(strftime(date_day, '%Y%m%d') as integer) as date_key,

        date_day,

        extract(year from date_day)::integer as year,

        extract(quarter from date_day)::integer as quarter,

        extract(month from date_day)::integer as month,

        strftime(date_day, '%B') as month_name,

        extract(day from date_day)::integer as day,

        extract(isodow from date_day)::integer as day_of_week,

        strftime(date_day, '%A') as day_name,

        case
            when extract(isodow from date_day) in (6, 7)
                then true
            else false
        end as is_weekend

    from date_spine

)

select *
from final
