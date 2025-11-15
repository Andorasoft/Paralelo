import "./HowItWorks.css";

export function HowItWorks() {
  const steps = [
    {
      number: "1",
      title: "Publica tu proyecto",
      description:
        "Sube tu tarea, trabajo o proyecto académico. Elige la materia, agrega detalles, rango de presupuesto y fecha límite.",
    },
    {
      number: "2",
      title: "Recibe propuestas",
      description:
        "Estudiantes verificados te envían propuestas con precio, tiempo estimado y modalidad. Compara perfiles y elige a quién contratar.",
    },
    {
      number: "3",
      title: "Chatea y define entregables",
      description:
        "Usa el chat para aclarar dudas, compartir archivos y dejar claros los entregables antes de empezar.",
    },
    {
      number: "4",
      title: "Recibe la entrega y califica",
      description:
        "Revisa el trabajo, cierra el proyecto y deja una calificación para construir reputación dentro de Paralelo.",
    },
  ];

  return (
    <section id="how-it-works" className="hiw-section">
      <div className="hiw-container">
        <div className="hiw-header">
          <h2>Cómo funciona Paralelo</h2>
          <p>Obtén ayuda académica en cuatro pasos</p>
        </div>

        <div className="hiw-grid">
          {steps.map((step) => (
            <div key={step.number} className="hiw-card">
              <div className="hiw-number">{step.number}</div>
              <h3>{step.title}</h3>
              <p className="hiw-description">{step.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
