import type { Metadata } from 'next';
import { Analytics } from '@vercel/analytics/next';
import './globals.css';

export const metadata: Metadata = {
  title: 'Paralelo — Marketplace académico para estudiantes',
  description:
    'Publica proyectos, recibe propuestas y conecta con estudiantes universitarios verificados para tutorías, asesorías y apoyo académico. Ofrece tus habilidades y gana dinero mientras estudias.',
  generator: 'v0.app',
  viewport: {
    width: 'device-width',
    initialScale: 1,
    maximumScale: 5,
  },
  alternates: {
    canonical: 'https://paralelo.ec',
  },
  icons: '/favicon.ico',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <body className="font-sans antialiased">
        {children}
        <Analytics />
      </body>
    </html>
  );
}
