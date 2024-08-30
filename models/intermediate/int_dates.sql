with

date_spine as (

{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2019-01-01' as date)",
    end_date="cast('2030-01-01' as date)"
   )
}}
),

final as (
    select
        date_day as calendar_date,
        CAST(DATE_TRUNC('week', date_day) as DATE) as date_week,
        CAST(DATE_TRUNC('month', date_day) as DATE) as date_month,
        CAST(DATE_TRUNC('quarter', date_day) as DATE) as date_quarter,
        CAST(DATE_TRUNC('year', date_day) as DATE) as date_year,
        DAY(date_day) as day_of_month,
        YEAR(date_day) as year_num,
        QUARTER(date_day) as quarter_num,
        MONTH(date_day) as month_num
    from
        date_spine
)

select * from final
