<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="currentPage" value="home" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Dashboard</title>
<%@ include file="common/head.jspf" %>
<style>
/* ── Hero entrance ── */
@keyframes homeHeroIn { from{opacity:0;transform:translateY(48px);filter:blur(10px)} to{opacity:1;transform:none;filter:none} }
.hh-1 { animation: homeHeroIn 1s .1s both cubic-bezier(.16,1,.3,1); }
.hh-2 { animation: homeHeroIn 1s .3s both cubic-bezier(.16,1,.3,1); }
.hh-3 { animation: homeHeroIn 1s .5s both cubic-bezier(.16,1,.3,1); }
.hh-4 { animation: homeHeroIn 1s .7s both cubic-bezier(.16,1,.3,1); }

/* ── APOD section hover ── */
.apod-card-img { transition: transform 3s cubic-bezier(.25,.46,.45,.94); }
.apod-card:hover .apod-card-img { transform: scale(1.04); }

/* ── Bento grid ── */
.bento-grid {
  display: grid;
  gap: 16px;
  grid-template-columns: 1.4fr 1fr 1fr;
  grid-template-rows: auto auto;
}
.bento-mars      { grid-column:1; grid-row:1/3; min-height:400px; }
.bento-asteroids { grid-column:2; grid-row:1; }
.bento-iss       { grid-column:3; grid-row:1; }
.bento-archive   { grid-column:2/4; grid-row:2; }

@media (max-width: 1024px) {
  .bento-grid { grid-template-columns: 1fr 1fr; }
  .bento-mars      { grid-column:1/3; grid-row:1; min-height:260px; }
  .bento-asteroids { grid-column:1; grid-row:2; }
  .bento-iss       { grid-column:2; grid-row:2; }
  .bento-archive   { grid-column:1/3; grid-row:3; }
}
@media (max-width: 640px) {
  .bento-grid { grid-template-columns: 1fr; }
  .bento-mars,.bento-asteroids,.bento-iss,.bento-archive { grid-column:1; grid-row:auto; }
}

/* ── Stat pills ── */
.stat-pill { background:rgba(23,25,35,0.7); backdrop-filter:blur(20px); border:1px solid rgba(255,255,255,.07); }
</style>
</head>
<body class="bg-surface text-on-surface selection:bg-primary selection:text-on-primary">
<%@ include file="common/navbar.jspf" %>

<main>

<!-- ══════════════════════════════════════════════════════════
     HERO — Full-screen personalized greeting
══════════════════════════════════════════════════════════ -->
<section class="relative h-screen flex flex-col justify-end overflow-hidden" data-hero-section id="home-hero">
  <!-- APOD or fallback background — apod.url is always an image (video thumbnail or still) -->
  <div class="absolute inset-0 z-0">
    <c:choose>
      <c:when test="${not empty apod && not empty apod.url}">
        <img class="w-full h-full object-cover scale-105" src="${apod.url}" alt="${apod.title}" data-parallax="0.15"/>
      </c:when>
      <c:otherwise>
        <canvas id="starfield" class="w-full h-full"></canvas>
      </c:otherwise>
    </c:choose>
    <div class="absolute inset-0" style="background:linear-gradient(to bottom,rgba(12,14,22,.2) 0%,rgba(12,14,22,.5) 50%,rgba(12,14,22,1) 100%)"></div>
  </div>

  <!-- Hero content, bottom-aligned -->
  <div class="relative z-10 max-w-7xl mx-auto w-full px-8 pb-20" data-hero-inner>
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-end">

      <!-- Greeting -->
      <div class="lg:col-span-2">
        <p class="hh-1 font-label text-[10px] uppercase tracking-[0.45em] text-primary mb-5">Orbital Status: Synchronized</p>
        <h1 class="font-headline font-light italic leading-[0.88] tracking-tighter mb-10" style="font-size:clamp(56px,9vw,120px)">
          <span class="hh-2 block text-on-surface/60">Welcome back,</span>
          <span class="hh-3 block text-shimmer">${sessionScope.user.fullName}</span>
        </h1>
      </div>

      <!-- Stat pills -->
      <div class="hh-4 flex flex-col gap-3 lg:pb-3">
        <div class="stat-pill rounded-lg px-6 py-4 flex items-center justify-between">
          <span class="font-label text-[10px] uppercase tracking-[0.25em] text-on-surface-variant">Favorites</span>
          <span class="font-headline italic text-2xl text-primary">${favoritesCount}</span>
        </div>
        <div class="stat-pill rounded-lg px-6 py-4 flex items-center justify-between">
          <span class="font-label text-[10px] uppercase tracking-[0.25em] text-on-surface-variant">Asteroids this week</span>
          <span class="font-headline italic text-2xl text-secondary">${asteroidCount}</span>
        </div>
        <div class="stat-pill rounded-lg px-6 py-4 flex items-center justify-between">
          <span class="font-label text-[10px] uppercase tracking-[0.25em] text-on-surface-variant">AI facts generated</span>
          <span class="font-headline italic text-2xl text-primary">${aiFactsCount}</span>
        </div>
      </div>
    </div>
  </div>

  <!-- Scroll cue -->
  <div class="absolute bottom-6 left-1/2 -translate-x-1/2 flex flex-col items-center gap-2 opacity-25 pointer-events-none">
    <div class="w-px h-12 bg-gradient-to-b from-primary to-transparent"></div>
  </div>
