-- Create todos table
create table public.todos (
  id uuid not null default gen_random_uuid(),
  user_id uuid not null references auth.users(id),
  title text not null,
  completed boolean not null default false,
  created_at timestamptz not null default now(),
  primary key (id)
);

-- Enable RLS
alter table public.todos enable row level security;

-- Create policies
create policy "Users can view their own todos"
on public.todos for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can insert their own todos"
on public.todos for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can update their own todos"
on public.todos for update
to authenticated
using (auth.uid() = user_id);

create policy "Users can delete their own todos"
on public.todos for delete
to authenticated
using (auth.uid() = user_id);
