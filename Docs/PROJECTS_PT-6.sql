-- ============================================================
-- User 6: Estadística / Análisis de Datos / Inteligencia Artificial
-- Owner: b4e74d1e-5940-462e-85d5-7a85dcf8e115
-- Base category_id: 13
-- ============================================================
BEGIN;

-- Project 1: Análisis descriptivo de datos climáticos con Python
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
        'Análisis descriptivo de datos climáticos con Python',
        'Busco apoyo para realizar un análisis descriptivo de datos climáticos obtenidos de estaciones locales. 
    Se espera aprender a limpiar y procesar información en CSV, aplicar estadísticas básicas (media, mediana, desviación estándar) 
    y representar los resultados mediante gráficos simples usando pandas y matplotlib. 
    El objetivo es comprender la variabilidad de la temperatura y precipitación en la región, y elaborar un pequeño informe de resultados.',
        'Conocimiento en Python, pandas y análisis descriptivo.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      11.50,
      22.00,
      'USD',
      'HOURLY',
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

-- Project 2: Tutoría en regresión lineal aplicada a proyectos ambientales
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
        'Tutoría en regresión lineal aplicada a proyectos ambientales',
        'Requiero una tutoría personalizada para entender cómo aplicar regresión lineal en análisis ambientales. 
    El objetivo es aprender a relacionar variables como precipitación, temperatura y escorrentía, 
    empleando herramientas como Excel o Python (scikit-learn). 
    El acompañamiento debe incluir interpretación de coeficientes, validación del modelo y análisis de errores. 
    Ideal para estudiantes que deseen incorporar análisis estadísticos en investigaciones reales.',
        'Conocimiento en regresión lineal y estadística inferencial.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      12.75,
      25.00,
      'USD',
      'HOURLY',
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

-- Project 3: Visualización de datos académicos en Power BI
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
        'Visualización de datos académicos en Power BI',
        'Se busca ayuda para crear paneles interactivos en Power BI que muestren información sobre rendimiento académico de estudiantes. 
    El proyecto incluye limpieza de datos, creación de medidas DAX básicas y diseño de dashboards intuitivos. 
    Se espera un acompañamiento orientado a la interpretación de resultados y presentación visual de indicadores clave. 
    El objetivo es desarrollar habilidades en comunicación de datos y storytelling visual aplicado a la educación.',
        'Conocimiento en Power BI y visualización de datos.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      13.00,
      26.25,
      'USD',
      'HOURLY',
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
      (106),
      (107),
      (108)
  ) AS v (skill_id);

-- Project 4: Clasificación de datos con algoritmos de Machine Learning
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
        'Clasificación de datos con algoritmos de Machine Learning',
        'Necesito orientación para aplicar algoritmos de clasificación (árboles de decisión, KNN o regresión logística) a un conjunto de datos universitarios. 
    Se busca comprender la preparación de datos, entrenamiento del modelo y validación cruzada. 
    También se espera aprender a representar los resultados en matrices de confusión y gráficos de precisión. 
    El propósito es afianzar la comprensión práctica de los fundamentos de la inteligencia artificial.',
        'Conocimiento en scikit-learn y técnicas de clasificación.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      14.25,
      27.50,
      'USD',
      'HOURLY',
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
      (109),
      (110),
      (111)
  ) AS v (skill_id);

-- Project 5: Predicción de consumo energético mediante IA
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
        'Predicción de consumo energético mediante IA',
        'Se requiere apoyo para desarrollar un modelo predictivo de consumo energético utilizando técnicas de aprendizaje automático. 
    El proyecto tiene como objetivo usar datos históricos de consumo y variables climáticas para estimar la demanda futura. 
    Se espera aprender sobre preprocesamiento de datos, entrenamiento de modelos y evaluación de desempeño (R², MAE, RMSE). 
    El proyecto permitirá aplicar inteligencia artificial en un contexto real de sostenibilidad y eficiencia energética.',
        'Conocimiento en regresión múltiple y Machine Learning.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      15.00,
      29.00,
      'USD',
      'HOURLY',
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
      (112),
      (113),
      (114)
  ) AS v (skill_id);

-- Project 6: Análisis de correlación entre variables socioeconómicas
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
        'Análisis de correlación entre variables socioeconómicas',
        'Busco asesoría para realizar un análisis de correlación entre ingresos, nivel educativo y consumo energético en una muestra poblacional.  
    El objetivo es identificar relaciones lineales o no lineales entre las variables y representar los resultados con gráficos de dispersión.  
    También deseo aprender a interpretar coeficientes de Pearson y Spearman en Python o Excel.',
        'Conocimiento en análisis correlacional y uso de pandas.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      11.50,
      22.75,
      'USD',
      'HOURLY',
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
      (115),
      (116)
  ) AS v (skill_id);

-- Project 7: Construcción de modelo predictivo en RStudio
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
        'Construcción de modelo predictivo en RStudio',
        'Necesito orientación para desarrollar un modelo de predicción de demanda de transporte utilizando RStudio.  
    Se requiere guía sobre limpieza de datos, análisis exploratorio, selección de variables y evaluación del modelo mediante R² y MAE.  
    El acompañamiento incluirá interpretación de resultados y sugerencias para presentación de conclusiones en informe técnico.',
        'Conocimiento en RStudio y modelos predictivos básicos.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      13.25,
      26.00,
      'USD',
      'HOURLY',
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
      (117),
      (118),
      (119)
  ) AS v (skill_id);

-- Project 8: Implementación de análisis de componentes principales (PCA)
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
        'Implementación de análisis de componentes principales (PCA)',
        'Busco aprender cómo aplicar análisis de componentes principales a un conjunto de datos ambientales.  
    El propósito es reducir la dimensionalidad y visualizar agrupamientos de variables relevantes.  
    Se espera aprender a interpretar eigenvalores, cargas factoriales y biplots utilizando scikit-learn o R.',
        'Conocimiento en análisis multivariado y PCA.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      14.00,
      27.25,
      'USD',
      'HOURLY',
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
      (120),
      (121)
  ) AS v (skill_id);

-- Project 9: Introducción al análisis de series temporales con Python
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
        'Introducción al análisis de series temporales con Python',
        'Requiero apoyo para analizar una serie temporal de datos de temperatura y consumo eléctrico.  
    Se desea comprender los conceptos de tendencia, estacionalidad y ruido, así como aplicar modelos ARIMA simples.  
    El proyecto incluirá gráficos de evolución y validación del modelo con datos históricos.',
        'Conocimiento en series temporales y librería statsmodels.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      12.75,
      25.75,
      'USD',
      'HOURLY',
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
      (122),
      (123),
      (124)
  ) AS v (skill_id);

-- Project 10: Creación de panel interactivo de análisis de datos con Streamlit
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
        'Creación de panel interactivo de análisis de datos con Streamlit',
        'Busco asistencia para desarrollar un panel interactivo en Streamlit que permita visualizar datos de forma dinámica.  
    El proyecto incluirá carga de archivos CSV, selección de filtros, generación de gráficos y exportación de resultados.  
    Se busca aplicar fundamentos de visualización y diseño intuitivo orientado a usuarios no técnicos.',
        'Conocimiento en Python, Streamlit y visualización interactiva.',
        'b4e74d1e-5940-462e-85d5-7a85dcf8e115',
        13
      ) RETURNING id
  ),
  pay AS (
    INSERT INTO
      project_payment (min, max, currency, type, project_id)
    SELECT
      14.50,
      28.75,
      'USD',
      'HOURLY',
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
      (125),
      (126),
      (127)
  ) AS v (skill_id);

COMMIT;