</section>

<!-- ══════════════════════════════════════════════════════════
     TODAY IN THE COSMOS — APOD showcase
══════════════════════════════════════════════════════════ -->
<c:if test="${not empty apod && not empty apod.url}">
<section class="max-w-7xl mx-auto px-8 py-24">
  <div class="mb-10">
    <p class="a-reveal font-label text-[10px] uppercase tracking-[0.45em] text-primary mb-3">Today in the cosmos</p>
    <h2 class="a-split font-headline font-light italic leading-none" style="font-size:clamp(44px,6vw,80px)">
      ${apod.title}
    </h2>
  </div>

  <div class="apod-card relative rounded-xl overflow-hidden border border-white/5 shadow-[0_40px_100px_rgba(0,0,0,.7)]" style="aspect-ratio:21/9">
    <c:choose>
      <%-- If it's a video with a proper embed URL (YouTube), show iframe; otherwise always show image --%>
      <c:when test="${apod.media_type == 'video' && not empty apod.video_url && fn:contains(apod.video_url, 'youtube')}">
        <iframe class="w-full h-full" src="${apod.video_url}" frameborder="0" allowfullscreen></iframe>
      </c:when>
      <c:otherwise>
        <img class="apod-card-img w-full h-full object-cover" src="${apod.url}" alt="${apod.title}"/>
      </c:otherwise>
    </c:choose>
    <div class="absolute inset-0 bg-gradient-to-t from-surface-container-lowest/90 via-surface-container-lowest/20 to-transparent pointer-events-none"></div>
    <div class="absolute bottom-0 left-0 right-0 p-8 md:p-12 flex items-end justify-between flex-wrap gap-4">
      <div class="max-w-2xl">
        <span class="font-label text-[9px] uppercase tracking-[0.4em] text-primary block mb-2">${apod.date}</span>
        <p class="font-body text-sm text-on-surface-variant leading-relaxed hidden md:block mb-4">${apod.explanation}</p>
        <div id="home-apod-fact" class="text-xs text-primary/80 leading-relaxed mb-3 hidden"></div>
      </div>
      <div class="flex flex-col gap-3 items-end">
        <button onclick="generateAiFact('apod:${apod.date}','${apod.title}','home-apod-fact')"
                class="flex items-center gap-3 glass-panel px-8 py-3 rounded-full border border-primary/30 text-primary font-label text-[11px] uppercase tracking-[0.2em] hover:bg-primary hover:text-on-primary transition-all duration-500">
          <span class="material-symbols-outlined text-sm" style="font-variation-settings:'FILL' 1">auto_awesome</span>
          AI Insight
        </button>
        <a href="${pageContext.request.contextPath}/apod"
           class="flex items-center gap-3 glass-panel px-8 py-3 rounded-full border border-white/15 font-label text-[11px] uppercase tracking-[0.2em] hover:bg-white/10 transition-all duration-500">
          Full Archive <span class="material-symbols-outlined text-base">arrow_forward</span>
        </a>
      </div>
    </div>
  </div>
</section>
</c:if>

<!-- ══════════════════════════════════════════════════════════
     BENTO QUICK LINKS
