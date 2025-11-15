import { Header } from '@/lib/components/Header';
import { Footer } from '@/lib/components/Footer';
import styles from './page.module.css';

export const metadata = {
  title: 'Términos de Servicio | Paralelo',
  description: 'Términos de Servicio de Paralelo — Marketplace académico digital.',
};

export default function TermsOfService() {
  return (
    <main className={styles['terms-page']}>
      <Header />

      <div className={styles['terms-container']}>
        <h1 className={styles['terms-title']}>Términos de Servicio</h1>

        <div className={styles['terms-content']}>

          <section>
            <h2>1. Objeto</h2>
            <p>
              Paralelo es una plataforma digital de intermediación académica que permite a los Usuarios publicar
              proyectos en los que requieren apoyo académico y recibir propuestas de otros Usuarios (“Proveedores”).
              Paralelo actúa únicamente como intermediario tecnológico y no forma parte de los acuerdos entre los
              Usuarios.
            </p>
          </section>

          <section>
            <h2>2. Aceptación de los Términos</h2>
            <p>
              Al acceder o utilizar la Plataforma, el Usuario declara ser mayor de 18 años, tener capacidad legal
              para contratar y aceptar plenamente estos Términos. Si no está de acuerdo, debe abstenerse de utilizar
              Paralelo.
            </p>
          </section>

          <section>
            <h2>3. Publicación de Proyectos</h2>
            <p>
              Los Usuarios que publican proyectos (“Solicitantes”) garantizan que la información proporcionada es
              veraz, clara y corresponde a necesidades legítimas de apoyo académico. Está prohibido solicitar la
              elaboración total de trabajos evaluados, exámenes, tesis u otras actividades consideradas fraude
              académico.
            </p>
          </section>

          <section>
            <h2>4. Propuestas y Prestación del Servicio</h2>
            <p>
              Los Proveedores que envían propuestas deben ofrecer información precisa, profesional y lícita. Al
              aceptar una propuesta, se forma un acuerdo bilateral exclusivo entre los Usuarios. Paralelo no interviene
              ni es responsable del cumplimiento, calidad o resultados del servicio.
            </p>
          </section>

          <section>
            <h2>5. Comunicación entre Usuarios</h2>
            <p>
              Paralelo ofrece un sistema de mensajería integrado como medio recomendado para las comunicaciones.
              Los Usuarios pueden optar por comunicarse fuera de la Plataforma, pero cualquier interacción externa se
              realiza bajo su propio riesgo. Paralelo se deslinda totalmente de acuerdos, incidentes o conflictos que
              ocurran fuera del chat integrado.
            </p>
          </section>

          <section>
            <h2>6. Servicios Presenciales</h2>
            <p>
              Los Usuarios pueden acordar encuentros presenciales, aunque Paralelo no los recomienda salvo estricta
              necesidad. Paralelo no verifica identidades físicas ni lugares de encuentro y no asume responsabilidad
              por incidentes, daños o situaciones derivadas de reuniones presenciales.
            </p>
          </section>

          <section>
            <h2>7. Pagos Externos</h2>
            <p>
              Paralelo no procesa pagos dentro de la aplicación. Todo pago se realiza fuera de la Plataforma mediante
              medios externos decididos entre los Usuarios. Paralelo no supervisa, garantiza ni respalda dichos pagos
              y no ofrece protección, reembolsos ni arbitraje financiero.
            </p>
          </section>

          <section>
            <h2>8. Contenido Generado por el Usuario</h2>
            <p>
              Cada Usuario es responsable del contenido que publica o envía. Se prohíbe subir material ilegal,
              ofensivo, fraudulento, protegido por derechos de autor sin permiso o que constituya fraude académico.
              El Usuario otorga a Paralelo una licencia limitada para almacenar y mostrar dicho contenido con fines
              operativos.
            </p>
          </section>

          <section>
            <h2>9. Actividades Prohibidas</h2>
            <p>
              El Usuario se compromete a no utilizar Paralelo para solicitar u ofrecer actividades que constituyan
              fraude académico, realizar suplantación de identidad, manipular reputaciones, interferir con la
              infraestructura de la Plataforma o coordinar actividades ilegales.
            </p>
          </section>

          <section>
            <h2>10. Calificaciones y Reputación</h2>
            <p>
              Tras finalizar un servicio, las partes pueden emitir una calificación. Estas son permanentes y visibles
              para otros Usuarios, salvo casos excepcionales de abuso o fraude.
            </p>
          </section>

          <section>
            <h2>11. Limitación de Responsabilidad</h2>
            <p>
              Paralelo no será responsable por relaciones entre Usuarios, incidentes presenciales, comunicaciones
              externas al chat, fallas técnicas, pérdidas económicas ni cualquier daño indirecto. La Plataforma se
              ofrece “tal cual” y “según disponibilidad”.
            </p>
          </section>

          <section>
            <h2>12. Suspensión de Cuenta</h2>
            <p>
              Paralelo podrá suspender o eliminar cuentas que incumplan estos Términos o presenten actividad
              sospechosa, fraudulenta o peligrosa.
            </p>
          </section>

          <section>
            <h2>13. Ley Aplicable</h2>
            <p>
              Estos Términos se rigen por las leyes del país en el que opera Paralelo y cualquier disputa será
              sometida a los tribunales competentes de dicho territorio.
            </p>
          </section>

          <section>
            <h2>14. Contacto</h2>
            <p>
              Para consultas o solicitudes, puede escribir a:<br />
              <strong>support@paralelo.app</strong>
            </p>
          </section>
        </div>
      </div>

      <Footer />
    </main>
  );
}
