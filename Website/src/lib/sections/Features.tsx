import "./Features.css";

export function Features() {
  const features = [
    {
      icon: "👥",
      title: "Roles dinámicos",
      description:
        "Cambia entre solicitar ayuda u ofrecer tus habilidades. Un mismo usuario puede contratar o trabajar según lo necesite.",
    },
    {
      icon: "💬",
      title: "Chat en tiempo real",
      description:
        "Mensajería rápida y segura integrada al proyecto. Comparte archivos y coordina entregables fácilmente.",
    },
    {
      icon: "📋",
      title: "Contratos claros",
      description:
        "Estados, entregables y requisitos definidos. Transparencia para estudiantes y proveedores antes de iniciar el trabajo.",
    },
    {
      icon: "⭐",
      title: "Sistema de reputación",
      description:
        "Calificaciones verificadas después de cada proyecto. Construye confianza y encuentra a los mejores perfiles.",
    },
  ];

  return (
    <section id="features" className="features-section">
      <div className="features-container">
        <div className="features-header">
          <h2>Funcionalidades principales</h2>
          <p>Todo lo que necesitas para trabajar y colaborar con seguridad</p>
        </div>

        <div className="features-grid">
          {features.map((feature) => (
            <div key={feature.title} className="feature-card">
              <div className="feature-icon">{feature.icon}</div>
              <div>
                <h3>{feature.title}</h3>
                <p className="feature-description">{feature.description}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
