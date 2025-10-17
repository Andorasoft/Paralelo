-- ============================================================
-- User 4: Marketing Digital / Redes Sociales / Publicidad
-- Owner: 5bf5a059-dac8-44c5-87a0-541253900958
-- Base category_id: 9
-- ============================================================
begin;

-- Project 1: Estrategia de contenido para redes sociales universitarias
with
  p as (
    insert into
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    values
      (
        'Estrategia de contenido para redes sociales universitarias',
        'Se requiere apoyo para diseñar una estrategia digital enfocada en mejorar la presencia de un grupo estudiantil en Instagram y TikTok. 
    Se espera crear un plan mensual de publicaciones con temas educativos, motivacionales y de vida universitaria. 
    El proyecto incluirá asesoría sobre el tono comunicacional, diseño de piezas gráficas y análisis de estadísticas para medir impacto. 
    La meta es aumentar la interacción con la comunidad universitaria y fortalecer la imagen institucional del grupo.',
        'Conocimiento en gestión de redes sociales y métricas de engagement.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      11.00,
      23.00,
      'USD',
      'FIXED',
      id
    from
      p returning project_id
  )
insert into
  project_skill (project_id, skill_id)
select
  p.id,
  v.skill_id
from
  p
  cross join (
    values
      (61),
      (62),
      (63)
  ) as v (skill_id);

-- Project 2: Diseño de campaña publicitaria para feria académica
with
  p as (
    insert into
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    values
      (
        'Diseño de campaña publicitaria para feria académica',
        'Busco asesoría para planificar una mini campaña publicitaria que promueva la feria académica anual de mi facultad. 
    El proyecto busca integrar diseño gráfico, redacción de copies atractivos y segmentación de públicos en redes sociales. 
    Se pretende aprender sobre planificación de medios, uso de herramientas gratuitas de publicidad y estrategias de engagement orgánico. 
    El objetivo final es diseñar una campaña efectiva con materiales visuales listos para publicación.',
        'Conocimiento en diseño publicitario y redacción creativa.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      12.25,
      24.50,
      'USD',
      'FIXED',
      id
    from
      p returning project_id
  )
insert into
  project_skill (project_id, skill_id)
select
  p.id,
  v.skill_id
from
  p
  cross join (
    values
      (64),
      (65)
  ) as v (skill_id);

-- Project 3: Tutoría en manejo de Meta Ads y segmentación de audiencia
with
  p as (
    insert into
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    values
      (
        'Tutoría en manejo de Meta Ads y segmentación de audiencia',
        'Requiero una tutoría práctica para aprender a usar el Administrador de Anuncios de Meta (Facebook e Instagram). 
    El enfoque es académico, orientado a comprender cómo crear campañas básicas, definir públicos personalizados y analizar resultados. 
    Se busca un acompañamiento paso a paso que incluya ejemplos reales, simulación de anuncios y evaluación de presupuestos pequeños. 
    Este proyecto está pensado para estudiantes interesados en marketing digital aplicado.',
        'Experiencia básica en Meta Ads o campañas de redes sociales.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      13.50,
      25.00,
      'USD',
      'FIXED',
      id
    from
      p returning project_id
  )
insert into
  project_skill (project_id, skill_id)
select
  p.id,
  v.skill_id
from
  p
  cross join (
    values
      (66),
      (67),
      (68)
  ) as v (skill_id);

-- Project 4: Análisis de marca personal en LinkedIn
with
  p as (
    insert into
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    values
      (
        'Análisis de marca personal en LinkedIn',
        'El objetivo es mejorar el perfil profesional en LinkedIn aplicando principios de marketing personal. 
    Se requiere una revisión completa del perfil, recomendaciones sobre redacción del titular, foto de perfil y descripción profesional. 
    Además, se busca entender cómo usar publicaciones y artículos para generar visibilidad y oportunidades laborales. 
    La asesoría debe ser práctica, orientada al estudiante universitario que desea optimizar su presencia digital.',
        'Conocimiento en marketing personal y optimización de perfiles.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      10.25,
      20.75,
      'USD',
      'FIXED',
      id
    from
      p returning project_id
  )
insert into
  project_skill (project_id, skill_id)
select
  p.id,
  v.skill_id
from
  p
  cross join (
    values
      (69),
      (70)
  ) as v (skill_id);

-- Project 5: Estrategia de posicionamiento para emprendimiento universitario
with
  p as (
    insert into
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    values
      (
        'Estrategia de posicionamiento para emprendimiento universitario',
        'Se solicita ayuda para diseñar una estrategia de posicionamiento digital para un emprendimiento creado por estudiantes. 
    El negocio ofrece productos ecológicos y necesita mejorar su alcance en redes sociales mediante contenido educativo y visual. 
    El proyecto incluirá un plan de comunicación con objetivos claros, análisis de competencia y recomendaciones de branding. 
    El acompañamiento debe permitir que el estudiante comprenda cómo construir una marca sólida y sostenible.',
        'Conocimiento en estrategias de posicionamiento y branding.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      12.75,
      23.75,
      'USD',
      'FIXED',
      id
    from
      p returning project_id
  )
insert into
  project_skill (project_id, skill_id)
select
  p.id,
  v.skill_id
from
  p
  cross join (
    values
      (71),
      (72),
      (73)
  ) as v (skill_id);

-- Project 6: Creación de plan de marketing digital para proyecto académico
WITH
  p AS (
    INSERT INTO
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    VALUES
      (
        'Creación de plan de marketing digital para proyecto académico',
        'Busco asesoría para elaborar un plan de marketing digital que apoye la difusión de un proyecto académico universitario.  
    El documento debe incluir análisis FODA, definición de público objetivo, estrategias de contenido y métricas de evaluación.  
    La meta es aprender a planificar campañas reales en redes sociales y aplicar conocimientos de comunicación estratégica.',
        'Conocimiento en planificación de marketing digital.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      12.25,
      24.50,
      'USD',
      'FIXED',
      id
    FROM
      p RETURNING project_id
  )
INSERT INTO
  project_skill (project_id, skill_id)
SELECT
  p.id,
  v.skill_id
FROM
  p
  CROSS JOIN (
    VALUES
      (74),
      (75),
      (76)
  ) AS v (skill_id);

-- Project 7: Optimización de perfiles en redes sociales institucionales
WITH
  p AS (
    INSERT INTO
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    VALUES
      (
        'Optimización de perfiles en redes sociales institucionales',
        'Se necesita apoyo para mejorar la presentación de perfiles institucionales en redes sociales.  
    El objetivo es revisar biografías, imágenes de portada, tono de comunicación y consistencia gráfica entre plataformas.  
    También se busca aprender cómo usar herramientas de análisis para medir crecimiento y participación.  
    Este proyecto permitirá a los estudiantes aplicar branding digital en un entorno real.',
        'Conocimiento en optimización de perfiles y branding digital.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      11.50,
      22.75,
      'USD',
      'FIXED',
      id
    FROM
      p RETURNING project_id
  )
INSERT INTO
  project_skill (project_id, skill_id)
SELECT
  p.id,
  v.skill_id
FROM
  p
  CROSS JOIN (
    VALUES
      (77),
      (78)
  ) AS v (skill_id);

-- Project 8: Creación de contenido educativo para redes universitarias
WITH
  p AS (
    INSERT INTO
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    VALUES
      (
        'Creación de contenido educativo para redes universitarias',
        'Se busca crear contenido educativo y motivacional para redes sociales de una facultad.  
    El enfoque es promover hábitos sostenibles, innovación y participación estudiantil.  
    Se espera diseñar publicaciones visuales con mensajes claros, uso adecuado de hashtags y estética coherente con la identidad institucional.  
    Ideal para quienes deseen aprender storytelling visual aplicado al ámbito académico.',
        'Conocimiento en creación de contenido y diseño visual.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      10.75,
      21.50,
      'USD',
      'FIXED',
      id
    FROM
      p RETURNING project_id
  )
INSERT INTO
  project_skill (project_id, skill_id)
SELECT
  p.id,
  v.skill_id
FROM
  p
  CROSS JOIN (
    VALUES
      (79),
      (80),
      (81)
  ) AS v (skill_id);

-- Project 9: Análisis de métricas e interpretación de resultados en redes
WITH
  p AS (
    INSERT INTO
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    VALUES
      (
        'Análisis de métricas e interpretación de resultados en redes',
        'Requiero apoyo para aprender a analizar métricas de desempeño en redes sociales.  
    El objetivo es comprender indicadores como alcance, interacciones, tasa de clics y crecimiento orgánico.  
    Además, se espera crear un pequeño informe visual con conclusiones y recomendaciones para mejorar campañas futuras.',
        'Conocimiento en analítica digital y herramientas de medición.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      11.25,
      23.25,
      'USD',
      'FIXED',
      id
    FROM
      p RETURNING project_id
  )
INSERT INTO
  project_skill (project_id, skill_id)
SELECT
  p.id,
  v.skill_id
FROM
  p
  CROSS JOIN (
    VALUES
      (82),
      (83)
  ) AS v (skill_id);

-- Project 10: Asesoría en marketing de contenidos para podcasts educativos
WITH
  p AS (
    INSERT INTO
      project (
        title,
        description,
        requirement,
        owner_id,
        category_id
      )
    VALUES
      (
        'Asesoría en marketing de contenidos para podcasts educativos',
        'Busco asesoría para posicionar un podcast académico orientado a temas de sostenibilidad y tecnología.  
    Se espera aprender sobre estrategias de difusión, optimización SEO para títulos y descripciones, 
    y planificación de calendario editorial.  
    El acompañamiento debe ser práctico, combinando creatividad y análisis de audiencias.',
        'Conocimiento en marketing de contenidos y SEO básico.',
        '5bf5a059-dac8-44c5-87a0-541253900958',
        9
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      12.00,
      24.50,
      'USD',
      'FIXED',
      id
    FROM
      p RETURNING project_id
  )
INSERT INTO
  project_skill (project_id, skill_id)
SELECT
  p.id,
  v.skill_id
FROM
  p
  CROSS JOIN (
    VALUES
      (84),
      (85),
      (86)
  ) AS v (skill_id);

commit;