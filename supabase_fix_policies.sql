-- First, let's check if the table exists and drop it to start fresh
DROP TABLE IF EXISTS public.todos CASCADE;

-- Create todos table
CREATE TABLE public.todos (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title text NOT NULL,
  completed boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

-- Enable RLS
ALTER TABLE public.todos ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Users can view their own todos" ON public.todos;
DROP POLICY IF EXISTS "Users can insert their own todos" ON public.todos;
DROP POLICY IF EXISTS "Users can update their own todos" ON public.todos;
DROP POLICY IF EXISTS "Users can delete their own todos" ON public.todos;

-- Create policies
CREATE POLICY "Users can view their own todos"
ON public.todos FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own todos"
ON public.todos FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own todos"
ON public.todos FOR UPDATE
TO authenticated
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own todos"
ON public.todos FOR DELETE
TO authenticated
USING (auth.uid() = user_id);

-- Grant permissions to authenticated users
GRANT SELECT, INSERT, UPDATE, DELETE ON public.todos TO authenticated;

-- Verify the setup
SELECT tablename, policyname, permissive, roles, cmd, qual 
FROM pg_policies 
WHERE tablename = 'todos';
