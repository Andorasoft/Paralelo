import "./Download.css";

export function Download() {
  return (
    <section className="download-section">
      <div className="download-container">
        <h2>Descarga Paralelo hoy</h2>
        <p>Disponible para iOS y Android</p>

        <div className="download-buttons">
          <button className="btn-dark">
            <span>📱</span>
            App Store (iOS)
          </button>

          <button className="btn-primary">
            <span>📱</span>
            Google Play (Android)
          </button>
        </div>
      </div>
    </section>
  );
}
