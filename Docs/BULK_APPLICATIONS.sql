-- ===========================================
-- Insert default platforms for the application
-- ===========================================
insert into
  "public"."application" (
    platform,
    min_version,
    latest_version,
    force_update,
    maintenance_mode,
    maintenance_message
  )
values
  ('iOS', '1.0.0', '1.0.0', false, false, null),
  ('Android', '1.0.0', '1.0.0', false, false, null);