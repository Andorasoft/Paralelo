import "./Hero.css";

export function Hero() {
  return (
    <section className="hero">
      <div className="hero-container">

        {/* Left Content */}
        <div className="hero-text">
          <h1>
            Ayuda académica, <span className="highlight">a tu manera</span>
          </h1>

          <p className="description">
            Conecta con estudiantes verificados para recibir tutorías, apoyo con tareas,
            correcciones y más. Contrata con confianza o comparte tus habilidades y gana dinero.
          </p>

          <div className="hero-buttons">
            <button className="btn-primary">Descargar App</button>
            <button className="btn-outline">Explorar Servicios</button>
          </div>
        </div>

        {/* Right Mockup */}
        <div className="hero-mockup">
          <div className="mockup-box">
            <div className="mockup-inner">
              <div className="mockup-icon">📱</div>
              <p className="mockup-text">App Preview</p>
              <p className="mockup-subtext">Tu marketplace académico seguro</p>
            </div>
          </div>
        </div>

      </div>
    </section>
  );
}
