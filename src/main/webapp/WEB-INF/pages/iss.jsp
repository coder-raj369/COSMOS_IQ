<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="iss" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | ISS Live Tracker</title>
<%@ include file="common/head.jspf" %>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<style>
/* ── Map ── */
#iss-map { background: #0c0e16; }
.leaflet-tile-pane { filter: brightness(0.75) saturate(0.5) hue-rotate(200deg); }
.leaflet-container { background: #05060d; }
.iss-marker-wrap { filter: drop-shadow(0 0 10px #6dddff) drop-shadow(0 0 24px rgba(109,221,255,0.5)); }

/* ── Scroll reveal ── */
.reveal { opacity: 0; transform: translateY(36px); transition: opacity 0.9s cubic-bezier(0.25,0.46,0.45,0.94), transform 0.9s cubic-bezier(0.25,0.46,0.45,0.94); }
.reveal.visible { opacity: 1; transform: translateY(0); }
.reveal-d1 { transition-delay: 0.1s; }
.reveal-d2 { transition-delay: 0.2s; }
.reveal-d3 { transition-delay: 0.3s; }
.reveal-d4 { transition-delay: 0.4s; }

/* ── Hero title entrance ── */
@keyframes heroIn {
  from { opacity: 0; transform: translateY(50px); filter: blur(8px); }
  to   { opacity: 1; transform: translateY(0);    filter: blur(0);   }
}
.h-anim-0 { animation: heroIn 1.1s cubic-bezier(0.25,0.46,0.45,0.94) forwards; }
.h-anim-1 { animation: heroIn 1.1s 0.25s cubic-bezier(0.25,0.46,0.45,0.94) both; }
.h-anim-2 { animation: heroIn 1.1s 0.5s  cubic-bezier(0.25,0.46,0.45,0.94) both; }

/* ── Live pulse ── */
@keyframes livePulse {
  0%,100% { transform: scale(1);   opacity: 1;   }
  50%      { transform: scale(1.8); opacity: 0.3; }
}
.live-dot { animation: livePulse 2s ease-in-out infinite; }

/* ── Orbital ring (SVG animateTransform handles movement) ── */
@keyframes ringRotate {
  from { transform: rotateZ(0deg);   }
  to   { transform: rotateZ(360deg); }
}
.ring-spin { animation: ringRotate 18s linear infinite; }

/* ── Scroll arrow ── */
@keyframes arrowBounce {
  0%,100% { transform: translateX(-50%) translateY(0);   }
  50%      { transform: translateX(-50%) translateY(10px); }
}
.scroll-arrow { animation: arrowBounce 2s ease-in-out infinite; }

/* ── Card data flash ── */
@keyframes dataFlash {
  0%   { border-color: rgba(109,221,255,0.6); box-shadow: 0 0 20px rgba(109,221,255,0.15); }
  100% { border-color: rgba(255,255,255,0.08); box-shadow: none; }
}
.data-flash { animation: dataFlash 0.6s ease-out; }

/* ── Stats strip dividers ── */
.strip-cell { border-right: 1px solid rgba(255,255,255,0.06); }
.strip-cell:last-child { border-right: none; }

/* ── Number tabular ── */
.tabnum { font-variant-numeric: tabular-nums; font-feature-settings: "tnum"; }

/* ── Facts section ── */
.fact-cell { border-right: 1px solid rgba(255,255,255,0.06); }
.fact-cell:last-child { border-right: none; }

/* ── Parallax hero ── */
#hero-content { will-change: transform; }
</style>
</head>
<body class="bg-surface text-on-surface overflow-x-hidden">
<%@ include file="common/navbar.jspf" %>

<main>

<!-- ══════════════════════════════════════════════════════════
     HERO
══════════════════════════════════════════════════════════ -->
<section class="relative min-h-screen flex flex-col items-center justify-center overflow-hidden" id="hero-section">
  <!-- Starfield canvas -->
  <canvas id="starfield" class="absolute inset-0 w-full h-full pointer-events-none"></canvas>

  <!-- Radial glow -->
  <div class="absolute inset-0 pointer-events-none"
       style="background: radial-gradient(ellipse 60% 50% at 50% 60%, rgba(109,221,255,0.07) 0%, transparent 70%)"></div>

  <!-- Decorative orbital ring (top-right, hidden on mobile) -->
  <div class="absolute right-[5%] top-1/2 -translate-y-1/2 w-[280px] h-[280px] hidden xl:block pointer-events-none" style="perspective: 800px;">
    <div class="w-full h-full" style="transform: rotateX(65deg) rotateZ(-20deg);">
      <div class="ring-spin w-full h-full relative">
        <div class="absolute inset-0 rounded-full border border-primary/25"></div>
        <div class="absolute inset-[28px] rounded-full border border-primary/10"></div>
        <!-- ISS dot on ring -->
        <div class="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 w-3 h-3 rounded-full bg-primary shadow-[0_0_14px_#6dddff]"></div>
      </div>
    </div>
  </div>

  <!-- Hero content -->
  <div class="relative z-10 max-w-6xl mx-auto px-8 text-center" id="hero-content">
    <!-- Live badge -->
    <div class="h-anim-0 flex items-center justify-center gap-3 mb-10">
      <div class="live-dot w-2 h-2 rounded-full bg-green-400 shadow-[0_0_8px_#4ade80]"></div>
      <span class="font-label text-[11px] tracking-[0.4em] uppercase text-green-400">Live Tracking Active</span>
    </div>

    <!-- Main headline -->
    <h1 class="h-anim-1 font-headline font-light italic leading-none text-on-surface mb-6"
        style="font-size: clamp(64px, 12vw, 160px);">
      Track the<br/><span class="text-shimmer">Station.</span>
    </h1>

    <p class="h-anim-2 font-body text-lg text-on-surface-variant max-w-lg mx-auto mb-16">
      International Space Station &middot; ~408 km above Earth &middot; Updated every 5 seconds
    </p>

    <!-- Live coordinate pill -->
    <div class="h-anim-2 inline-flex flex-wrap justify-center items-center gap-0 glass-panel rounded-full border border-primary/20 overflow-hidden">
      <div class="px-8 py-4 text-center border-r border-white/10">
        <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-1">Latitude</div>
        <div id="hero-lat" class="tabnum font-label text-base text-primary">——.——°</div>
      </div>
      <div class="px-8 py-4 text-center border-r border-white/10">
        <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-1">Longitude</div>
        <div id="hero-lng" class="tabnum font-label text-base text-primary">———.——°</div>
      </div>
      <div class="px-8 py-4 text-center">
        <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-1">Altitude</div>
        <div id="hero-alt" class="tabnum font-label text-base text-primary">——— km</div>
      </div>
    </div>
  </div>

  <!-- Scroll hint -->
  <div class="scroll-arrow absolute bottom-8 left-1/2 text-on-surface/25">
    <span class="material-symbols-outlined text-3xl">keyboard_arrow_down</span>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     STICKY STATS STRIP
══════════════════════════════════════════════════════════ -->
<div class="sticky top-16 z-30 bg-surface-container-lowest/80 backdrop-blur-[40px] border-y border-white/5">
  <div class="max-w-7xl mx-auto grid grid-cols-3 md:grid-cols-5">
    <div class="strip-cell px-5 py-3 text-center">
      <div class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/35 mb-0.5">Velocity</div>
      <div id="strip-vel" class="tabnum font-label text-xs text-on-surface">— km/s</div>
    </div>
    <div class="strip-cell px-5 py-3 text-center">
      <div class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/35 mb-0.5">Altitude</div>
      <div id="strip-alt" class="tabnum font-label text-xs text-on-surface">— km</div>
    </div>
    <div class="strip-cell px-5 py-3 text-center">
      <div class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/35 mb-0.5">Visibility</div>
      <div id="strip-vis" class="font-label text-xs text-on-surface">—</div>
    </div>
    <div class="strip-cell px-5 py-3 text-center hidden md:block">
      <div class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/35 mb-0.5">Latitude</div>
      <div id="strip-lat" class="tabnum font-label text-xs text-on-surface">—</div>
    </div>
    <div class="px-5 py-3 text-center hidden md:block">
      <div class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/35 mb-0.5">Longitude</div>
      <div id="strip-lng" class="tabnum font-label text-xs text-on-surface">—</div>
    </div>
  </div>
</div>

<!-- ══════════════════════════════════════════════════════════
     MAP
══════════════════════════════════════════════════════════ -->
<section class="max-w-7xl mx-auto px-8 py-20">
  <div class="reveal mb-10 flex items-end justify-between flex-wrap gap-4">
    <div>
      <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary mb-2">Live Position</p>
      <h2 class="font-headline font-light italic text-5xl md:text-6xl text-on-surface">Ground Track.</h2>
    </div>
    <div class="flex items-center gap-2">
      <div class="live-dot w-1.5 h-1.5 rounded-full bg-primary shadow-[0_0_6px_#6dddff]"></div>
      <span class="font-label text-[10px] uppercase tracking-[0.2em] text-primary">Real-time</span>
    </div>
  </div>

  <div class="reveal rounded-lg overflow-hidden border border-white/5 shadow-[0_32px_80px_rgba(0,0,0,0.6)]">
    <div id="iss-map" style="height: 520px;"></div>
  </div>

  <!-- Map legend -->
  <div class="reveal mt-4 flex items-center gap-6 text-on-surface-variant">
    <div class="flex items-center gap-2">
      <div class="w-6 h-px bg-primary/60" style="border-top: 1px dashed rgba(109,221,255,0.6)"></div>
      <span class="font-label text-[9px] uppercase tracking-[0.2em]">Orbital trail</span>
    </div>
    <div class="flex items-center gap-2">
      <div class="w-3 h-3 rounded-full bg-primary shadow-[0_0_8px_#6dddff]"></div>
      <span class="font-label text-[9px] uppercase tracking-[0.2em]">ISS position</span>
    </div>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     LIVE DATA CARDS
══════════════════════════════════════════════════════════ -->
<section class="max-w-7xl mx-auto px-8 py-8">
  <div class="reveal mb-12">
    <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary mb-2">Telemetry</p>
    <h2 class="font-headline font-light italic text-5xl md:text-6xl text-on-surface">Live Data.</h2>
  </div>

  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
    <!-- Altitude -->
    <div id="card-alt" class="reveal reveal-d1 glass-panel p-8 rounded-lg border border-white/5 hover:border-primary/20 transition-all duration-500 group">
      <div class="flex items-start justify-between mb-6">
        <span class="material-symbols-outlined text-primary/70 group-hover:text-primary transition-colors"
              style="font-size:2rem;font-variation-settings:'FILL' 0,'wght' 200,'GRAD' 0,'opsz' 48">height</span>
        <div class="live-dot w-1.5 h-1.5 rounded-full bg-primary/40 mt-1"></div>
      </div>
      <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-2">Altitude</div>
      <div id="data-alt" class="tabnum font-headline italic text-[42px] leading-none text-on-surface mb-2">—</div>
      <div class="font-label text-[10px] text-on-surface-variant">kilometers above Earth</div>
    </div>

    <!-- Velocity -->
    <div id="card-vel" class="reveal reveal-d2 glass-panel p-8 rounded-lg border border-white/5 hover:border-primary/20 transition-all duration-500 group">
      <div class="flex items-start justify-between mb-6">
        <span class="material-symbols-outlined text-primary/70 group-hover:text-primary transition-colors"
              style="font-size:2rem;font-variation-settings:'FILL' 0,'wght' 200,'GRAD' 0,'opsz' 48">speed</span>
        <div class="live-dot w-1.5 h-1.5 rounded-full bg-primary/40 mt-1"></div>
      </div>
      <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-2">Velocity</div>
      <div id="data-vel" class="tabnum font-headline italic text-[42px] leading-none text-on-surface mb-2">—</div>
      <div class="font-label text-[10px] text-on-surface-variant">km/s orbital speed</div>
    </div>

    <!-- Visibility -->
    <div id="card-vis" class="reveal reveal-d3 glass-panel p-8 rounded-lg border border-white/5 hover:border-primary/20 transition-all duration-500 group">
      <div class="flex items-start justify-between mb-6">
        <span id="vis-icon" class="material-symbols-outlined text-primary/70 group-hover:text-primary transition-colors"
              style="font-size:2rem;font-variation-settings:'FILL' 0,'wght' 200,'GRAD' 0,'opsz' 48">wb_sunny</span>
        <div class="live-dot w-1.5 h-1.5 rounded-full bg-primary/40 mt-1"></div>
      </div>
      <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-2">Visibility</div>
      <div id="data-vis" class="font-headline italic text-[42px] leading-none text-on-surface mb-2">—</div>
      <div class="font-label text-[10px] text-on-surface-variant">current illumination</div>
    </div>

    <!-- Footprint -->
    <div id="card-foot" class="reveal reveal-d4 glass-panel p-8 rounded-lg border border-white/5 hover:border-primary/20 transition-all duration-500 group">
      <div class="flex items-start justify-between mb-6">
        <span class="material-symbols-outlined text-primary/70 group-hover:text-primary transition-colors"
              style="font-size:2rem;font-variation-settings:'FILL' 0,'wght' 200,'GRAD' 0,'opsz' 48">radio_button_checked</span>
        <div class="live-dot w-1.5 h-1.5 rounded-full bg-primary/40 mt-1"></div>
      </div>
      <div class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mb-2">Footprint</div>
      <div id="data-foot" class="tabnum font-headline italic text-[42px] leading-none text-on-surface mb-2">—</div>
      <div class="font-label text-[10px] text-on-surface-variant">km visibility radius</div>
    </div>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     CREW
══════════════════════════════════════════════════════════ -->
<section class="max-w-7xl mx-auto px-8 py-20">
  <div class="reveal mb-12 flex items-end justify-between flex-wrap gap-4">
    <div>
      <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary mb-2">Aboard ISS</p>
      <h2 class="font-headline font-light italic text-5xl md:text-6xl text-on-surface">Current Crew.</h2>
    </div>
    <div id="crew-count" class="font-label text-[10px] uppercase tracking-[0.2em] text-on-surface-variant"></div>
  </div>

  <div id="crew-grid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
    <!-- skeleton while loading -->
    <c:forEach begin="0" end="3">
    <div class="glass-panel p-6 rounded-lg border border-white/5 animate-pulse">
      <div class="w-10 h-10 rounded-full bg-surface-container-high mb-4"></div>
      <div class="h-3 bg-surface-container-high rounded w-3/4 mb-2"></div>
      <div class="h-2 bg-surface-container-high rounded w-1/2"></div>
    </div>
    </c:forEach>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     ORBITAL FACTS STRIP
══════════════════════════════════════════════════════════ -->
<section class="border-t border-b border-white/5 my-8">
  <div class="max-w-7xl mx-auto grid grid-cols-2 md:grid-cols-4">
    <div class="reveal fact-cell px-8 py-20 text-center">
      <div class="font-headline italic text-[68px] leading-none text-primary mb-4">15.5</div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">Orbits per Day</div>
    </div>
    <div class="reveal reveal-d1 fact-cell px-8 py-20 text-center">
      <div class="font-headline italic text-[68px] leading-none text-primary mb-4">92</div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">Minutes per Orbit</div>
    </div>
    <div class="reveal reveal-d2 fact-cell px-8 py-20 text-center">
      <div class="font-headline italic text-[68px] leading-none text-primary mb-4">408</div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">km Above Earth</div>
    </div>
    <div class="reveal reveal-d3 px-8 py-20 text-center">
      <div class="font-headline italic text-[68px] leading-none text-secondary mb-4">27K+</div>
      <div class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface-variant">km/h Orbital Speed</div>
    </div>
  </div>
</section>

</main>
<%@ include file="common/footer.jspf" %>

<!-- Leaflet -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>
// ── Starfield ────────────────────────────────────────────────────────────────
(function () {
  const canvas = document.getElementById('starfield');
  const ctx    = canvas.getContext('2d');
  let stars = [];

  function resize() {
    canvas.width  = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;
    initStars();
  }

  function initStars() {
    stars = Array.from({ length: 220 }, () => ({
      x: Math.random() * canvas.width,
      y: Math.random() * canvas.height,
      r: Math.random() * 1.3 + 0.2,
      a: Math.random() * 0.7 + 0.1,
      da: (Math.random() - 0.5) * 0.008
    }));
  }

  function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (const s of stars) {
      s.a += s.da;
      if (s.a < 0.05 || s.a > 0.9) s.da *= -1;
      ctx.beginPath();
      ctx.arc(s.x, s.y, s.r, 0, Math.PI * 2);
      ctx.fillStyle = `rgba(241,239,251,${s.a})`;
      ctx.fill();
    }
    requestAnimationFrame(draw);
  }

  window.addEventListener('resize', resize);
  resize();
  draw();
})();

// ── Parallax hero on scroll ───────────────────────────────────────────────────
const heroContent = document.getElementById('hero-content');
window.addEventListener('scroll', () => {
  const y = window.scrollY;
  heroContent.style.transform = `translateY(${y * 0.3}px)`;
  heroContent.style.opacity   = Math.max(0, 1 - y / 500);
}, { passive: true });

// ── Scroll reveal ─────────────────────────────────────────────────────────────
const revealObs = new IntersectionObserver(entries => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.12 });
document.querySelectorAll('.reveal').forEach(el => revealObs.observe(el));

// ── Leaflet map ───────────────────────────────────────────────────────────────
const map = L.map('iss-map', {
  center: [20, 0], zoom: 2,
  zoomControl: false,
  attributionControl: false,
  scrollWheelZoom: false
});

L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
  subdomains: 'abcd', maxZoom: 10
}).addTo(map);

