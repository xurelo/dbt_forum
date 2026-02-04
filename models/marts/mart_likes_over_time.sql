{{ config(materialized='table') }}

with likes as (
  select post_id, created_at::date as liked_date
  from {{ ref('stg_likes') }}
),

dates as (
  select generate_series(min(liked_date), max(liked_date), interval '1 day')::date as date
  from likes
),

posts as (
  select post_id from {{ ref('stg_posts') }}
),

date_posts as (
  select d.date, p.post_id
  from dates d cross join posts p
),

likes_agg as (
  select post_id, liked_date, count(*) as likes_on_date
  from likes
  group by post_id, liked_date
)

select
  dp.date,
  dp.post_id,
  coalesce(la.likes_on_date, 0) as likes_on_date
from date_posts dp
left join likes_agg la
  on la.post_id = dp.post_id and la.liked_date = dp.date
order by dp.date, dp.post_id
