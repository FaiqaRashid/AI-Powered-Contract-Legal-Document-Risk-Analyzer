-- =====================================================================
-- AI Contract Risk Analyzer — Supabase Schema
-- Run this in the Supabase SQL editor before starting the app.
-- =====================================================================

-- Users table (custom auth, separate from Supabase's built-in auth)
create table if not exists app_users (
    id uuid primary key default gen_random_uuid(),
    username text unique not null,
    email text,
    password_hash text not null,
    role text not null default 'user',   -- 'user' or 'admin'
    created_at timestamp with time zone default now()
);

-- Contract analysis log / history table
create table if not exists legal_contract_analyses (
    id uuid primary key default gen_random_uuid(),
    file_name text,
    contract_type text,
    effective_date text,
    expiry_date text,
    summary text,
    overall_risk_score integer,
    uploaded_by text references app_users(username),
    raw_ai_output jsonb,
    created_at timestamp with time zone default now()
);

-- Optional: promote your own account to admin after registering once, e.g.:
-- update app_users set role = 'admin' where username = 'faiqa';