L.control.zoom({ position: 'bottomright' }).addTo(map);
L.control.attribution({ position: 'bottomleft', prefix: false })
  .addAttribution('&copy; <a href="https://carto.com">CARTO</a> &middot; ISS data: wheretheiss.at')
  .addTo(map);

const issIcon = L.divIcon({
  className: '',
  html: `<div class="iss-marker-wrap">
    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 40 40">
      <circle cx="20" cy="20" r="18" fill="none" stroke="#6dddff" stroke-width="0.8" stroke-opacity="0.25"/>
      <line x1="2"  y1="20" x2="38" y2="20" stroke="#6dddff" stroke-width="1.5" stroke-opacity="0.85"/>
      <line x1="20" y1="2"  x2="20" y2="38" stroke="#6dddff" stroke-width="1.5" stroke-opacity="0.85"/>
      <rect x="12" y="18" width="16" height="4" rx="1" fill="#6dddff" fill-opacity="0.9"/>
      <rect x="18" y="12" width="4" height="16" rx="1" fill="#6dddff" fill-opacity="0.9"/>
      <circle cx="20" cy="20" r="3.5" fill="#6dddff"/>
    </svg>
  </div>`,
  iconSize:   [40, 40],
  iconAnchor: [20, 20]
});

let issMarker  = L.marker([20, 0], { icon: issIcon }).addTo(map);
let orbitLine  = L.polyline([], { color: '#6dddff', weight: 1.5, opacity: 0.45, dashArray: '5 7' }).addTo(map);
let pathPoints = [];
const MAX_PTS  = 80;

