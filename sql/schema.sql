-- Supabase SQL schema for Colearn MVP

create table if not exists teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  host_id uuid references auth.users(id) on delete set null,
  created_at timestamptz default now()
);

create table if not exists users (
  id uuid primary key references auth.users(id) on delete cascade,
  name text,
  email text unique,
  team_id uuid references teams(id) on delete set null,
  total_points int default 0,
  created_at timestamptz default now()
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  deadline timestamptz,
  team_id uuid references teams(id) on delete cascade,
  point_value int default 0,
  created_at timestamptz default now()
);

create table if not exists submissions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id) on delete cascade,
  task_id uuid references tasks(id) on delete cascade,
  score int,
  submitted_at timestamptz default now()
);
