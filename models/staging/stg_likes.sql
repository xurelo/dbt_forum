{{ config(materialized='view') }}

with raw as (
    select * from {{ ref('raw_likes') }}
)

select
    id as like_id,
    post_id,
    user_id as liker_id,
    cast(created_at as timestamp) as created_at
from raw r
where exists (
  select 1 from {{ ref('stg_posts') }} p where p.post_id = r.post_id
)
and exists (
  select 1 from {{ ref('stg_users') }} u where u.user_id = r.user_id
)