// ── Helper: flash a card border ───────────────────────────────────────────────
function flashCard(id) {
  const el = document.getElementById(id);
  if (!el) return;
  el.classList.remove('data-flash');
  void el.offsetWidth;
  el.classList.add('data-flash');
}

// ── Update all displays with ISS data ─────────────────────────────────────────
function updateDisplay(d) {
  const lat  = d.latitude.toFixed(2);
  const lng  = d.longitude.toFixed(2);
  const alt  = d.altitude.toFixed(1);
  const vel  = d.velocity.toFixed(2);
  const vis  = d.visibility === 'daylight' ? 'Daylight' : 'Eclipse';
  const foot = Math.round(d.footprint);

  // Hero pill
  document.getElementById('hero-lat').textContent = lat + '°';
  document.getElementById('hero-lng').textContent = lng + '°';
  document.getElementById('hero-alt').textContent = alt + ' km';

  // Sticky strip
  document.getElementById('strip-vel').textContent = vel + ' km/s';
  document.getElementById('strip-alt').textContent = alt + ' km';
  document.getElementById('strip-vis').textContent = vis;
  document.getElementById('strip-lat').textContent = lat + '°';
  document.getElementById('strip-lng').textContent = lng + '°';

  // Data cards
  document.getElementById('data-alt').textContent  = alt;
  document.getElementById('data-vel').textContent  = vel;
  document.getElementById('data-vis').textContent  = vis;
  document.getElementById('data-foot').textContent = foot;

  // Visibility icon swap
  const visIcon = document.getElementById('vis-icon');
  visIcon.textContent = d.visibility === 'daylight' ? 'wb_sunny' : 'bedtime';

  // Flash cards
  ['card-alt','card-vel','card-vis','card-foot'].forEach(flashCard);

  // Map marker + trail
  const pos = [d.latitude, d.longitude];
  issMarker.setLatLng(pos);

  // Handle antimeridian split
  const prev = pathPoints[pathPoints.length - 1];
  if (prev && Math.abs(d.longitude - prev[1]) > 180) {
    pathPoints = [];
  }
  pathPoints.push(pos);
  if (pathPoints.length > MAX_PTS) pathPoints.shift();
  orbitLine.setLatLngs(pathPoints);
}

