-- basic comment integrity test
select comment_id from {{ ref('stg_comments') }} c
where not exists (
  select 1 from {{ ref('stg_users') }} u where u.user_id = c.commenter_id
) or not exists (
  select 1 from {{ ref('stg_posts') }} p where p.post_id = c.post_id
)