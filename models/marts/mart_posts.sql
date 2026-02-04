{{ config(materialized='table') }}

with posts as (
  select post_id, user_id, content, created_at
  from {{ ref('stg_posts') }}
),
user_counts as (
  select
    p.post_id,
    p.user_id as author_id,
    p.content,
    p.created_at,
    coalesce(l.like_count, 0) as like_count,
    coalesce(c.comment_count, 0) as comment_count
  from posts p
  left join (
    select post_id, count(*) as like_count
    from {{ ref('stg_likes') }}
    group by post_id
  ) l using (post_id)
  left join (
    select post_id, count(*) as comment_count
    from {{ ref('stg_comments') }}
    group by post_id
  ) c using (post_id)
)

select * from user_counts
