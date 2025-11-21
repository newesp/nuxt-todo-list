-- Temporary: Disable RLS to test
-- This will help us determine if the issue is with the RLS policies

ALTER TABLE public.todos DISABLE ROW LEVEL SECURITY;

-- After testing, you should re-enable it with:
-- ALTER TABLE public.todos ENABLE ROW LEVEL SECURITY;
