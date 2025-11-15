import "./Testimonials.css";

export function Testimonials() {
  const testimonials = [
    {
      text: "Publicar mi proyecto de cálculo fue súper rápido. Recibí varias propuestas y encontré a alguien que me explicó todo con paciencia.",
      author: "Ana Torres",
      role: "Estudiante de Ingeniería",
    },
    {
      text: "Paralelo me permite usar mis habilidades para ganar un ingreso extra. Ayudo a otros con redacción y al mismo tiempo construyo mi reputación.",
      author: "David Ramos",
      role: "Estudiante de Letras",
    },
    {
      text: "El chat y los entregables definidos me dieron confianza. Sabía exactamente qué iba a recibir y pude revisar todo antes de cerrar el proyecto.",
      author: "María López",
      role: "Estudiante de Medicina",
    },
  ];

  return (
    <section id="testimonials" className="testimonials-section">
      <div className="testimonials-container">

        <div className="testimonials-header">
          <h2>Lo que dicen los estudiantes</h2>
          <p>Historias reales de nuestra comunidad universitaria</p>
        </div>

        <div className="testimonials-grid">
          {testimonials.map((testimonial) => (
            <div key={testimonial.author} className="testimonial-card">
              <div className="testimonial-stars">
                {[...Array(5)].map((_, i) => (
                  <span key={i} className="star">★</span>
                ))}
              </div>

              <p className="testimonial-text">"{testimonial.text}"</p>

              <div>
                <p className="testimonial-author">{testimonial.author}</p>
                <p className="testimonial-role">{testimonial.role}</p>
              </div>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
}
