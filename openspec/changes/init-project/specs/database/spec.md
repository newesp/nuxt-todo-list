# Database Spec

## Table: `todos`
- `id`: uuid, primary key, default `gen_random_uuid()`
- `user_id`: uuid, references `auth.users.id`, not null
- `title`: text, not null
- `completed`: boolean, default `false`
- `created_at`: timestamptz, default `now()`

## RLS Policies
- Enable RLS.
- Policy "Users can view their own todos": `auth.uid() = user_id` (SELECT).
- Policy "Users can insert their own todos": `auth.uid() = user_id` (INSERT).
- Policy "Users can update their own todos": `auth.uid() = user_id` (UPDATE).
- Policy "Users can delete their own todos": `auth.uid() = user_id` (DELETE).
