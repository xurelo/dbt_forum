{{ config(materialized='view') }}

with raw as (
    select * from {{ ref('raw_users') }}
)

select
    id as user_id,
    username,
    email,
    cast(confirmed as boolean) as confirmed,
    cast(created_at as timestamp) as created_at,
    cast(updated_at as timestamp) as updated_at,
    deleted
from raw
