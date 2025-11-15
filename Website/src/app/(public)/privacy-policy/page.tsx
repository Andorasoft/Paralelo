import { Header } from '@/lib/components/Header';
import { Footer } from '@/lib/components/Footer';
import styles from './page.module.css';

export const metadata = {
  title: 'Política de Privacidad | Paralelo',
  description: 'Política de Privacidad de Paralelo — Cómo protegemos y tratamos tus datos.',
};

export default function PrivacyPolicy() {
  const currentDate = new Date(2025, 11, 14)
    .toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });

  return (
    <main className={styles['privacy-page']}>
      <Header />

      <div className={styles['privacy-container']}>
        <h1 className={styles['privacy-title']}>Política de Privacidad</h1>

        <div className={styles['privacy-content']}>

          <section>
            <h2>1. Responsable del Tratamiento</h2>
            <p>
              Paralelo es responsable del tratamiento de los datos personales recopilados a través de la Plataforma.
              Si tienes dudas o solicitudes sobre privacidad, puedes contactarnos en <strong>support@paralelo.app</strong>.
            </p>
          </section>

          <section>
            <h2>2. Datos que Recopilamos</h2>
            <p>Recopilamos exclusivamente los datos necesarios para operar la Plataforma y garantizar su seguridad.</p>
            <ul>
              <li><strong>Datos proporcionados por el Usuario:</strong> nombre, correo electrónico, foto de perfil (opcional), información académica general, proyectos, propuestas y mensajes enviados.</li>
              <li><strong>Datos técnicos:</strong> dirección IP, tipo de dispositivo, sistema operativo, zona horaria, identificadores del dispositivo y registros de actividad.</li>
              <li><strong>Datos de uso:</strong> acciones dentro de la Plataforma como creación de proyectos, envío de propuestas, calificaciones y participación en chats.</li>
            </ul>
            <p>Paralelo no recopila datos financieros, ubicación precisa, contactos del dispositivo ni comunicaciones realizadas fuera de la Plataforma.</p>
          </section>

          <section>
            <h2>3. Finalidades del Tratamiento</h2>
            <p>Usamos tus datos para:</p>
            <ul>
              <li>Operar y mantener tu cuenta en la Plataforma.</li>
              <li>Facilitar la publicación de proyectos y el envío de propuestas.</li>
              <li>Permitir la comunicación mediante el chat integrado.</li>
              <li>Garantizar la seguridad e integridad del sistema.</li>
              <li>Mejorar la experiencia y funcionamiento de la Plataforma.</li>
              <li>Cumplir con obligaciones legales cuando corresponda.</li>
            </ul>
          </section>

          <section>
            <h2>4. Uso del Chat Integrado</h2>
            <p>
              El chat interno es el medio recomendado para comunicaciones. Los mensajes pueden almacenarse para fines
              operativos y de seguridad. Paralelo no accede a conversaciones externas (WhatsApp, llamadas, redes
              sociales). Cualquier comunicación fuera de la app se realiza bajo tu propia responsabilidad.
            </p>
          </section>

          <section>
            <h2>5. Servicios Presenciales</h2>
            <p>
              Si los Usuarios deciden reunirse presencialmente, lo hacen bajo su exclusiva responsabilidad. Paralelo
              no recopila información de ubicación, no verifica identidades presenciales y no es responsable por
              incidentes ocurridos fuera de la app.
            </p>
          </section>

          <section>
            <h2>6. Pagos Externos</h2>
            <p>
              Paralelo no procesa pagos ni almacena datos financieros. Cualquier pago ocurre mediante medios externos
              acordados entre los Usuarios. Paralelo no ofrece garantías, protección de pagos ni intermediación
              financiera.
            </p>
          </section>

          <section>
            <h2>7. Base Legal del Tratamiento</h2>
            <p>Dependiendo del contexto, tratamos los datos sobre la base de:</p>
            <ul>
              <li>Tu consentimiento.</li>
              <li>La necesidad contractual para operar tu cuenta.</li>
              <li>Interés legítimo en mantener la seguridad y funcionamiento adecuado.</li>
              <li>Cumplimiento de obligaciones legales.</li>
            </ul>
          </section>

          <section>
            <h2>8. Conservación de los Datos</h2>
            <p>
              Conservamos los datos únicamente mientras sean necesarios para los fines descritos o para cumplir con
              obligaciones legales. Posteriormente, se eliminan o anonimizan de manera segura.
            </p>
          </section>

          <section>
            <h2>9. Compartición de Datos</h2>
            <p>Paralelo no vende ni comercializa datos personales. Solo compartimos información con:</p>
            <ul>
              <li>Proveedores de servicios tecnológicos (alojamiento, mensajería push, autenticación).</li>
              <li>Autoridades competentes cuando exista obligación legal.</li>
              <li>Otros Usuarios, únicamente la información necesaria para interactuar dentro de la Plataforma.</li>
            </ul>
          </section>

          <section>
            <h2>10. Derechos del Usuario</h2>
            <p>Puedes ejercer tus derechos de acceso, rectificación, eliminación, oposición y portabilidad escribiendo a:</p>
            <p><strong>support@paralelo.app</strong></p>
            <p>Podemos solicitar verificación de identidad para procesar tu solicitud.</p>
          </section>

          <section>
            <h2>11. Seguridad de la Información</h2>
            <p>
              Implementamos medidas técnicas y organizativas razonables para proteger los datos personales, incluyendo
              cifrado en tránsito, controles de acceso y monitoreo de actividad inusual. Ningún sistema es completamente
              infalible.
            </p>
          </section>

          <section>
            <h2>12. Menores de Edad</h2>
            <p>
              Paralelo es una plataforma destinada exclusivamente a mayores de 18 años. Si detectamos datos de menores,
              serán eliminados.
            </p>
          </section>

          <section>
            <h2>13. Cambios a esta Política</h2>
            <p>
              Podemos actualizar esta Política en cualquier momento. Los cambios relevantes serán anunciados en la
              Plataforma. El uso continuado implica aceptación de la versión actualizada.
            </p>
          </section>

          <section>
            <h2>14. Contacto</h2>
            <p>
              Para cualquier consulta sobre privacidad, puedes escribirnos a:
              <br />
              <strong>support@paralelo.app</strong>
              <br />
              <strong>Última actualización:</strong> {currentDate}
            </p>
          </section>
        </div>
      </div>

      <Footer />
    </main>
  );
}