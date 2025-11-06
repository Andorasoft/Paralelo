-- ============================================================
-- Transaction: Insert base project categories for Paralelo
-- ============================================================
begin;

-- ===========================================
-- 📚 Academic & Tutoring
-- ===========================================
insert into
  "public"."category" (name, description)
values
  (
    'Tutorías universitarias',
    'Clases particulares o apoyo en materias universitarias.'
  ),
  (
    'Asesorías académicas',
    'Asistencia en proyectos, tareas o investigaciones académicas.'
  ),
  (
    'Corrección de tesis y ensayos',
    'Revisión de estilo, formato y redacción de trabajos académicos.'
  ),
  (
    'Traducción y revisión de textos',
    'Traducción técnica y corrección de documentos en varios idiomas.'
  ),
  (
    'Elaboración de informes y presentaciones',
    'Diseño y redacción de informes técnicos o académicos.'
  ),
  (
    'Clases en línea',
    'Tutorías virtuales individuales o grupales mediante videollamada.'
  ),
  (
    'Consultoría en investigación científica',
    'Apoyo metodológico y estadístico en investigaciones.'
  ),
  (
    'Redacción académica',
    'Elaboración de textos con normas APA o científicas.'
  ),
  (
    'Análisis estadístico y manejo de datos',
    'Procesamiento y análisis de datos en software como SPSS, R o Python.'
  ),
  (
    'Modelación y simulación académica',
    'Creación de modelos numéricos o conceptuales para trabajos académicos.'
  ),
  -- ===========================================
  -- 💻 Technology & Development
  -- ===========================================
  (
    'Desarrollo web',
    'Creación y mantenimiento de sitios o aplicaciones web.'
  ),
  (
    'Desarrollo móvil',
    'Aplicaciones nativas o híbridas para Android e iOS.'
  ),
  (
    'Desarrollo backend / API',
    'Diseño de servicios y APIs RESTful o GraphQL.'
  ),
  (
    'Inteligencia artificial y machine learning',
    'Modelos predictivos, clasificación y análisis de datos.'
  ),
  (
    'Bases de datos y SQL',
    'Diseño, consultas y optimización de bases de datos.'
  ),
  (
    'Ciberseguridad y redes',
    'Configuración, auditoría y protección de sistemas informáticos.'
  ),
  (
    'Pruebas de software y QA',
    'Testing funcional, unitario y de rendimiento.'
  ),
  (
    'Soporte técnico e instalación de sistemas',
    'Asistencia en hardware, software y configuración.'
  ),
  (
    'Automatización de tareas / scripts',
    'Desarrollo de scripts para optimizar procesos repetitivos.'
  ),
  (
    'Implementación de Supabase, Firebase o Flutter',
    'Integración de plataformas modernas de desarrollo.'
  ),
  -- ===========================================
  -- 🎨 Design & Creativity
  -- ===========================================
  (
    'Diseño gráfico',
    'Creación de piezas visuales y material publicitario.'
  ),
  (
    'Diseño UX/UI',
    'Diseño de interfaces de usuario y experiencia interactiva.'
  ),
  (
    'Edición de video',
    'Producción y edición audiovisual para redes o proyectos.'
  ),
  (
    'Fotografía y retoque digital',
    'Captura y mejora de imágenes profesionales.'
  ),
  (
    'Animación 2D / 3D',
    'Creación de animaciones y gráficos en movimiento.'
  ),
  (
    'Diseño de marca y logotipos',
    'Construcción de identidad visual y branding.'
  ),
  (
    'Ilustración digital',
    'Diseños personalizados e ilustraciones artísticas.'
  ),
  (
    'Maquetación de portafolios académicos',
    'Diseño de portafolios y presentaciones profesionales.'
  ),
  -- ===========================================
  -- 📈 Marketing & Communication
  -- ===========================================
  (
    'Marketing digital',
    'Estrategias para promoción y posicionamiento en línea.'
  ),
  (
    'Community management',
    'Gestión de redes sociales y comunidades digitales.'
  ),
  (
    'Redacción publicitaria',
    'Creación de textos persuasivos y contenidos promocionales.'
  ),
  (
    'SEO / SEM',
    'Optimización de contenido y campañas de búsqueda.'
  ),
  (
    'Campañas universitarias',
    'Promoción de eventos y servicios dentro de comunidades académicas.'
  ),
  (
    'Creación de contenido y copywriting',
    'Desarrollo de materiales comunicativos creativos.'
  ),
  (
    'Diseño de piezas promocionales',
    'Creación de carteles, flyers y material gráfico.'
  ),
  (
    'Email marketing',
    'Diseño y automatización de campañas por correo electrónico.'
  ),
  -- ===========================================
  -- 🧮 Finance & Business
  -- ===========================================
  (
    'Contabilidad básica y fiscalidad',
    'Gestión de finanzas personales o de pequeños negocios.'
  ),
  (
    'Planes de negocio / Canvas',
    'Diseño y validación de modelos de negocio.'
  ),
  (
    'Análisis financiero',
    'Evaluación de rentabilidad y presupuestos.'
  ),
  (
    'Economía y microemprendimiento',
    'Desarrollo de pequeños proyectos productivos.'
  ),
  (
    'Gestión de proyectos',
    'Planificación, control y seguimiento de proyectos.'
  ),
  (
    'Asesoría en emprendimientos estudiantiles',
    'Apoyo a iniciativas universitarias o startups.'
  ),
  -- ===========================================
  -- 🌱 Environment & Sustainability
  -- ===========================================
  (
    'Consultoría ambiental',
    'Asesoría en proyectos de gestión ambiental.'
  ),
  (
    'Evaluación de impacto ambiental',
    'Análisis de efectos ambientales de proyectos.'
  ),
  (
    'Sistemas de gestión ambiental',
    'Implementación de normas ISO 14001 y similares.'
  ),
  (
    'Cartografía y SIG',
    'Uso de herramientas como QGIS y ArcGIS.'
  ),
  (
    'Hidrología y modelación ambiental',
    'Modelos de cuencas, calidad del agua y recarga.'
  ),
  (
    'Gestión de residuos',
    'Manejo integral y reciclaje de desechos.'
  ),
  (
    'Educación ambiental',
    'Capacitaciones y programas de sensibilización.'
  ),
  -- ===========================================
  -- ⚙️ Engineering & Sciences
  -- ===========================================
  (
    'Ingeniería civil',
    'Diseño estructural y planificación de obras.'
  ),
  (
    'Ingeniería eléctrica',
    'Instalaciones y diseño de sistemas eléctricos.'
  ),
  (
    'Ingeniería mecánica',
    'Diseño y mantenimiento de sistemas mecánicos.'
  ),
  (
    'Ingeniería química',
    'Procesos químicos y control de calidad.'
  ),
  (
    'Ingeniería ambiental',
    'Monitoreo y mitigación de impactos ambientales.'
  ),
  (
    'Ciencias naturales y biológicas',
    'Análisis y estudios científicos aplicados.'
  ),
  (
    'Física aplicada',
    'Modelos físicos y experimentación.'
  ),
  (
    'Matemáticas avanzadas',
    'Resolución de problemas y modelado matemático.'
  ),
  -- ===========================================
  -- 🎓 Education & Training
  -- ===========================================
  (
    'Creación de cursos o guías',
    'Desarrollo de materiales educativos.'
  ),
  (
    'Tutorías escolares',
    'Apoyo académico en niveles básicos o medios.'
  ),
  (
    'Preparación para exámenes',
    'Clases de refuerzo y simulacros de evaluación.'
  ),
  (
    'Capacitación institucional',
    'Formación profesional para grupos o empresas.'
  ),
  (
    'Mentorías profesionales',
    'Acompañamiento personalizado en desarrollo profesional.'
  ),
  -- ===========================================
  -- 💬 Languages
  -- ===========================================
  (
    'Traducción de documentos',
    'Traducción técnica, académica o literaria.'
  ),
  (
    'Tutorías de idiomas',
    'Clases personalizadas de inglés, francés, alemán u otros.'
  ),
  (
    'Preparación para exámenes internacionales',
    'Entrenamiento TOEFL, IELTS, DELF, etc.'
  ),
  (
    'Corrección de gramática y estilo',
    'Revisión lingüística y ortográfica.'
  ),
  -- ===========================================
  -- 💼 University General Services
  -- ===========================================
  (
    'Diseño de portafolio profesional',
    'Creación de portafolios académicos o laborales.'
  ),
  (
    'Elaboración de CV y carta de presentación',
    'Diseño de hoja de vida profesional.'
  ),
  (
    'Asesoría para becas y prácticas',
    'Apoyo en postulación a programas académicos.'
  ),
  (
    'Gestión de trámites universitarios',
    'Ayuda en procesos y documentación institucional.'
  ),
  (
    'Diseño de presentaciones científicas',
    'Elaboración de diapositivas y posters académicos.'
  ),
  -- ===========================================
  -- 🧠 Innovation & Entrepreneurship
  -- ===========================================
  (
    'Ideación de startups',
    'Desarrollo de ideas y validación de modelos de negocio.'
  ),
  (
    'Diseño de productos y prototipado',
    'Creación de MVPs o maquetas funcionales.'
  ),
  (
    'Investigación de mercado',
    'Análisis de tendencias y validación de demanda.'
  ),
  (
    'Presentaciones para inversores',
    'Diseño de pitch decks y material de inversión.'
  ),
  (
    'Estrategia de innovación social',
    'Proyectos con impacto en comunidades o sostenibilidad.'
  );

commit;