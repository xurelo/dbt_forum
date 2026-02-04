{{ config(materialized='incremental',
          incremental_strategy='merge',
          unique_key='post_id') }}

with raw as (
    select * from {{ ref('raw_posts') }}
),
transformed as (
  select
      id as post_id,
      user_id,
      content,
      cast(created_at as timestamp) as created_at,
      cast(updated_at as timestamp) as updated_at,
      deleted
  from raw r
  where exists (
    select 1 from {{ ref('stg_users') }} u where u.user_id = r.user_id
  )
)
select * from transformed
{% if is_incremental() %}
WHERE updated_at >= (SELECT MAX(updated_at) from {{this}})
{% endif %}