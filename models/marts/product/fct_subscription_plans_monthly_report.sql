with subscriptions_monthly as (

    select

        subscription_plan_id,
        plan_name,
        date_trunc('month', starts_at) as subscription_month,
        count(distinct subscription_id) as total_subscriptions_per_month

    from {{ ref('dim_subscriptions') }}

    group by
        subscription_plan_id,
        plan_name,
        subscription_month
)

select

    {{ dbt_utils.generate_surrogate_key(['subscription_plan_id', 'subscription_month']) }} as surrogate_key,
    subscription_plan_id,
    plan_name,
    subscription_month,
    total_subscriptions_per_month,
    {{
        rolling_aggregation_n_periods(
            'total_subscriptions_per_month',
            'subscription_plan_id',
            'subscription_month',
            6,
            'avg',
        )
    }}

from subscriptions_monthly
