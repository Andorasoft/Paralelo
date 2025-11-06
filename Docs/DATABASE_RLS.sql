-- ============================================================
-- 1. Table: university
-- ============================================================
ALTER TABLE "public"."university" ENABLE ROW LEVEL SECURITY;

create policy "policy_name" on "public"."university" as PERMISSIVE for
SELECT
  to anon,
  authenticated using (true);

-- ============================================================
-- 1. Table: plan
-- ============================================================
ALTER TABLE "public"."plan" ENABLE ROW LEVEL SECURITY;

create policy "policy_name" on "public"."plan" as PERMISSIVE for
SELECT
  to authenticated using (true);

-- ============================================================
-- 1. Table: user
-- ============================================================
ALTER TABLE "public"."user" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: skill
-- ============================================================
ALTER TABLE "skill" ENABLE ROW LEVEL SECURITY;

create policy "policy_name" on "public"."skill" as PERMISSIVE for
SELECT
  to authenticated using (true);

-- ============================================================
-- 1. Table: category
-- ============================================================
ALTER TABLE "category" ENABLE ROW LEVEL SECURITY;

create policy "policy_name" on "public"."category" as PERMISSIVE for
SELECT
  to authenticated using (true);

-- ============================================================
-- 1. Table: project
-- ============================================================
ALTER TABLE "project" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: proposal
-- ============================================================
ALTER TABLE "proposal" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: project_payment
-- ============================================================
ALTER TABLE "project_payment" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: project_skill
-- ============================================================
ALTER TABLE "project_skill" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: user_skill
-- ============================================================
ALTER TABLE "user_skill" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: chat_room
-- ============================================================
ALTER TABLE "chat_room" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: user_rating
-- ============================================================
ALTER TABLE "user_rating" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: report
-- ============================================================
ALTER TABLE "report" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: application
-- ============================================================
ALTER TABLE "application" ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- 1. Table: user_preference
-- ============================================================
ALTER TABLE "user_preference" ENABLE ROW LEVEL SECURITY;

create policy "policy_name" on "public"."user_preference" as PERMISSIVE for
SELECT
  to authenticated using (true);

create policy "policy_name" on "public"."user_preference" as PERMISSIVE for INSERT to authenticated
with
  check (true);

create policy "policy_name" on "public"."user_preference" as PERMISSIVE for
UPDATE to authenticated using (true);