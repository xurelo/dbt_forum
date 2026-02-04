{% snapshot posts_snapshot %}

{{ config (target_schema="analytics_snapshot",
           strategy="timestamp",
           updated_at="updated_at",
           unique_key="id"
           ) }}

select * from {{ref("raw_posts")}}


{% endsnapshot %}