{{ config(materialized='view') }}

with raw as (
  select * from {{ ref('raw_comment_ratings') }}
)

select
  id as rating_id,
  comment_id,
  user_id as rater_id,
  rating,
  cast(created_at as timestamp) as created_at
from raw
