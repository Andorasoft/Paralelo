'use client'

import { Menu, X } from 'lucide-react';
import { useState } from 'react';

import './Header.css';

export function Header() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  return (
    <header className="header">
      <nav className="nav">
        <a href="/" className="logo">Paralelo</a>

        {/* Desktop Navigation */}
        <div className="nav-desktop">
          <a href="#how-it-works">Cómo funciona</a>
          <a href="#features">Funciones</a>
          <a href="#benefits">Beneficios</a>
          <a href="#faq">Preguntas frecuentes</a>
          <button className="btn-primary">Crear cuenta</button>
        </div>

        {/* Mobile Menu Toggle */}
        <button
          className="mobile-toggle"
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
        >
          {mobileMenuOpen ? <X size={24} /> : <Menu size={24} />}
        </button>

        {/* Mobile Menu */}
        {mobileMenuOpen && (
          <div className="mobile-menu">
            <div className="mobile-menu-inner">
              <a href="#how-it-works">Cómo funciona</a>
              <a href="#features">Funciones</a>
              <a href="#benefits">Beneficios</a>
              <a href="#faq">Preguntas frecuentes</a>
              <button className="btn-primary full">Crear cuenta</button>
            </div>
          </div>
        )}
      </nav>
    </header>
  );
}