══════════════════════════════════════════════════════════ -->
<section class="max-w-7xl mx-auto px-8 pb-32">
  <div class="a-reveal mb-10">
    <p class="font-label text-[10px] uppercase tracking-[0.45em] text-primary mb-3">Explore</p>
    <h2 class="font-headline font-light italic leading-none" style="font-size:clamp(44px,5vw,72px)">Your missions.</h2>
  </div>

  <div class="bento-grid">

    <!-- Mars — tall card -->
    <a href="${pageContext.request.contextPath}/mars"
       class="bento-mars bento-card glass-panel rounded-xl border border-white/5 p-10 flex flex-col justify-between overflow-hidden relative group">
      <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-700"
           style="background:radial-gradient(ellipse at bottom right,rgba(253,182,75,0.08) 0%,transparent 60%)"></div>
      <div>
        <span class="material-symbols-outlined text-secondary mb-6 block"
              style="font-size:3rem;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">public</span>
        <p class="font-label text-[9px] uppercase tracking-[0.35em] text-secondary mb-3">Exploration</p>
        <h3 class="font-headline font-light italic text-4xl leading-tight mb-4">Mars Rover</h3>
        <p class="font-body text-sm text-on-surface-variant leading-relaxed">Real photos from Curiosity, Perseverance, Opportunity, and Spirit.</p>
      </div>
      <div class="flex items-center gap-2 font-label text-[10px] uppercase tracking-[0.2em] text-secondary mt-8">
        Browse photos <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
      </div>
    </a>

    <!-- Asteroids -->
    <a href="${pageContext.request.contextPath}/asteroids"
       class="bento-asteroids bento-card glass-panel rounded-xl border border-white/5 p-10 flex flex-col justify-between overflow-hidden relative group">
      <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-700"
           style="background:radial-gradient(ellipse at top left,rgba(109,221,255,0.06) 0%,transparent 60%)"></div>
      <div>
        <span class="material-symbols-outlined text-primary mb-6 block"
              style="font-size:2.5rem;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">sensors</span>
        <p class="font-label text-[9px] uppercase tracking-[0.35em] text-primary mb-3">Planetary Defense</p>
        <h3 class="font-headline font-light italic text-3xl leading-tight mb-3">Asteroid Tracker</h3>
        <p class="font-body text-sm text-on-surface-variant leading-relaxed">Near-Earth objects passing this week.</p>
      </div>
      <div class="flex items-center gap-2 font-label text-[10px] uppercase tracking-[0.2em] text-primary mt-6">
        View threats <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
      </div>
    </a>

    <!-- ISS -->
    <a href="${pageContext.request.contextPath}/iss"
       class="bento-iss bento-card glass-panel rounded-xl border border-white/5 p-10 flex flex-col justify-between overflow-hidden relative group">
      <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-700"
           style="background:radial-gradient(ellipse at top right,rgba(109,221,255,0.06) 0%,transparent 60%)"></div>
      <div>
        <span class="material-symbols-outlined text-primary mb-6 block"
              style="font-size:2.5rem;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">satellite_alt</span>
        <p class="font-label text-[9px] uppercase tracking-[0.35em] text-primary mb-3">Space Station</p>
        <h3 class="font-headline font-light italic text-3xl leading-tight mb-3">ISS Tracker</h3>
        <p class="font-body text-sm text-on-surface-variant leading-relaxed">Live position, crew, and orbital data.</p>
      </div>
      <div class="flex items-center gap-2 font-label text-[10px] uppercase tracking-[0.2em] text-primary mt-6">
        Track live <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
      </div>
    </a>

    <!-- Archive — wide -->
    <a href="${pageContext.request.contextPath}/favorites"
       class="bento-archive bento-card glass-panel rounded-xl border border-white/5 p-10 flex items-center justify-between overflow-hidden relative group">
      <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-700"
           style="background:radial-gradient(ellipse at center,rgba(109,221,255,0.04) 0%,transparent 70%)"></div>
      <div class="flex items-center gap-8">
        <span class="material-symbols-outlined text-primary"
              style="font-size:3rem;font-variation-settings:'FILL' 0,'wght' 100,'GRAD' 0,'opsz' 48">favorite</span>
        <div>
          <p class="font-label text-[9px] uppercase tracking-[0.35em] text-primary mb-2">Personal Collection</p>
          <h3 class="font-headline font-light italic text-3xl mb-2">Your Archive</h3>
          <p class="font-body text-sm text-on-surface-variant">
            <span class="text-primary font-label">${favoritesCount}</span> items saved to your collection.
          </p>
        </div>
      </div>
      <span class="material-symbols-outlined text-on-surface/20 group-hover:text-primary group-hover:translate-x-2 transition-all text-4xl mr-4">arrow_forward</span>
    </a>
  </div>
</section>

</main>
<%@ include file="common/footer.jspf" %>
</body>
</html>
