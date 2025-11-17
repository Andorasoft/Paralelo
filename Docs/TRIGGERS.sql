-- ============================================================
-- Function: create_user_preference()
-- ============================================================
create
or replace function "public"."create_user_preference"() returns trigger language plpgsql as $ $ begin
insert into
  "public"."user_preference" (
    "user_id",
    "language",
    "dark_mode",
    "notifications_enabled"
  )
values
  (new.id, 'es', false, false);

return new;

end;

$ $;

-- ============================================================
-- Trigger: after insert on user
-- ============================================================
create trigger trg_create_user_preference
after
insert
  on "public"."user" for each row execute function "public"."create_user_preference"();

-- ============================================================
-- Function: handle_proposal_accept()
-- ------------------------------------------------------------
-- When a proposal is updated to 'ACCEPTED':
--   1. Reject all other proposals for the same project
--   2. Update the related project status to 'IN_PROGRESS'
-- ============================================================
create
or replace function "public"."handle_proposal_accept"() returns trigger language plpgsql as $ $ begin if NEW.status = 'ACCEPTED'
and OLD.status is distinct
from
  'ACCEPTED' then -- 1) Reject all other proposals for the same project
update
  "public"."proposal"
set
  status = 'REJECTED'
where
  "project_id" = NEW.project_id
  and id <> NEW.id
  and status <> 'REJECTED';

-- 2) Set project status to IN_PROGRESS
update
  "public"."project"
set
  status = 'IN_PROGRESS'
where
  "id" = NEW.project_id;

end if;

return NEW;

end;

$ $;

-- ============================================================
-- Trigger: when proposal.status becomes 'ACCEPTED'
-- ============================================================
create trigger trg_proposal_accept
after
update
  on "public"."proposal" for each row
  when (NEW.status = 'ACCEPTED') execute function "public"."handle_proposal_accept"();

-- ============================================================
-- Function: handle_proposal_rejected()
-- ============================================================
create
or replace function "handle_proposal_rejected"() returns trigger language plpgsql as $ $ begin if NEW.status = 'REJECTED'
and OLD.status is distinct
from
  'REJECTED' then
update
  "public"."chat_room"
set
  "is_active" = false
where
  "proposal_id" = NEW.id;

end if;

return NEW;

end;

$ $;

-- ============================================================
-- Trigger: when proposal.status becomes 'REJECTED'
-- ============================================================
create trigger trg_proposal_rejected
after
update
  on "public"."proposal" for each row
  when (NEW.status = 'REJECTED') execute function "public"."handle_proposal_rejected"();