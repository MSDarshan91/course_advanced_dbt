{{
    config(
        materialized='incremental',
        unique_key='event_id'
    )
}}

with source as (

    select * from {{ source('bingeflix', 'events') }}

    {% if is_incremental() %}
    where created_at > (select dateadd('day', -3, max(created_at)) from {{ this }})
    {% endif %}

),


renamed as (

    select
        session_id,
        created_at,
        user_id,
        event_name,
        event_id

    from source

)

select * from renamed
