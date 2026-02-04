{{ config(materialized='table') }}

WITH post_user AS (
  SELECT p.post_id,
         p.content,
         u.user_id,
         u.username
  FROM {{ref("stg_posts")}} as p
  JOIN {{ref("stg_users")}} as u
  ON p.user_id = u.user_id
)

SELECT
  rat.post_id,
  pu.content,
  pu.user_id as created_by_user,
  pu.username as created_by_username,
  {{ get_elems_count( 'stg_post_ratings','rating') }}
FROM {{ref('stg_post_ratings')}} rat
JOIN post_user as pu
ON rat.post_id = pu.post_id
GROUP BY 1, 2, 3, 4