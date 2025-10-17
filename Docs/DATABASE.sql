-- ============================================================
-- Enable UUID extension (required in Supabase)
-- ============================================================
create extension if not exists "uuid-ossp";

-- ============================================================
-- 1. Table: university
-- ============================================================
create table
  if not exists "university" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "name" text not null,
    "short_name" text not null,
    "domain" text not null,
    "city" text not null
  );

-- ============================================================
-- 2. Table: user
-- ============================================================
create table
  if not exists "user" (
    "id" uuid primary key default uuid_generate_v4 (),
    "created_at" timestamptz not null default now (),
    "display_name" text not null,
    "email" text not null unique,
    "verified" boolean not null default false,
    "picture_url" text,
    "device_token" text,
    "university_id" integer not null references "university" ("id") on delete set null
  );

-- ============================================================
-- 3. Table: skill
-- ============================================================
create table
  if not exists "skill" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "name" text not null
  );

-- ============================================================
-- 4. Table: category
-- ============================================================
create table
  if not exists "category" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "name" text not null unique,
    "description" text
  );

-- ============================================================
-- 5. Table: project
-- ============================================================
create table
  if not exists "project" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "title" text not null,
    "description" text not null,
    "status" text not null default 'OPEN',
    "requirement" text,
    "owner_id" uuid not null references "user" ("id") on delete cascade,
    "category_id" integer references "category" ("id") on delete set null
  );

-- ============================================================
-- Table: proposal
-- ============================================================
create table
  if not exists "proposal" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "message" text not null,
    "mode" text not null,
    "amount" numeric,
    "hourly_rate" numeric,
    "estimated_duration_value" numeric not null,
    "estimated_duration_unit" text not null,
    "status" text not null default 'PENDING',
    "provider_id" uuid not null references "user" ("id") on delete cascade,
    "project_id" integer not null references "project" ("id") on delete cascade
  );

-- ============================================================
-- 7. Table: project_payment
-- ============================================================
create table
  if not exists "project_payment" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "min" numeric not null,
    "max" numeric not null,
    "currency" text not null,
    "type" text not null,
    "project_id" integer not null references "project" ("id") on delete cascade
  );

-- ============================================================
-- 8. Table: project_skill
-- ============================================================
create table
  if not exists "project_skill" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "project_id" integer not null references "project" ("id") on delete cascade,
    "skill_id" integer not null references "skill" ("id") on delete cascade
  );

-- ============================================================
-- 9. Table: user_skill
-- ============================================================
create table
  if not exists "user_skill" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "level" smallint not null,
    "user_id" uuid not null references "user" ("id") on delete cascade,
    "skill_id" integer not null references "skill" ("id") on delete cascade
  );

-- ============================================================
-- 10. Table: chat_room
-- ============================================================
create table
  if not exists "chat_room" (
    "id" uuid primary key default uuid_generate_v4 (),
    "created_at" timestamptz not null default now (),
    "user1_id" uuid not null references "user" ("id") on delete cascade,
    "user2_id" uuid not null references "user" ("id") on delete cascade,
    "proposal_id" integer not null references "proposal" ("id") on delete cascade
  );

-- ============================================================
-- 11. Table: user_rating
-- ============================================================
create table
  if not exists "user_rating" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "score" numeric not null,
    "comment" text,
    "rater_id" uuid not null references "user" ("id") on delete cascade,
    "rated_id" uuid not null references "user" ("id") on delete cascade,
    "project_id" integer not null references "project" ("id") on delete cascade
  );

-- ============================================================
-- 12. Table: report
-- ============================================================
create table
  if not exists "report" (
    "id" integer generated always as identity primary key,
    "created_at" timestamptz not null default now (),
    "reason" text not null,
    "status" text not null default 'OPEN',
    "resolution" text,
    "reporter_id" uuid not null references "user" ("id") on delete cascade,
    "reported_id" uuid references "user" ("id") on delete set null,
    "project_id" integer references "project" ("id") on delete set null
  );

-- ============================================================
-- 13. Table: application
-- ============================================================
create table
  if not exists "application" (
    "id" integer generated always as identity primary key,
    "updated_at" timestamptz not null default now (),
    "platform" text not null,
    "min_version" text not null,
    "latest_version" text not null,
    "force_update" boolean not null default false,
    "maintenance_mode" boolean not null default false,
    "maintenance_message" text
  );

-- ============================================================
-- 14. Table: user_preference
-- ============================================================
create table
  if not exists "user_preference" (
    "id" integer generated always as identity primary key,
    "updated_at" timestamptz not null default now (),
    "language" text not null default 'es',
    "dark_mode" boolean not null default false,
    "notifications_enabled" boolean not null default false,
    "user_id" uuid not null references "user" ("id") on delete cascade
  );

-- ============================================================
-- ENUM-LIKE FIELDS (reference only)
-- ============================================================
-- project.status                   → 'OPEN', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'
-- proposal.mode                    → 'REMOTE', 'IN_PERSON', 'HYBRID'
-- proposal.status                  → 'PENDING', 'ACCEPTED', 'REJECTED', 'CANCELLED'
-- proposal.estimated_duration_unit → 'HOURS', 'DAYS'
-- project_payment.type             → 'FIXED', 'HOURLY'
-- report.status                    → 'OPEN', 'IN_REVIEW', 'RESOLVED', 'CLOSED'
-- application.platform             → 'IOS', 'ANDROID'
-- user_preference.language         → 'es', 'en'