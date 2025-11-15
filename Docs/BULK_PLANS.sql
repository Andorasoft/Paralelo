-- ============================================================
-- INSERT DEFAULT PLANS
-- ============================================================
insert into
  "public"."plan" (
    name,
    description,
    price,
    period_unit,
    proposals_per_week,
    active_projects_limit,
    featured_projects_limit,
    ongoing_projects_limit,
    tag,
    support_level,
    performance_metrics,
    is_active
  )
values
  -- PLAN FREE
  (
    'Free',
    'Plan gratuito con funciones básicas para iniciar y participar en proyectos limitados.',
    0.00,
    'MONTH',
    5,
    2,
    0,
    1,
    null,
    'BASIC',
    false,
    true
  ),
  -- PLAN PRO
  (
    'Pro',
    'Plan intermedio con mayor capacidad de proyectos y visibilidad prioritaria.',
    3.99,
    'MONTH',
    10,
    10,
    1,
    2,
    'PRO',
    'PRIORITY',
    false,
    true
  ),
  -- PLAN PREMIUM
  (
    'Premium',
    'Plan avanzado con proyectos ilimitados, soporte premium y métricas de rendimiento.',
    9.99,
    'MONTH',
    20,
    null,
    5,
    null,
    'PREMIUM',
    'PREMIUM',
    true,
    true
  );