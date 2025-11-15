'use client';

import { Footer } from "@/lib/components/Footer";
import { Header } from "@/lib/components/Header";
import { Benefits } from "@/lib/sections/Benefits";
import { Download } from "@/lib/sections/Download";
import { FAQ } from "@/lib/sections/FAQ";
import { Features } from "@/lib/sections/Features";
import { Hero } from "@/lib/sections/Hero";
import { HowItWorks } from "@/lib/sections/HowItWorks";
import { Testimonials } from "@/lib/sections/Testimonials";
import { UseCases } from "@/lib/sections/UseCases";

export default function Home() {
  return (
    <main>
      <Header />
      <Hero />
      <HowItWorks />
      <Features />
      <Benefits />
      <UseCases />
      <Testimonials />
      <Download />
      <FAQ />
      <Footer />
    </main>
  );
}
