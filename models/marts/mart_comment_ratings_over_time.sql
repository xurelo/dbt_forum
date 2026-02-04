{{ config(materialized ='table')}}

SELECT rat.comment_id,
    com.content,
    com.commenter_id as created_by_user,
    {{ get_elems_count ('stg_comment_ratings', 'rating') }}
FROM {{ ref("stg_comment_ratings") }} rat
JOIN {{ ref("stg_comments")}} com
ON com.comment_id = rat.comment_id
GROUP BY 1, 2, 3