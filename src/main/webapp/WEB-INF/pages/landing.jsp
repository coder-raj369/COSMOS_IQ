<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Explore the Cosmos</title>
<%@ include file="common/head.jspf" %>
<style>
/* ── Hero animations ── */
@keyframes heroTitleIn { from{opacity:0;transform:translateY(60px);filter:blur(12px)} to{opacity:1;transform:none;filter:none} }
@keyframes heroBadgeIn { from{opacity:0;transform:translateY(-20px)} to{opacity:1;transform:none} }
@keyframes earthEntrance { from{opacity:0;transform:scale(0.75)} to{opacity:0.45;transform:scale(1)} }
@keyframes earthFloat { 0%,100%{transform:scale(1) translateY(0)} 50%{transform:scale(1.025) translateY(-12px)} }
@keyframes scrollLine { from{height:0} to{height:80px} }
@keyframes arrowBounce { 0%,100%{transform:translateY(0)} 50%{transform:translateY(8px)} }
/* Orbital panels emerge from behind the earth */
@keyframes emergeLeft  { from{opacity:0;transform:translateX(80px);filter:blur(10px)} to{opacity:1;transform:translateX(0);filter:none} }
@keyframes emergeRight { from{opacity:0;transform:translateX(-80px);filter:blur(10px)} to{opacity:1;transform:translateX(0);filter:none} }
@keyframes dataFlicker { 0%,100%{opacity:1} 92%{opacity:1} 93%{opacity:.35} 94%{opacity:1} 97%{opacity:.65} 98%{opacity:1} }
@keyframes glowPulse { 0%,100%{box-shadow:0 0 30px rgba(109,221,255,.2)} 50%{box-shadow:0 0 60px rgba(109,221,255,.5)} }
@keyframes cos-marquee { from{transform:translateX(0)} to{transform:translateX(-50%)} }

.hero-word-1 { animation: heroTitleIn 1s .1s  both cubic-bezier(.16,1,.3,1); }
.hero-word-2 { animation: heroTitleIn 1s .3s  both cubic-bezier(.16,1,.3,1); }
.hero-sub    { animation: heroTitleIn 1s .55s both cubic-bezier(.16,1,.3,1); }
.hero-cta    { animation: heroTitleIn 1s .75s both cubic-bezier(.16,1,.3,1); }
.hero-badge  { animation: heroBadgeIn .7s .05s both ease-out; }
.earth-img   { animation: earthEntrance 1.8s .2s both ease-out, earthFloat 14s 2s ease-in-out infinite; }
.scroll-line { animation: scrollLine 1.2s 1.4s both ease-out; }
.scroll-arrow-anim { animation: arrowBounce 2s ease-in-out infinite; }
.cta-btn-primary { animation: glowPulse 3s ease-in-out infinite; }

/* Orbital side panels */
.orbital-panel-left  { animation: emergeLeft  1s 1.15s both cubic-bezier(.16,1,.3,1); }
.orbital-panel-right { animation: emergeRight 1s 1.15s both cubic-bezier(.16,1,.3,1); }
.orbital-value { animation: dataFlicker 7s 3.5s ease-in-out infinite; }
.orbital-sep { width:1px; height:36px; background:linear-gradient(to bottom,transparent,rgba(109,221,255,.3),transparent); }

/* ── Marquee ── */
.marquee-track { animation: cos-marquee 32s linear infinite; white-space:nowrap; will-change:transform; }
.marquee-track:hover { animation-play-state:paused; }
.marquee-item { display:inline-flex; align-items:center; gap:24px; padding:0 24px; }
.marquee-dot  { width:4px; height:4px; border-radius:50%; background:rgba(109,221,255,.4); flex-shrink:0; }

