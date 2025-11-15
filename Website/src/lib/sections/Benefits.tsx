import "./Benefits.css";

export function Benefits() {
  const benefits = [
    {
      title: "Ahorra tiempo",
      description:
        "Publica tu proyecto y recibe propuestas rápido. Sin filas, sin procesos complicados, sin esperar días por ayuda.",
    },
    {
      title: "Gana dinero extra",
      description:
        "Ofrece tus habilidades académicas y genera ingresos mientras estudias, trabajando por proyecto.",
    },
    {
      title: "Comunidad verificada",
      description:
        "Conecta únicamente con estudiantes validados. Un entorno seguro con perfiles, reputación y chat integrado.",
    },
    {
      title: "Enfoque universitario",
      description:
        "Categorías pensadas para estudiantes: matemáticas, informes, programación, presentaciones y más.",
    },
  ];

  return (
    <section id="benefits" className="benefits-section">
      <div className="benefits-container">
        <div className="benefits-header">
          <h2>¿Por qué elegir Paralelo?</h2>
          <p>Hecho para estudiantes, por estudiantes</p>
        </div>

        <div className="benefits-grid">
          {benefits.map((benefit) => (
            <div key={benefit.title} className="benefit-item">
              <div className="benefit-icon">✓</div>
              <h3>{benefit.title}</h3>
              <p className="benefit-description">{benefit.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
