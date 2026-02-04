-- post incremental data integrity test
select post_id from {{ ref('stg_posts_incremental') }} p
where not exists (
  select 1 from {{ ref('stg_users') }} u where u.user_id = p.user_id
)