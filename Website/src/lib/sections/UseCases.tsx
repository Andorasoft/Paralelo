import "./UseCases.css";

export function UseCases() {
  const useCases = [
    {
      icon: "📚",
      title: "Tutorías",
      description: "Acompañamiento personalizado en cualquier materia universitaria."
    },
    {
      icon: "✍️",
      title: "Revisión de textos",
      description: "Corrección, retroalimentación y mejora de ensayos, informes y tareas escritas."
    },
    {
      icon: "🔢",
      title: "Matemáticas & Ingeniería",
      description: "Ayuda para entender ejercicios, procesos y métodos de cursos técnicos."
    },
    {
      icon: "🎤",
      title: "Presentaciones",
      description: "Preparación, diseño y práctica de presentaciones académicas."
    },
    {
      icon: "🔬",
      title: "Apoyo en investigación",
      description: "Orientación en métodos, estructura, fuentes y redacción técnica."
    },
    {
      icon: "📖",
      title: "Preparación de estudios",
      description: "Apoyo para exámenes, resúmenes y organización de grupos de estudio."
    }
  ];

  return (
    <section className="usecases-section">
      <div className="usecases-container">

        <div className="usecases-header">
          <h2>Servicios disponibles</h2>
          <p>Apoyo académico para cualquier necesidad universitaria</p>
        </div>

        <div className="usecases-grid">
          {useCases.map((useCase) => (
            <div key={useCase.title} className="usecase-card">
              <div className="usecase-icon">{useCase.icon}</div>
              <h3>{useCase.title}</h3>
              <p className="usecase-description">{useCase.description}</p>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
}
