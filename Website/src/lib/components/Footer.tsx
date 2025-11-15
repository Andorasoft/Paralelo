import "./Footer.css";

export function Footer() {
  const currentYear = new Date(2025, 1, 1).getFullYear();

  return (
    <footer className="footer">
      <div className="footer-container">

        <div className="footer-grid">
          {/* Logo + description */}
          <div>
            <h3 className="footer-logo">Paralelo</h3>
            <p className="footer-muted">
              El marketplace académico hecho por estudiantes, para estudiantes.
            </p>
          </div>

          {/* Product */}
          <div>
            <h4 className="footer-title">Producto</h4>
            <ul className="footer-list">
              <li><a href="#how-it-works">Cómo funciona</a></li>
              <li><a href="#features">Funciones</a></li>
              <li><a href="#benefits">Beneficios</a></li>
            </ul>
          </div>

          {/* Company */}
          <div>
            <h4 className="footer-title">Compañía</h4>
            <ul className="footer-list">
              <li><a href="#">Sobre nosotros</a></li>
              <li><a href="mailto:contact@andorasoft.com">Contacto</a></li>
            </ul>
          </div>

          {/* Legal */}
          <div>
            <h4 className="footer-title">Legal</h4>
            <ul className="footer-list">
              <li><a href="/terms-of-service">Términos de uso</a></li>
              <li><a href="/privacy-policy">Política de privacidad</a></li>
            </ul>
          </div>
        </div>

        {/* Bottom */}
        <div className="footer-bottom">
          <p>© {currentYear} Paralelo. Todos los derechos reservados.</p>

          <div className="footer-socials">
            <a href="#">Twitter</a>
            <a href="#">Instagram</a>
            <a href="#">LinkedIn</a>
          </div>
        </div>

      </div>
    </footer>
  );
}
