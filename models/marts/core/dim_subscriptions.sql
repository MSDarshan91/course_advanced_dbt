with

final as (
    select
        s.subscription_id,
        s.subscription_plan_id,
        s.user_id,
        s.starts_at,
        s.ends_at,
        sp.plan_name,
        sp.pricing,
        sp.payment_period as billing_period
    from
        {{ ref('stg_bingeflix__subscriptions') }} as s
        left join {{ ref('stg_bingeflix__subscription_plans') }} as sp
            on s.subscription_plan_id = sp.subscription_plan_id
)

select * from final
