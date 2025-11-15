'use client';

import { ChevronDown } from 'lucide-react';
import { useState } from 'react';
import "./FAQ.css";

export function FAQ() {
  const [openIndex, setOpenIndex] = useState(0);

  const faqs = [
    {
      question: '¿Es seguro usar Paralelo?',
      answer:
        'Sí. Solo permitimos estudiantes universitarios verificados y cada proyecto cuenta con propuestas, perfiles y calificaciones visibles. Además, todo se coordina mediante el chat interno para mantener un historial claro.',
    },
    {
      question: '¿Cómo funcionan los pagos?',
      answer:
        'Los pagos se coordinan directamente entre estudiantes una vez aceptada la propuesta. Paralelo no procesa pagos dentro de la app.',
    },
    {
      question: '¿Paralelo hace tareas por mí?',
      answer:
        'No. Los colaboradores ofrecen tutorías, guía, explicación, revisión y apoyo académico. No se permiten entregas completas que violen normas de integridad académica.',
    },
    {
      question: '¿Cómo elijo a la persona adecuada para mi proyecto?',
      answer:
        'Recibirás varias propuestas con precios estimados, tiempos y mensajes personalizados. Puedes revisar su perfil, experiencia y calificaciones antes de aceptar.',
    },
    {
      question: '¿Qué materias están disponibles?',
      answer:
        'Contamos con categorías universitarias como matemáticas, ingeniería, redacción, programación, presentaciones, investigación y más. Puedes explorar la lista completa dentro de la app.',
    },
    {
      question: '¿Cómo garantizan la calidad?',
      answer:
        'Cada proyecto se califica al finalizar. Las reseñas verificadas ayudan a mantener altos estándares y permiten identificar a los mejores colaboradores.',
    },
  ];

  return (
    <section id="faq" className="faq-section">
      <div className="faq-container">

        <div className="faq-header">
          <h2>Preguntas frecuentes</h2>
          <p>Resolvemos tus dudas antes de comenzar</p>
        </div>

        <div className="faq-list">
          {faqs.map((faq, index) => (
            <div key={index} className="faq-item">
              <button
                onClick={() => setOpenIndex(openIndex === index ? -1 : index)}
                className="faq-question"
              >
                <h3>{faq.question}</h3>

                <ChevronDown
                  size={20}
                  className={`faq-icon ${openIndex === index ? "rotated" : ""}`}
                />
              </button>

              {openIndex === index && (
                <div className="faq-answer">{faq.answer}</div>
              )}
            </div>
          ))}
        </div>

      </div>
    </section>
  );
}