/* ── Pin scroll ── */
#features-pin-section .pin-sticky { background:#05060d; }
.pin-number { font-size:clamp(280px,35vw,480px); line-height:1; color:rgba(109,221,255,0.04); font-family:'Noto Serif',serif; font-style:italic; font-weight:300; position:absolute; right:-4vw; bottom:-0.15em; pointer-events:none; user-select:none; }
.feature-link { display:inline-flex; align-items:center; gap:12px; font-family:'Space Grotesk',sans-serif; font-size:11px; letter-spacing:.2em; text-transform:uppercase; color:#6dddff; transition:gap .3s ease; }
.feature-link:hover { gap:20px; }
.feature-icon-ring { width:220px; height:220px; border-radius:50%; border:1px solid rgba(109,221,255,.15); display:flex; align-items:center; justify-content:center; background:radial-gradient(circle,rgba(109,221,255,.06) 0%,transparent 70%); flex-shrink:0; }
#pin-progress-bar { position:absolute; bottom:0; left:0; height:2px; background:linear-gradient(to right,#6dddff,rgba(109,221,255,.3)); width:0%; transition:width .45s cubic-bezier(.25,.46,.45,.94); z-index:40; }
#pin-panel-label  { position:absolute; bottom:28px; left:50%; transform:translateX(-50%); font-family:'Space Grotesk',sans-serif; font-size:10px; letter-spacing:.4em; text-transform:uppercase; color:rgba(109,221,255,.35); z-index:40; white-space:nowrap; }
.pin-accent { position:absolute; left:0; top:0; bottom:0; width:3px; transition:background .6s ease; }

/* ── Stats ── */
.stat-cell { border-right:1px solid rgba(255,255,255,.06); }
.stat-cell:last-child { border-right:none; }
</style>
</head>
<body class="bg-surface text-on-surface font-body selection:bg-primary selection:text-on-primary-container overflow-x-hidden">
<div class="grain-overlay"></div>

<!-- ── Navbar ── -->
<nav class="fixed top-4 left-1/2 -translate-x-1/2 w-[95%] rounded-full border border-white/10 bg-slate-950/60 backdrop-blur-3xl z-50 flex justify-between items-center px-8 py-3 max-w-7xl mx-auto shadow-[0_20px_50px_rgba(0,0,0,0.5)]">
  <a class="text-2xl font-serif italic text-white hover:rotate-12 transition-transform duration-700" href="#">CosmosIQ</a>
  <div class="hidden md:flex gap-8 items-center">
    <a class="font-serif text-lg tracking-tight uppercase text-slate-300 hover:text-white transition-all" href="${pageContext.request.contextPath}/about">About</a>
    <a class="font-serif text-lg tracking-tight uppercase text-slate-300 hover:text-white transition-all" href="${pageContext.request.contextPath}/contact">Contact</a>
  </div>
  <a href="${pageContext.request.contextPath}/login" class="bg-primary text-on-primary px-6 py-1.5 rounded-full font-label text-sm font-bold uppercase tracking-widest hover:shadow-[0_0_20px_rgba(109,221,255,0.4)] transition-all">Launch</a>
</nav>

<!-- ══════════════════════════════════════════════════════════
     HERO
══════════════════════════════════════════════════════════ -->
<section class="relative min-h-screen flex flex-col items-center justify-center overflow-hidden" data-hero-section>
  <canvas id="starfield" class="absolute inset-0 w-full h-full pointer-events-none"></canvas>

  <!-- Earth globe -->
  <div class="absolute inset-0 flex items-center justify-center pointer-events-none" style="top:-5%">
    <img class="earth-img w-[90vw] max-w-[820px] aspect-square object-contain select-none"
         src="${pageContext.request.contextPath}/images/earth_PNG39.png" alt="Earth"/>
  </div>

  <!-- Glow overlays -->
  <div class="absolute inset-0 pointer-events-none" style="background:radial-gradient(ellipse 70% 60% at 50% 55%,rgba(109,221,255,.07) 0%,transparent 65%)"></div>
  <div class="absolute bottom-0 left-0 right-0 h-1/3 pointer-events-none" style="background:linear-gradient(to top,#0c0e16,transparent)"></div>

  <!-- Left orbital data panel — emerges from behind Earth -->
  <div class="absolute z-20 pointer-events-none hidden lg:block" style="left:max(28px,calc(50% - 560px));top:50%;transform:translateY(-50%)">
    <div class="orbital-panel-left flex flex-col gap-5 items-start">
      <div>
        <span class="font-label text-[8px] uppercase tracking-[0.4em] text-primary/45 block mb-1">Orbital Velocity</span>
        <span class="orbital-value font-headline italic text-[22px] text-primary leading-none">7.67 <span class="text-[11px] font-label tracking-[0.2em] text-primary/60">KM/S</span></span>
      </div>
      <div class="orbital-sep"></div>
      <div>
        <span class="font-label text-[8px] uppercase tracking-[0.4em] text-primary/45 block mb-1">Altitude</span>
        <span class="orbital-value font-headline italic text-[22px] text-primary leading-none">408 <span class="text-[11px] font-label tracking-[0.2em] text-primary/60">KM</span></span>
      </div>
      <div class="orbital-sep"></div>
      <div>
        <span class="font-label text-[8px] uppercase tracking-[0.4em] text-primary/45 block mb-1">Inclination</span>
        <span class="orbital-value font-headline italic text-[22px] text-primary leading-none">51.64<span class="text-[11px] font-label text-primary/60">°</span></span>
      </div>
    </div>
  </div>

  <!-- Right orbital data panel — emerges from behind Earth -->
  <div class="absolute z-20 pointer-events-none hidden lg:block" style="right:max(28px,calc(50% - 560px));top:50%;transform:translateY(-50%)">
    <div class="orbital-panel-right flex flex-col gap-5 items-end">
      <div class="text-right">
        <span class="font-label text-[8px] uppercase tracking-[0.4em] text-primary/45 block mb-1">Sector</span>
        <span class="orbital-value font-headline italic text-[22px] text-primary leading-none">Orion Arm</span>
      </div>
      <div class="orbital-sep self-end"></div>
      <div class="text-right">
        <span class="font-label text-[8px] uppercase tracking-[0.4em] text-primary/45 block mb-1">Coordinates</span>
        <span class="orbital-value font-headline italic text-[22px] text-primary leading-none">14.2<span class="text-[11px] font-label text-primary/60">.99.0</span></span>
      </div>
      <div class="orbital-sep self-end"></div>
      <div class="text-right">
        <span class="font-label text-[8px] uppercase tracking-[0.4em] text-primary/45 block mb-1">Status</span>
        <span class="orbital-value font-headline italic text-[22px] text-primary leading-none flex items-center justify-end gap-2">
          <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse inline-block"></span>Nominal
        </span>
      </div>
    </div>
  </div>

  <!-- Hero content -->
  <div class="relative z-10 text-center px-6 max-w-6xl" data-hero-inner>
    <div class="hero-badge inline-flex items-center gap-3 mb-10 glass-panel px-5 py-2 rounded-full border border-white/10">
      <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse shadow-[0_0_6px_#6dddff]"></span>
      <span class="font-label text-[10px] uppercase tracking-[0.35em] text-on-surface/60">NASA · Live Data · AI Insights</span>
    </div>
    <h1 class="leading-none tracking-tighter select-none" style="font-family:'Noto Serif',serif;font-weight:300;font-style:italic;font-size:clamp(72px,14vw,180px)">
      <span class="hero-word-1 block text-shimmer">Explore</span>
      <span class="hero-word-2 block text-on-surface">the cosmos.</span>
    </h1>
    <p class="hero-sub font-body text-xl text-on-surface-variant max-w-xl mx-auto mt-8 mb-14 leading-relaxed">
      NASA imagery, live asteroid tracking, ISS position, and AI insights for the endlessly curious.
    </p>
    <div class="hero-cta flex flex-col sm:flex-row items-center justify-center gap-5">
      <a href="${pageContext.request.contextPath}/register"
         class="cta-btn-primary bg-primary text-on-primary px-10 py-4 rounded-full font-label font-bold uppercase tracking-[0.2em] hover:scale-105 transition-transform duration-300">
        Begin journey
      </a>
      <a href="${pageContext.request.contextPath}/login"
         class="flex items-center gap-3 px-10 py-4 rounded-full border border-white/15 bg-white/5 font-label font-bold uppercase tracking-[0.2em] hover:bg-white/10 transition-all">
        <span class="material-symbols-outlined text-lg">login</span> Sign in
      </a>
    </div>
  </div>

  <!-- Scroll indicator -->
  <div class="absolute bottom-10 left-1/2 -translate-x-1/2 flex flex-col items-center gap-3 opacity-40">
    <span class="font-label text-[9px] uppercase tracking-[0.5em]">Scroll to explore</span>
    <div class="scroll-line w-px bg-gradient-to-b from-primary to-transparent" style="height:80px"></div>
    <span class="material-symbols-outlined text-base text-primary scroll-arrow-anim">expand_more</span>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     MARQUEE STRIP
══════════════════════════════════════════════════════════ -->
<div class="border-y border-white/5 overflow-hidden py-5" style="background:rgba(17,19,28,0.8)">
  <div class="marquee-track">
    <c:forEach begin="0" end="1">
      <span class="marquee-item"><span class="marquee-dot"></span><span class="font-label text-[11px] tracking-[0.3em] uppercase text-on-surface/40">Astronomy Picture of the Day</span></span>
      <span class="marquee-item"><span class="marquee-dot"></span><span class="font-label text-[11px] tracking-[0.3em] uppercase text-primary/60">Mars Rover Photography</span></span>
      <span class="marquee-item"><span class="marquee-dot"></span><span class="font-label text-[11px] tracking-[0.3em] uppercase text-on-surface/40">Asteroid Tracking</span></span>
      <span class="marquee-item"><span class="marquee-dot"></span><span class="font-label text-[11px] tracking-[0.3em] uppercase text-primary/60">ISS Live Position</span></span>
      <span class="marquee-item"><span class="marquee-dot"></span><span class="font-label text-[11px] tracking-[0.3em] uppercase text-on-surface/40">AI Space Insights</span></span>
      <span class="marquee-item"><span class="marquee-dot"></span><span class="font-label text-[11px] tracking-[0.3em] uppercase text-primary/60">NASA Open Data</span></span>
    </c:forEach>
  </div>
</div>

<!-- ══════════════════════════════════════════════════════════
     FEATURE PIN SCROLL — 4 panels, sticky
══════════════════════════════════════════════════════════ -->
<section id="features-pin-section" style="height:520vh">
  <div class="pin-sticky sticky top-0 h-screen overflow-hidden">
    <div class="absolute inset-0 pointer-events-none" style="background:radial-gradient(ellipse 50% 40% at 50% 50%,rgba(109,221,255,.05) 0%,transparent 65%)"></div>

    <!-- Left accent bar (color shifts per panel) -->
    <div class="pin-accent" id="pin-accent-bar" style="background:#6dddff"></div>

    <!-- Scroll progress bar at bottom -->
    <div id="pin-progress-bar"></div>
    <div id="pin-panel-label">01 &nbsp;/&nbsp; Astronomy</div>

    <!-- Right-side progress dots -->
    <div class="absolute right-6 md:right-10 top-1/2 -translate-y-1/2 flex flex-col gap-3 z-30">
      <div class="pin-dot"></div>
      <div class="pin-dot"></div>
      <div class="pin-dot"></div>
      <div class="pin-dot"></div>
    </div>

    <!-- ── Panel 1: APOD ── -->
    <div class="pin-panel absolute inset-0 flex items-center">
      <div class="pin-number">01</div>
      <div class="max-w-7xl mx-auto px-8 md:px-16 w-full grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div>
          <p class="font-label text-[10px] uppercase tracking-[0.5em] text-primary mb-8">01 &nbsp;/&nbsp; Astronomy</p>
          <h2 class="font-headline font-light italic leading-none mb-8" style="font-size:clamp(52px,7vw,96px)">
            Every day,<br/>a new discovery.
          </h2>
          <p class="font-body text-lg text-on-surface-variant leading-relaxed mb-10 max-w-md">
            NASA's Astronomy Picture of the Day — stunning imagery from across the universe, explained by AI.
          </p>
          <a href="${pageContext.request.contextPath}/register" class="feature-link">
            Start exploring <span class="material-symbols-outlined text-base">arrow_forward</span>
          </a>
        </div>
        <div class="hidden lg:flex justify-center">
          <div class="feature-icon-ring">
            <span class="material-symbols-outlined" style="font-size:5rem;color:#6dddff;opacity:.65;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">telescope</span>
          </div>
        </div>
      </div>
    </div>

    <!-- ── Panel 2: Mars ── -->
    <div class="pin-panel absolute inset-0 flex items-center" style="opacity:0;transform:translateY(52px) scale(0.97);pointer-events:none">
      <div class="pin-number">02</div>
      <div class="max-w-7xl mx-auto px-8 md:px-16 w-full grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div>
          <p class="font-label text-[10px] uppercase tracking-[0.5em] text-secondary mb-8">02 &nbsp;/&nbsp; Exploration</p>
          <h2 class="font-headline font-light italic leading-none mb-8" style="font-size:clamp(52px,7vw,96px)">
            Meet Mars.<br/>Up close.
          </h2>
          <p class="font-body text-lg text-on-surface-variant leading-relaxed mb-10 max-w-md">
            Real photos from Curiosity, Perseverance, Opportunity, and Spirit — directly from the Martian surface.
          </p>
          <a href="${pageContext.request.contextPath}/register" class="feature-link" style="color:#fdb64b">
            Explore Mars <span class="material-symbols-outlined text-base">arrow_forward</span>
          </a>
        </div>
        <div class="hidden lg:flex justify-center">
          <div class="feature-icon-ring" style="border-color:rgba(253,182,75,.15);background:radial-gradient(circle,rgba(253,182,75,.06) 0%,transparent 70%)">
            <span class="material-symbols-outlined" style="font-size:5rem;color:#fdb64b;opacity:.65;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">public</span>
          </div>
        </div>
      </div>
    </div>

    <!-- ── Panel 3: Asteroids ── -->
    <div class="pin-panel absolute inset-0 flex items-center" style="opacity:0;transform:translateY(52px) scale(0.97);pointer-events:none">
      <div class="pin-number">03</div>
      <div class="max-w-7xl mx-auto px-8 md:px-16 w-full grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div>
          <p class="font-label text-[10px] uppercase tracking-[0.5em] text-primary mb-8">03 &nbsp;/&nbsp; Planetary Defense</p>
          <h2 class="font-headline font-light italic leading-none mb-8" style="font-size:clamp(52px,7vw,96px)">
            Track what's<br/>coming our way.
          </h2>
          <p class="font-body text-lg text-on-surface-variant leading-relaxed mb-10 max-w-md">
            Near-Earth objects approaching this week, live from NASA's NeoWs feed. Know before it arrives.
          </p>
          <a href="${pageContext.request.contextPath}/register" class="feature-link">
            Track asteroids <span class="material-symbols-outlined text-base">arrow_forward</span>
          </a>
        </div>
        <div class="hidden lg:flex justify-center">
          <div class="feature-icon-ring">
            <span class="material-symbols-outlined" style="font-size:5rem;color:#6dddff;opacity:.65;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">sensors</span>
          </div>
        </div>
      </div>
    </div>

    <!-- ── Panel 4: ISS ── -->
    <div class="pin-panel absolute inset-0 flex items-center" style="opacity:0;transform:translateY(52px) scale(0.97);pointer-events:none">
      <div class="pin-number">04</div>
      <div class="max-w-7xl mx-auto px-8 md:px-16 w-full grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div>
          <p class="font-label text-[10px] uppercase tracking-[0.5em] text-primary mb-8">04 &nbsp;/&nbsp; Space Station</p>
          <h2 class="font-headline font-light italic leading-none mb-8" style="font-size:clamp(52px,7vw,96px)">
            The Station,<br/>live.
          </h2>
          <p class="font-body text-lg text-on-surface-variant leading-relaxed mb-10 max-w-md">
            Watch the International Space Station orbit Earth in real time. Position updates every 5 seconds.
          </p>
          <a href="${pageContext.request.contextPath}/register" class="feature-link">
            Track the ISS <span class="material-symbols-outlined text-base">arrow_forward</span>
          </a>
        </div>
        <div class="hidden lg:flex justify-center">
          <div class="feature-icon-ring">
            <span class="material-symbols-outlined" style="font-size:5rem;color:#6dddff;opacity:.65;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">satellite_alt</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     STATS ROW
══════════════════════════════════════════════════════════ -->
<section class="border-t border-b border-white/5" style="background:#05060d">
  <div class="max-w-7xl mx-auto grid grid-cols-2 md:grid-cols-4">
    <div class="stat-cell a-reveal px-8 py-20 text-center">
      <div class="font-headline italic text-primary mb-3" style="font-size:clamp(52px,7vw,80px);line-height:1"><span class="a-counter">5000</span>+</div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">Space Photos</div>
    </div>
    <div class="stat-cell a-reveal a-d2 px-8 py-20 text-center">
      <div class="font-headline italic text-primary mb-3" style="font-size:clamp(52px,7vw,80px);line-height:1"><span class="a-counter">4</span></div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">Rovers on Mars</div>
    </div>
    <div class="stat-cell a-reveal a-d4 px-8 py-20 text-center">
      <div class="font-headline italic text-primary mb-3" style="font-size:clamp(52px,7vw,80px);line-height:1"><span class="a-counter">500</span>+</div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">Asteroids Weekly</div>
    </div>
    <div class="a-reveal a-d6 px-8 py-20 text-center">
      <div class="font-headline italic text-secondary mb-3" style="font-size:clamp(52px,7vw,80px);line-height:1"><span class="a-counter">15.5</span></div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">ISS Orbits / Day</div>
    </div>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     QUOTE
══════════════════════════════════════════════════════════ -->
<section class="max-w-5xl mx-auto px-8 py-40 text-center">
  <p class="font-label text-[10px] uppercase tracking-[0.5em] text-primary mb-10 a-reveal">&mdash; Our purpose &mdash;</p>
  <h2 class="a-split font-headline font-light italic leading-tight text-on-surface-variant" style="font-size:clamp(40px,6vw,72px)">
    Peer into the void<br/>with professional precision.
  </h2>
</section>

<!-- ══════════════════════════════════════════════════════════
     CTA
══════════════════════════════════════════════════════════ -->
<section class="relative min-h-[80vh] flex flex-col items-center justify-center text-center px-8 overflow-hidden">
  <canvas id="starfield-cta" class="absolute inset-0 w-full h-full pointer-events-none opacity-60"></canvas>
  <div class="relative z-10">
    <p class="a-reveal font-label text-[10px] uppercase tracking-[0.5em] text-primary mb-8">Ready?</p>
    <h2 class="a-split font-headline font-light italic leading-none mb-14" style="font-size:clamp(64px,10vw,140px)">
      The universe awaits.
    </h2>
    <div class="a-reveal a-d3 flex flex-col sm:flex-row items-center justify-center gap-6">
      <a href="${pageContext.request.contextPath}/register"
         class="cta-btn-primary bg-primary text-on-primary px-12 py-5 rounded-full font-label font-bold uppercase tracking-[0.2em] text-base hover:scale-105 transition-transform duration-300">
        Begin journey
      </a>
      <a href="${pageContext.request.contextPath}/login"
         class="flex items-center gap-3 px-12 py-5 rounded-full border border-white/15 font-label font-bold uppercase tracking-[0.2em] hover:bg-white/5 transition-all">
        <span class="material-symbols-outlined">login</span> Sign in
      </a>
    </div>
  </div>
</section>

<%@ include file="common/footer.jspf" %>

<script>
/* Second starfield for CTA section */
(function(){
  var c=document.getElementById('starfield-cta'); if(!c)return;
  var x=c.getContext('2d'),s=[];
  function r(){c.width=c.offsetWidth;c.height=c.offsetHeight;s=Array.from({length:120},function(){return{x:Math.random()*c.width,y:Math.random()*c.height,r:Math.random()*1.2+.1,a:Math.random()*.6+.1,d:(Math.random()-.5)*.006};});}
  function d(){x.clearRect(0,0,c.width,c.height);s.forEach(function(p){p.a+=p.d;if(p.a<.05||p.a>.85)p.d*=-1;x.beginPath();x.arc(p.x,p.y,p.r,0,Math.PI*2);x.fillStyle='rgba(241,239,251,'+p.a+')';x.fill();});requestAnimationFrame(d);}
  window.addEventListener('resize',r);r();d();
})();
</script>
</body>
</html>
