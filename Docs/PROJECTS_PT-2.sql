-- ============================================================
-- User 2: Diseño Gráfico / UX / Branding
-- Owner: 321450e5-2ced-471e-83c9-857ab7251685
-- Base category_id: 5
-- ============================================================
begin;

-- Project 1: Diseño de identidad visual para un grupo estudiantil
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
        'Diseño de identidad visual para un grupo estudiantil',
        'Se busca apoyo para desarrollar la identidad visual de un grupo académico universitario que organiza eventos y talleres en su facultad. 
    El proyecto contempla la creación de un logotipo versátil, elección de una paleta cromática coherente y definición de tipografías legibles y modernas. 
    Además, se desea un pequeño manual de marca que explique el uso correcto del logotipo en redes sociales, presentaciones y documentos institucionales. 
    El enfoque es formativo, combinando teoría del color con práctica en herramientas de diseño accesibles como Canva, Figma o Illustrator.',
        null,
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      12.00,
      24.00,
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
      (21),
      (22),
      (23)
  ) as v (skill_id);

-- Project 2: Elaboración de portafolio académico profesional en Canva
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
        'Elaboración de portafolio académico profesional en Canva',
        'Busco una tutoría personalizada para crear un portafolio académico atractivo utilizando Canva o Figma. 
    La meta es organizar proyectos, incluir fotografías de trabajos, logros y un resumen de perfil personal con diseño limpio y profesional. 
    Se espera orientación sobre estructura, equilibrio visual, jerarquía tipográfica y cómo adaptar el portafolio para versión digital o impresa. 
    El resultado final debe reflejar creatividad y coherencia visual, ideal para postular a becas, prácticas o eventos académicos.',
        null,
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      11.50,
      21.75,
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
      (24),
      (25),
      (26)
  ) as v (skill_id);

-- Project 3: Rediseño de interfaz para aplicación universitaria
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
        'Rediseño de interfaz para aplicación universitaria',
        'El objetivo de este proyecto es rediseñar la interfaz de una aplicación universitaria existente, 
    mejorando la experiencia del usuario (UX) y la consistencia visual (UI). 
    Se busca analizar problemas actuales de usabilidad, crear un flujo de navegación más intuitivo y definir una guía visual basada en colores institucionales. 
    La tutoría incluirá la creación de wireframes, prototipos en Figma y una revisión de accesibilidad para dispositivos móviles. 
    Se prioriza el aprendizaje práctico con retroalimentación sobre diseño centrado en el usuario.',
        null,
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      14.00,
      27.00,
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
      (27),
      (28),
      (29)
  ) as v (skill_id);

-- Project 4: Creación de afiche publicitario para feria universitaria
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
        'Creación de afiche publicitario para feria universitaria',
        'Se necesita apoyo para diseñar un afiche llamativo que promocione una feria universitaria de emprendimiento. 
    El estudiante busca aprender sobre jerarquía visual, tipografía creativa y composición equilibrada de imágenes y texto. 
    Además, se desea asesoría sobre cómo exportar el archivo para impresión en alta calidad y formato digital para redes. 
    El acompañamiento debe ser práctico y enfocado en la presentación profesional del diseño final.',
        null,
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      10.75,
      20.25,
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
      (30),
      (31)
  ) as v (skill_id);

-- Project 5: Asesoría en diseño de marca para emprendimiento universitario
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
        'Asesoría en diseño de marca para emprendimiento universitario',
        'Se solicita ayuda para desarrollar la identidad visual de un pequeño emprendimiento creado por estudiantes. 
    El objetivo es definir logotipo, colores, tipografía y estilo visual que reflejen innovación, sostenibilidad y confianza. 
    Se requiere una tutoría donde se expliquen los fundamentos del branding, cómo crear coherencia entre redes sociales y empaques, 
    y cómo aplicar la marca en materiales publicitarios. 
    Este proyecto permitirá al estudiante comprender cómo una marca coherente puede fortalecer su presencia y diferenciación.',
        null,
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      13.00,
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
      (32),
      (33),
      (34)
  ) as v (skill_id);

-- Project 6: Creación de prototipo interactivo en Figma
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
        'Creación de prototipo interactivo en Figma',
        'Busco orientación para diseñar un prototipo interactivo de aplicación móvil en Figma. 
    El objetivo es representar el flujo de usuario completo con pantallas enlazadas, transiciones y componentes reutilizables. 
    Se espera aprender a utilizar auto-layout, estilos de texto y librerías compartidas. 
    El resultado será un prototipo navegable que pueda presentarse en clase o portafolio.',
        'Conocimiento en Figma y diseño de interacción (UI/UX).',
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      12.00,
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
      (35),
      (36),
      (37)
  ) as v (skill_id);

-- Project 7: Diseño de packaging sostenible para productos artesanales
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
        'Diseño de packaging sostenible para productos artesanales',
        'Necesito asesoría para crear un diseño de empaque ecológico que combine funcionalidad y estética. 
    El proyecto está orientado a pequeños emprendimientos estudiantiles que utilizan materiales reciclables. 
    Se busca definir estructura, colores, tipografía y mensaje visual coherente con los valores ambientales del producto. 
    La tutoría incluirá revisión de bocetos y recomendaciones de impresión.',
        'Conocimiento en packaging y materiales sostenibles.',
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      13.50,
      26.00,
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
      (38),
      (39)
  ) as v (skill_id);

-- Project 8: Diseño de presentación corporativa en PowerPoint y Canva
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
        'Diseño de presentación corporativa en PowerPoint y Canva',
        'Se requiere apoyo para estructurar y diseñar una presentación institucional con enfoque visual moderno. 
    El estudiante desea aprender principios de composición, contraste y tipografía, además de crear plantillas reutilizables. 
    Se busca lograr una presentación coherente con identidad de marca y claridad informativa.',
        'Conocimiento en diseño de presentaciones profesionales.',
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      10.50,
      21.25,
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
      (40),
      (41),
      (42)
  ) as v (skill_id);

-- Project 9: Tutoría sobre teoría del color y psicología visual
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
        'Tutoría sobre teoría del color y psicología visual',
        'Requiero una sesión práctica para profundizar en la teoría del color y su aplicación en el diseño gráfico. 
    Me interesa comprender cómo las combinaciones cromáticas afectan la percepción y el comportamiento del usuario. 
    Se abordarán conceptos de armonías, contrastes y asociaciones culturales del color, aplicados a proyectos reales de diseño publicitario.',
        'Conocimiento en teoría del color y composición visual.',
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      11.25,
      22.50,
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
      (43),
      (44)
  ) as v (skill_id);

-- Project 10: Creación de guía de estilo visual para proyectos académicos
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
        'Creación de guía de estilo visual para proyectos académicos',
        'Busco ayuda para elaborar una guía visual que unifique el diseño de portadas, presentaciones y documentos académicos. 
    La meta es definir reglas de color, tipografía y composición para mantener coherencia institucional. 
    Este trabajo servirá como base para futuros informes, presentaciones y trabajos grupales dentro de la universidad.',
        'Conocimiento en branding y elaboración de manuales de identidad.',
        '321450e5-2ced-471e-83c9-857ab7251685',
        5
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      13.00,
      25.50,
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
      (45),
      (46),
      (47)
  ) as v (skill_id);

commit;