-- Idea Vault database setup for Supabase
-- Run this in Supabase SQL Editor.

create table if not exists public.journal_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  title text not null default '',
  body text not null default '',
  tag text,
  mood text,
  favorite boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.journal_entries enable row level security;

drop policy if exists "Users can view their own entries" on public.journal_entries;
create policy "Users can view their own entries"
on public.journal_entries for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can create their own entries" on public.journal_entries;
create policy "Users can create their own entries"
on public.journal_entries for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update their own entries" on public.journal_entries;
create policy "Users can update their own entries"
on public.journal_entries for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own entries" on public.journal_entries;
create policy "Users can delete their own entries"
on public.journal_entries for delete
to authenticated
using (auth.uid() = user_id);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists journal_entries_updated_at on public.journal_entries;
create trigger journal_entries_updated_at
before update on public.journal_entries
for each row execute function public.set_updated_at();

create index if not exists journal_entries_user_updated_idx
on public.journal_entries(user_id, updated_at desc);
