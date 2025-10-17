-- ============================================================
-- User 1: Desarrollo de Software / Flutter / Web
-- Owner: 2dae045f-3775-468f-bd10-e4c51154a50b
-- Base category_id: 3
-- ============================================================
BEGIN;

-- Project 1: Desarrollo de aplicación móvil para gestión universitaria
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
        'Desarrollo de aplicación móvil para gestión universitaria',
        'Busco acompañamiento para crear una aplicación móvil básica en Flutter orientada a la gestión de horarios, materias y tareas académicas. 
    El objetivo es aprender a usar Supabase como backend, implementar autenticación por correo y manejar bases de datos relacionales desde la app. 
    Me interesa comprender la estructura de carpetas, los widgets principales y cómo organizar un proyecto escalable. 
    El proyecto se enfocará en la práctica, con explicaciones claras para estudiantes en etapa inicial.',
        NULL,
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      17.50,
      32.00,
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
      (1),
      (2),
      (3)
  ) AS v (skill_id);

-- Project 2: Tutoría práctica en consumo de APIs REST con Flutter
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
        'Tutoría práctica en consumo de APIs REST con Flutter',
        'Necesito apoyo para comprender cómo consumir APIs externas desde Flutter utilizando el paquete http y controlando errores. 
    El enfoque del proyecto es práctico: realizar peticiones GET y POST, mostrar los resultados en listas dinámicas y usar FutureBuilder. 
    Se busca además aprender buenas prácticas para separar la lógica del diseño (MVVM o Provider). 
    El acompañamiento debe incluir ejercicios sencillos y explicación paso a paso para mejorar la comprensión del flujo de datos.',
        NULL,
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      15.00,
      27.75,
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
      (4),
      (5)
  ) AS v (skill_id);

-- Project 3: Integración de Firebase y notificaciones push
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
        'Integración de Firebase y notificaciones push',
        'Este proyecto busca implementar el sistema de notificaciones push mediante Firebase Cloud Messaging en una app móvil Flutter. 
    Se requiere entender la configuración de FCM, el registro del token del dispositivo, y la recepción de notificaciones tanto en primer como segundo plano. 
    También se espera orientación sobre cómo gestionar los permisos y crear una estructura segura y eficiente de mensajería. 
    Es ideal para estudiantes que ya tengan conocimientos básicos en Flutter y deseen añadir funcionalidades modernas a sus proyectos.',
        NULL,
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      18.25,
      30.50,
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
      (6),
      (7),
      (8)
  ) AS v (skill_id);

-- Project 4: Implementación de arquitectura limpia en proyecto Flutter
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
        'Implementación de arquitectura limpia en proyecto Flutter',
        'Requiero una tutoría técnica enfocada en aplicar correctamente la arquitectura limpia dentro de un proyecto Flutter universitario. 
    El objetivo es dividir el código en capas (dominio, datos y presentación), crear repositorios y manejar dependencias con Riverpod o Provider. 
    Se busca comprender la lógica detrás de la separación de responsabilidades y cómo mantener el código escalable. 
    La asesoría debe incluir ejemplos concretos, revisión de código y explicación de patrones comunes como CQRS y UnitOfWork.',
        NULL,
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      20.00,
      34.00,
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
      (9),
      (10),
      (11)
  ) AS v (skill_id);

-- Project 5: Revisión y corrección de errores en app Flutter
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
        'Revisión y corrección de errores en app Flutter',
        'Se solicita apoyo para depurar una aplicación desarrollada en Flutter que presenta errores de compilación y fallos al ejecutar ciertas vistas. 
    Se requiere identificar los problemas de dependencias, actualizar paquetes, resolver conflictos con versiones del SDK y mejorar el rendimiento general. 
    La tutoría debe explicar el proceso de depuración, uso del inspector de Flutter DevTools y estrategias para mantener el código limpio y mantenible. 
    Ideal para quienes deseen aprender resolución de errores en proyectos reales.',
        NULL,
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      14.75,
      25.50,
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
      (12),
      (13)
  ) AS v (skill_id);

-- Project 6: Desarrollo de módulo de autenticación con Supabase
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
        'Desarrollo de módulo de autenticación con Supabase',
        'Busco apoyo para implementar un sistema de autenticación completo utilizando Supabase en Flutter. 
    Se desea aprender a configurar registro, inicio de sesión, recuperación de contraseña y cierre de sesión, integrando validaciones y almacenamiento seguro de tokens. 
    También se espera documentación del flujo y explicación sobre seguridad de datos en aplicaciones móviles universitarias.',
        'Conocimiento en Supabase Auth y manejo de sesiones en Flutter.',
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      16.50,
      29.75,
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
      (14),
      (15),
      (16)
  ) as v (skill_id);

-- Project 7: Implementación de almacenamiento en la nube con Supabase Storage
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
        'Implementación de almacenamiento en la nube con Supabase Storage',
        'Necesito orientación para configurar el almacenamiento de archivos (imágenes y documentos PDF) en Supabase Storage dentro de una app Flutter. 
    Se busca aprender sobre carga, descarga, manejo de permisos y limitaciones de tamaño. 
    El propósito es implementar esta funcionalidad en un proyecto académico que gestiona entregas de trabajos estudiantiles.',
        'Conocimiento en manejo de archivos y Supabase Storage.',
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      17.25,
      31.00,
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
      (17),
      (18)
  ) as v (skill_id);

-- Project 8: Tutoría sobre Riverpod y manejo de estado avanzado
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
        'Tutoría sobre Riverpod y manejo de estado avanzado',
        'Requiero tutoría para comprender el patrón de manejo de estado con Riverpod. 
    El objetivo es aprender a estructurar providers, refactorizar widgets y optimizar el rendimiento en una app universitaria. 
    El acompañamiento incluirá ejemplos prácticos, buenas prácticas de arquitectura y explicación del ciclo de vida de los providers.',
        'Conocimiento en Riverpod y patrones de arquitectura limpia.',
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      18.00,
      32.50,
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
      (19),
      (20),
      (21)
  ) as v (skill_id);

-- Project 9: Integración de notificaciones locales y push
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
        'Integración de notificaciones locales y push',
        'El objetivo es integrar notificaciones locales y push en una aplicación Flutter universitaria, 
    permitiendo recordar entregas, reuniones o mensajes internos. 
    Se busca combinar paquetes como flutter_local_notifications y Firebase Cloud Messaging, 
    aprendiendo a manejar permisos y eventos en segundo plano.',
        'Conocimiento en notificaciones FCM y manejo de background tasks.',
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      16.00,
      30.00,
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
      (22),
      (23)
  ) as v (skill_id);

-- Project 10: Optimización de rendimiento y lazy loading en Flutter
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
        'Optimización de rendimiento y lazy loading en Flutter',
        'Busco apoyo para optimizar el rendimiento de una app Flutter que maneja listas grandes de información académica. 
    Se espera aprender técnicas de lazy loading, paginación y renderizado eficiente, así como el uso de herramientas de profiling. 
    También se busca comprender cómo reducir el consumo de memoria y mejorar la fluidez general del proyecto.',
        'Conocimiento en optimización de rendimiento y lazy loading en Flutter.',
        '2dae045f-3775-468f-bd10-e4c51154a50b',
        3
      ) returning id
  ),
  pay as (
    insert into
      project_payment (min, max, currency, type, project_id)
    select
      19.00,
      34.50,
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

COMMIT;