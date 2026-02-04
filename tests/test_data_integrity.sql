-- basic data integrity test
select post_id from {{ ref('stg_posts') }} p
where not exists (
  select 1 from {{ ref('stg_users') }} u where u.user_id = p.user_id
)