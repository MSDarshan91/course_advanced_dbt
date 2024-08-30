with

users as (
    select
        *
    from
        {{ ref('stg_bingeflix__users') }}
),

users_subscription_facts as (
    select
        user_id,
        MIN(starts_at) as first_subscription_starts_at,
        COUNT(distinct subscription_id) as count_of_subscriptions
    from
        {{ ref('stg_bingeflix__subscriptions') }}
    group by 1
),

final as (
    select
        u.user_id,
        created_at,
        phone_number,
        deleted_at,
        username,
        name,
        sex,
        email,
        birthdate,
        TRUNCATE(DATEDIFF(month, birthdate, CURRENT_DATE)/12) as current_age,
        TRUNCATE(DATEDIFF(month, birthdate, created_at)/12) as age_at_acquisition,
        region,
        country,
        usf.first_subscription_starts_at,
        usf.count_of_subscriptions
    from
        users as u
        left join users_subscription_facts as usf on u.user_id = usf.user_id
)

select * from final
