-- ============================================================
-- User 5: Ingeniería Ambiental / Energías Renovables
-- Owner: 93a26416-a3d3-4678-b5c4-55cfa00fe1fc
-- Base category_id: 11
-- ============================================================
BEGIN;

-- Project 1: Evaluación de calidad de agua en fuentes naturales
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
        'Evaluación de calidad de agua en fuentes naturales',
        'Busco orientación para realizar un estudio básico de calidad de agua en quebradas cercanas al campus universitario. 
    El objetivo es aprender a identificar parámetros fisicoquímicos como pH, conductividad, oxígeno disuelto y turbidez, así como interpretar los resultados en función de la normativa ambiental ecuatoriana. 
    Se requiere apoyo en la estructura del informe, análisis de resultados y presentación gráfica de los datos. 
    Este proyecto busca combinar teoría con práctica de campo, fomentando la comprensión del monitoreo ambiental real.',
        'Conocimiento en análisis de calidad de agua y normativa ambiental.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      14.50,
      27.50,
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
      (81),
      (82),
      (83)
  ) AS v (skill_id);

-- Project 2: Elaboración de plan de manejo de residuos sólidos universitarios
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
        'Elaboración de plan de manejo de residuos sólidos universitarios',
        'Se requiere asistencia para elaborar un plan de gestión de residuos sólidos en el campus universitario, 
    considerando la generación por facultades, áreas verdes y cafeterías. 
    El proyecto busca definir estrategias de separación en la fuente, recolección, almacenamiento temporal y disposición final. 
    Además, se espera incluir medidas educativas y de sensibilización ambiental adaptadas al contexto estudiantil.',
        'Conocimiento en gestión integral de residuos y educación ambiental.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      15.00,
      29.00,
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
      (85)
  ) AS v (skill_id);

-- Project 3: Modelación de escorrentía en microcuencas urbanas
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
        'Modelación de escorrentía en microcuencas urbanas',
        'Necesito apoyo para aplicar el método del Número de Curva (CN) en el cálculo de escorrentía superficial en zonas urbanas. 
    El estudio se centrará en una microcuenca local afectada por impermeabilización del suelo. 
    Se requiere orientación en el manejo de datos hidrometeorológicos, cálculo de infiltración y elaboración de mapas temáticos mediante SIG. 
    El objetivo es comprender cómo el crecimiento urbano influye en los procesos hidrológicos locales.',
        'Conocimiento en hidrología aplicada y uso de SIG.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      18.00,
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
      (86),
      (87),
      (88)
  ) AS v (skill_id);

-- Project 4: Análisis de impacto ambiental para proyecto académico
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
        'Análisis de impacto ambiental para proyecto académico',
        'Se busca tutoría para elaborar un análisis de impacto ambiental (AIA) de un proyecto académico de construcción de viveros. 
    Se desea comprender cómo identificar, valorar y jerarquizar impactos sobre componentes abióticos, bióticos y socioeconómicos. 
    El acompañamiento debe incluir guía sobre la matriz de Leopold, medidas de mitigación y elaboración de conclusiones. 
    Este proyecto tiene como propósito fortalecer las competencias en evaluación ambiental aplicada.',
        'Conocimiento en matrices de impacto ambiental y legislación básica.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      16.50,
      30.00,
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
      (89),
      (90)
  ) AS v (skill_id);

-- Project 5: Evaluación energética de sistemas fotovoltaicos pequeños
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
        'Evaluación energética de sistemas fotovoltaicos pequeños',
        'Requiero asesoría para realizar una evaluación técnica y económica de paneles solares a pequeña escala. 
    El proyecto busca analizar el potencial de generación, el rendimiento de módulos y la relación costo-beneficio en viviendas universitarias. 
    Se espera aprender a calcular la radiación solar disponible, estimar producción anual y representar resultados en gráficos comparativos. 
    Este trabajo combina energía renovable y sostenibilidad aplicada al entorno académico.',
        'Conocimiento en energía solar y balance energético básico.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      17.25,
      33.50,
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
      (91),
      (92),
      (93)
  ) AS v (skill_id);

-- Project 6: Evaluación del potencial de reuso de aguas grises
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
        'Evaluación del potencial de reuso de aguas grises',
        'Busco apoyo para evaluar la factibilidad del reuso de aguas grises en viviendas universitarias.  
    El proyecto abordará la caracterización básica del agua, estimación de caudales y posibles tratamientos domésticos.  
    Se espera orientación sobre parámetros de calidad y normativa aplicable para reuso seguro.',
        'Conocimiento en tratamiento y reuso de aguas grises.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      15.25,
      29.00,
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
      (94),
      (95)
  ) AS v (skill_id);

-- Project 7: Elaboración de inventario de emisiones en campus universitario
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
        'Elaboración de inventario de emisiones en campus universitario',
        'Requiero guía para estimar las emisiones de CO₂ generadas por consumo eléctrico y transporte en el campus.  
    Se busca aprender métodos de cálculo, factores de emisión y presentación de resultados en formato gráfico.  
    El acompañamiento debe incluir interpretación de resultados y propuestas de reducción.',
        'Conocimiento en cálculo de huella de carbono y GEI.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      14.75,
      30.00,
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
      (96),
      (97),
      (98)
  ) AS v (skill_id);

-- Project 8: Análisis de calidad del aire en zonas urbanas
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
        'Análisis de calidad del aire en zonas urbanas',
        'Se requiere apoyo para analizar registros de material particulado y gases contaminantes en áreas cercanas al campus.  
    El objetivo es interpretar tendencias, comparar con límites permisibles y proponer medidas de mitigación.  
    Se valorará orientación en representación gráfica y redacción técnica de resultados.',
        'Conocimiento en monitoreo y análisis de calidad del aire.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      13.50,
      27.50,
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
      (99),
      (100)
  ) AS v (skill_id);

-- Project 9: Diseño de sistema de captación de agua de lluvia
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
        'Diseño de sistema de captación de agua de lluvia',
        'Busco asesoría para diseñar un sistema de captación y almacenamiento de agua pluvial para uso doméstico.  
    Se requiere definir componentes básicos, cálculo de volumen, selección de materiales y análisis de viabilidad económica.  
    Este trabajo busca fomentar soluciones sostenibles y prácticas para comunidades locales.',
        'Conocimiento en hidráulica y sistemas de captación pluvial.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      16.00,
      33.50,
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
      (101),
      (102),
      (103)
  ) AS v (skill_id);

-- Project 10: Propuesta de educación ambiental para escuelas rurales
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
        'Propuesta de educación ambiental para escuelas rurales',
        'Necesito apoyo para elaborar un plan educativo sobre conservación del agua y residuos sólidos dirigido a niños de escuelas rurales.  
    El documento debe incluir objetivos, contenidos, actividades y materiales didácticos.  
    El enfoque es participativo y busca fortalecer la conciencia ambiental desde edades tempranas.',
        'Conocimiento en pedagogía ambiental y diseño de materiales didácticos.',
        '93a26416-a3d3-4678-b5c4-55cfa00fe1fc',
        11
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      12.75,
      25.00,
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
      (104),
      (105)
  ) AS v (skill_id);

COMMIT;