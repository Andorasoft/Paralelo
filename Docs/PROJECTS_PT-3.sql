-- ============================================================
-- User 3: Redacción Académica / Ensayos / Traducción
-- Owner: 32f54194-53e2-4712-a0db-ce519c1e7e24
-- Base category_id: 7
-- ============================================================
begin;

-- Project 1: Asesoría para redacción de ensayo argumentativo universitario
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
        'Asesoría para redacción de ensayo argumentativo universitario',
        'Busco orientación para redactar un ensayo argumentativo sobre cambio climático y responsabilidad social. 
    Necesito ayuda en la estructuración de ideas, elaboración de tesis, desarrollo de argumentos con base científica y redacción coherente. 
    El acompañamiento debe incluir corrección de estilo, revisión ortográfica y recomendaciones para fortalecer la coherencia entre párrafos. 
    La meta es presentar un texto sólido con introducción, desarrollo y conclusión bien articuladas, siguiendo normas APA 7.',
        null,
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      9.50,
      18.75,
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
      (41),
      (42),
      (43)
  ) as v (skill_id);

-- Project 2: Revisión y corrección de monografía académica
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
        'Revisión y corrección de monografía académica',
        'Requiero apoyo para revisar una monografía universitaria enfocada en educación ambiental. 
    El objetivo es mejorar la redacción formal, la coherencia entre capítulos y el uso correcto de citas según normas APA 7. 
    Se valorará también la corrección ortotipográfica, el ajuste de conectores y la consistencia en el formato de referencias. 
    El resultado debe ser un documento pulido y claro, apto para entrega final y defensa oral.',
        null,
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      10.00,
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
      (44),
      (45)
  ) as v (skill_id);

-- Project 3: Traducción técnica de artículo científico
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
        'Traducción técnica de artículo científico',
        'Solicito ayuda para traducir un artículo científico del inglés al español relacionado con ingeniería ambiental. 
    Se requiere que la traducción mantenga el tono académico, la precisión terminológica y el formato de citas. 
    Además, se busca revisar el texto resultante para garantizar fluidez y coherencia semántica. 
    El proyecto está dirigido a estudiantes con experiencia en redacción técnica y manejo de terminología científica.',
        null,
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      12.00,
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
      (46),
      (47),
      (48)
  ) as v (skill_id);

-- Project 4: Tutoría sobre metodología de investigación y redacción científica
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
        'Tutoría sobre metodología de investigación y redacción científica',
        'Busco tutoría para comprender cómo estructurar el capítulo metodológico de una investigación universitaria. 
    Deseo aprender sobre el uso de verbos académicos, redacción objetiva y construcción de hipótesis. 
    Además, me gustaría revisar ejemplos de redacción científica aplicada a proyectos reales, con énfasis en claridad y rigor académico. 
    Este acompañamiento servirá para fortalecer la redacción de mi trabajo de titulación y futuros artículos.',
        null,
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      9.25,
      19.75,
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
      (49),
      (50)
  ) as v (skill_id);

-- Project 5: Edición completa de informe de prácticas preprofesionales
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
        'Edición completa de informe de prácticas preprofesionales',
        'Requiero apoyo para revisar y editar un informe de prácticas preprofesionales en formato académico. 
    La tarea incluye ajustar el lenguaje técnico, mejorar la coherencia entre apartados, uniformar márgenes y numeraciones, y asegurar el cumplimiento del formato institucional. 
    También se espera una revisión ortográfica y de estilo para lograr un texto profesional y legible. 
    Ideal para estudiantes con experiencia en redacción formal y comprensión de estructura documental universitaria.',
        null,
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
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
      (51),
      (52),
      (53)
  ) as v (skill_id);

-- Project 6: Elaboración de resumen y abstract académico en inglés
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
        'Elaboración de resumen y abstract académico en inglés',
        'Busco apoyo para redactar y traducir el resumen (abstract) de mi artículo académico al inglés.  
    El texto trata sobre gestión ambiental en comunidades rurales, por lo que necesito mantener precisión técnica y un lenguaje formal.  
    Se espera recibir correcciones de estilo, revisión de terminología científica y una breve explicación de los cambios aplicados.',
        'Conocimiento en redacción científica bilingüe (inglés-español).',
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      9.00,
      18.50,
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
      (54),
      (55)
  ) AS v (skill_id);

-- Project 7: Tutoría en citación y referencias bajo norma APA 7
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
        'Tutoría en citación y referencias bajo norma APA 7',
        'Necesito una tutoría personalizada para aprender a citar correctamente fuentes en formato APA 7.  
    Deseo practicar la citación directa, indirecta y la elaboración de la lista de referencias.  
    También quiero entender cómo manejar fuentes digitales y artículos científicos dentro del texto.',
        'Conocimiento en normas APA 7 y gestión bibliográfica.',
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      8.50,
      17.75,
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
      (56),
      (57),
      (58)
  ) AS v (skill_id);

-- Project 8: Corrección de estilo y coherencia en ensayo universitario
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
        'Corrección de estilo y coherencia en ensayo universitario',
        'Requiero ayuda para revisar un ensayo sobre desarrollo sostenible.  
    El objetivo es mejorar la redacción, eliminar redundancias y fortalecer la conexión entre ideas.  
    Se espera una revisión detallada de gramática, puntuación y fluidez argumentativa, con sugerencias de reescritura claras.',
        'Conocimiento en corrección de estilo y redacción académica.',
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      10.50,
      21.00,
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
      (59),
      (60)
  ) AS v (skill_id);

-- Project 9: Traducción y adaptación cultural de documento técnico
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
        'Traducción y adaptación cultural de documento técnico',
        'Busco asistencia para traducir un documento técnico sobre eficiencia energética del inglés al español.  
    Más allá de traducir palabra por palabra, necesito adaptar el lenguaje para que sea comprensible en el contexto ecuatoriano.  
    Se valorará la precisión terminológica y la claridad comunicativa en los resultados.',
        'Conocimiento en traducción técnica y localización de textos.',
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      12.00,
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
      (61),
      (62),
      (63)
  ) AS v (skill_id);

-- Project 10: Redacción de artículo de divulgación científica
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
        'Redacción de artículo de divulgación científica',
        'Deseo orientación para transformar un informe técnico en un artículo de divulgación científica apto para publicación en medios digitales.  
    El enfoque es simplificar el lenguaje, mantener rigor académico y estructurar el texto con subtítulos atractivos.  
    Se requiere guía en redacción, estilo periodístico y revisión final del formato.',
        'Conocimiento en divulgación científica y periodismo académico.',
        '32f54194-53e2-4712-a0db-ce519c1e7e24',
        7
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      11.75,
      24.00,
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
      (64),
      (65),
      (66)
  ) AS v (skill_id);

commit;