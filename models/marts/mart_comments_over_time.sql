{{ config(materialized='table') }}

with comments as (
  select post_id, created_at::date as commented_date
  from {{ ref('stg_comments') }}
),

dates as (
  select generate_series(min(commented_date), max(commented_date), interval '1 day')::date as date
  from comments
),

posts as (
  select post_id from {{ ref('stg_posts') }}
),

date_posts as (
  select d.date, p.post_id
  from dates d cross join posts p
),

comments_agg as (
  select post_id, commented_date, count(*) as comments_on_date
  from comments
  group by post_id, commented_date
)

select
  dp.date,
  dp.post_id,
  coalesce(ca.comments_on_date, 0) as comments_on_date
from date_posts dp
left join comments_agg ca
  on ca.post_id = dp.post_id and ca.commented_date = dp.date
order by dp.date, dp.post_id
