{{ config(tags="p0") }}


-- This model is created following the dbt MRR playbook: https://www.getdbt.com/blog/modeling-subscription-revenue/

with subscription_periods as (

    select * from {{ ref('int_subscription_periods') }}

),

-- Use the dates spine to generate a list of months
months as (
    select
        calendar_date as date_month
    from
        {{ ref('int_dates') }}
    where
        day_of_month = 1
),

-- Determine when given subscription plan's first and most recent months
subscribers as (
    select
        user_id,
        subscription_id,
        MIN(start_month) as first_start_month,
        MAX(end_month) as last_end_month
    from
        subscription_periods
    group by
        1, 2
),

-- Create one record per month between a subscriber's first and last month
subscriber_months as (
    select
        subscribers.user_id,
        subscribers.subscription_id,
        months.date_month
    from
        subscribers
        inner join months
            -- All months after start date
            on months.date_month >= subscribers.first_start_month
                -- and before end date
                and subscribers.last_end_month > months.date_month
),

-- Join together to create base CTE for MRR calculations
mrr_base as (
    select
        subscriber_months.date_month,
        subscriber_months.user_id,
        subscriber_months.subscription_id,
        COALESCE(subscription_periods.monthly_amount, 0.0) as mrr
    from
        subscriber_months
        left join subscription_periods
            on subscriber_months.user_id = subscription_periods.user_id
                and subscriber_months.subscription_id = subscription_periods.subscription_id
                -- The month is on or after the subscription start date...
                and subscriber_months.date_month >= subscription_periods.start_month
                -- and the month is before the subscription end date (and handle NULL case)
                and (subscriber_months.date_month < subscription_periods.end_month
                    or subscription_periods.end_month is NULL)
),

-- Calculate subscriber level MRR (monthly recurring revenue)
subscription_revenue_by_month as (
    select
        date_month,
        user_id,
        subscription_id,
        mrr > 0 as is_subscribed_current_month,

        -- Find the subscriber's first month and last subscription month
        MIN(case when is_subscribed_current_month then date_month end) over (partition by user_id, subscription_id) as first_subscription_month,
        MAX(case when is_subscribed_current_month then date_month end) over (partition by user_id, subscription_id) as last_subscription_month,
        first_subscription_month = date_month as is_first_subscription_month,
        last_subscription_month = date_month as is_last_subscription_month,
        mrr
    from
        mrr_base
),

-- Calculate subscriber level churn by month by getting row for month *after* last month of activity
subscription_churn_by_month as (
    select
        DATEADD(month, 1, date_month)::DATE as date_month,
        user_id,
        subscription_id,
        FALSE as is_subscribed_current_month,
        first_subscription_month,
        last_subscription_month,
        FALSE as is_first_subscription_month,
        FALSE as is_last_subscription_month,
        0.0::DECIMAL(18, 2) as mrr
    from
        subscription_revenue_by_month
    where
        is_last_subscription_month = TRUE
),

-- Union monthly revenue and churn CTEs
unioned as (
    select * from subscription_revenue_by_month
    union all
    select * from subscription_churn_by_month
),

-- Get prior month MRR and calculate MRR change
mrr_with_changes as (
    select
        *,

        COALESCE(
            LAG(is_subscribed_current_month) over (partition by user_id, subscription_id order by date_month),
            FALSE
        ) as is_subscribed_previous_month,

        COALESCE(
            LAG(mrr) over (partition by user_id, subscription_id order by date_month),
            0.0
        ) as previous_month_mrr_amount,

        mrr - previous_month_mrr_amount as mrr_change
    from
        unioned
),

-- Add surrogate key and classify months as new, churn, reactivation, upgrade, downgrade, or renewal
final as (
    select
        mrr_with_changes.date_month,
        mrr_with_changes.user_id,
        mrr_with_changes.subscription_id,
        subscription_periods.starts_at,
        subscription_periods.ends_at,
        subscription_periods.plan_name,
        mrr as mrr_amount,
        mrr_change,
        LEAST(mrr, previous_month_mrr_amount) as retained_mrr_amount,
        previous_month_mrr_amount,

        case
            when is_first_subscription_month then 'new'
            when not(is_subscribed_current_month) and is_subscribed_previous_month then 'churn'
            when is_subscribed_current_month and not(is_subscribed_previous_month) then 'reactivation'
            when mrr_change > 0.0 then 'upgrade'
            when mrr_change < 0.0 then 'downgrade'
            else 'renewal'
        end as change_category,

        -- Add month_retained_number for cohort analysis
        case
            when change_category = 'churn' then NULL
            else DATEDIFF('month', first_subscription_month, date_month)
        end as month_retained_number

    from
        mrr_with_changes
        left join subscription_periods
            on mrr_with_changes.user_id = subscription_periods.user_id
                and mrr_with_changes.subscription_id = subscription_periods.subscription_id
    where
        date_month <= DATE_TRUNC('month', CURRENT_DATE)
)

select
    {{ dbt_utils.generate_surrogate_key(['date_month', 'subscription_id', 'change_category']) }} as surrogate_key,
    *
from final