// ── Fetch ISS position ────────────────────────────────────────────────────────
async function fetchISS() {
  try {
    const res  = await fetch('https://api.wheretheiss.at/v1/satellites/25544');
    if (!res.ok) throw new Error('API error');
    const data = await res.json();
    updateDisplay(data);
  } catch (err) {
    console.warn('ISS fetch failed:', err);
  }
}

fetchISS();
setInterval(fetchISS, 5000);

// ── Fetch crew ────────────────────────────────────────────────────────────────
async function fetchCrew() {
  const grid = document.getElementById('crew-grid');
  try {
    const res    = await fetch(contextPath + '/iss/crew');
    const data   = await res.json();
    const people = (data.people || []).filter(p => p.craft === 'ISS');

    const countEl = document.getElementById('crew-count');
    countEl.textContent = people.length + (people.length === 1 ? ' crew member' : ' crew members') + ' aboard';

    if (people.length === 0) {
      grid.innerHTML = `<p class="text-on-surface-variant col-span-4 font-body text-sm">Crew data temporarily unavailable.</p>`;
      return;
    }

    const avatarColors = ['bg-primary/10', 'bg-secondary/10', 'bg-tertiary/10'];

    grid.innerHTML = people.map((p, i) => `
      <div class="reveal glass-panel p-6 rounded-lg border border-white/5 hover:border-primary/20 transition-all duration-500"
           style="transition-delay:${i * 0.07}s">
        <div class="w-11 h-11 rounded-full ${avatarColors[i % 3]} border border-white/10 flex items-center justify-center mb-4">
          <span class="material-symbols-outlined text-primary/80" style="font-size:1.3rem">person</span>
        </div>
        <div class="font-body font-medium text-on-surface text-sm mb-1">${p.name}</div>
        <div class="font-label text-[10px] uppercase tracking-[0.2em] text-primary/70">ISS Crew</div>
      </div>
    `).join('');

    grid.querySelectorAll('.reveal').forEach(el => revealObs.observe(el));

  } catch (err) {
    console.warn('Crew fetch failed:', err);
    grid.innerHTML = `<p class="text-on-surface-variant col-span-4 font-body text-sm">Crew data temporarily unavailable.</p>`;
  }
}

fetchCrew();
</script>
</body>
</html>
