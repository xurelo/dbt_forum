-- Raw PostgreSQL table definitions for the post site

create schema if not exists analytics_forum_raw;

create table if not exists analytics_forum_raw.raw_users (
  id integer primary key,
  username text not null,
  email text,
  confirmed boolean default false,
  created_at date not null
);

create table if not exists analytics_forum_raw.raw_posts (
  id integer primary key,
  user_id integer not null,
  content text,
  created_at date not null
);

create table if not exists analytics_forum_raw.raw_comments (
  id integer primary key,
  post_id integer not null,
  user_id integer not null,
  content text,
  created_at date not null
);

create table if not exists analytics_forum_raw.raw_likes (
  id integer primary key,
  post_id integer not null,
  user_id integer not null,
  created_at date not null
);

create table if not exists analytics_forum_raw.raw_post_ratings (
  id integer primary key,
  post_id integer not null,
  user_id integer not null,
  rating text not null,
  created_at date not null,
  constraint fk_post_ratings_post foreign key (post_id) references analytics_copilot_raw.raw_posts(id),
  constraint fk_post_ratings_user foreign key (user_id) references analytics_copilot_raw.raw_users(id)
);

create table if not exists analytics_forum_raw.raw_comment_ratings (
  id integer primary key,
  comment_id integer not null,
  user_id integer not null,
  rating text not null,
  created_at date not null,
  constraint fk_comment_ratings_comment foreign key (comment_id) references analytics_copilot_raw.raw_comments(id),
  constraint fk_comment_ratings_user foreign key (user_id) references analytics_copilot_raw.raw_users(id)
);