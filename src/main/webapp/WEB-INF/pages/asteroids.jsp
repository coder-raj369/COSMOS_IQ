<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="asteroids" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Asteroid Tracker</title>
<%@ include file="common/head.jspf" %>
<style>
.filter-btn { cursor:pointer; padding:6px 20px; font-size:9px; letter-spacing:0.2em; text-transform:uppercase; transition:all 0.2s; border:1px solid rgba(255,255,255,0.1); color:rgba(255,255,255,0.4); background:transparent; }
.filter-btn.active { background:rgba(109,221,255,0.1); border-color:rgba(109,221,255,0.3); color:#6dddff; }
.filter-btn.active-hazardous { background:rgba(253,182,75,0.1); border-color:rgba(253,182,75,0.3); color:#fdb64b; }
.hidden-row { display:none; }
.filter-hidden { display:none; }
</style>
</head>
<body class="bg-background text-on-surface font-body">
<%@ include file="common/navbar.jspf" %>

<main class="pt-20 min-h-screen">

    <!-- Hero -->
    <section class="relative h-[70vh] flex flex-col justify-end overflow-hidden">
        <div class="absolute inset-0 z-0">
            <img class="w-full h-full object-cover opacity-30 grayscale contrast-125"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuCjSSGo7SrgJFiiZI5DYKbl3t9T4P8SqcMJtoZEZKfg0rV07P8QWZCo2PFAHxrpadp3lU29ggzn_zdobgKyaijpVUHIkjowxoTOb4zuZ6Vmpwmf7_0F2WWgfPMV_HungOKhlhtImiYL6mfXkHFYHkO9s6d9FSghfv5wbLwpmFUPINmRRgvPRlnyBRL76mvJMTK0rDmH1oPcY4gLQKjPxBzO56A2I3FeFgJIJLUSYwSIh1l4kp_s_1KnyQ_3we-Stc3WOfSerMokc1I" alt="Asteroids"/>
            <div class="absolute inset-0 bg-gradient-to-b from-black/20 via-background/40 to-background"></div>
        </div>
        <div class="relative z-10 max-w-6xl px-8 md:px-16 pb-16">
            <p class="font-label text-primary tracking-[0.4em] text-xs mb-6 flex items-center gap-3">
                <span class="w-12 h-[1px] bg-primary inline-block"></span>
                Planetary Defense // Live Feed
            </p>
            <h1 class="font-headline text-7xl md:text-[100px] leading-[0.88] font-light italic text-shimmer tracking-tighter">
                Threats in the<br/>neighborhood.
            </h1>
            <p class="font-body text-on-surface/60 mt-6 max-w-lg text-sm leading-relaxed">
                Tracking near-Earth objects flying past our planet this week.<br/>
                Precise telemetry for the celestial observer.
            </p>
        </div>
    </section>

    <!-- Stats Bar -->
    <section class="relative z-20 border-y border-white/5">
        <div class="grid grid-cols-2 md:grid-cols-4 max-w-full">
            <div class="px-10 py-8 border-r border-white/5">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/40 mb-3">Total Tracked</p>
                <p class="font-headline text-4xl font-black">${totalCount}</p>
            </div>
            <div class="px-10 py-8 border-r border-white/5 border-l-4 border-l-secondary">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-secondary mb-3">Potentially Hazardous</p>
                <p class="font-headline text-4xl font-black text-secondary">${hazardousCount}</p>
            </div>
            <div class="px-10 py-8 border-r border-white/5">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/40 mb-3">Closest Approach</p>
                <c:choose>
                    <c:when test="${not empty asteroids}">
                        <p class="font-headline text-4xl font-black">${asteroids[0].miss_distance_km} <span class="text-sm font-body font-normal text-on-surface/40">km</span></p>
                    </c:when>
                    <c:otherwise>
                        <p class="font-headline text-4xl font-black">—</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="px-10 py-8">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-primary mb-3">Next Flyby</p>
                <p class="font-headline text-4xl font-black text-primary flex items-center gap-2">
                    <span class="w-2 h-2 rounded-full bg-primary animate-pulse inline-block"></span>
                    Live
                </p>
            </div>
        </div>
    </section>

    <!-- Observation Log -->
    <section class="py-16 px-8 md:px-16 max-w-7xl mx-auto">

        <!-- Header + Filters -->
        <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-10 gap-4">
            <div>
                <h2 class="font-headline text-4xl italic font-light text-shimmer">Observation Log</h2>
                <p class="font-label text-[9px] uppercase tracking-[0.3em] text-on-surface/40 mt-2">Temporal Window: 24H — 168H</p>
            </div>
            <div class="flex gap-2">
                <button onclick="filterAsteroids('all')" id="btn-all" class="filter-btn active">All</button>
                <button onclick="filterAsteroids('hazardous')" id="btn-hazardous" class="filter-btn">Hazardous</button>
                <button onclick="filterAsteroids('safe')" id="btn-safe" class="filter-btn">Safe</button>
            </div>
        </div>

        <!-- Asteroid Rows -->
        <div class="space-y-3" id="asteroid-list">
            <c:forEach items="${asteroids}" var="a" varStatus="status">
            <div class="asteroid-row ${status.index >= 5 ? 'hidden-row' : ''}"
                 data-hazardous="${a.hazardous}"
                 data-index="${status.index}">
                <div class="group flex items-center gap-6 p-6 border border-white/5 hover:border-${a.hazardous == 'true' ? 'secondary' : 'primary'}/20 bg-white/[0.02] hover:bg-white/[0.04] transition-all duration-300">
                    <!-- Orb -->
                    <div class="w-14 h-14 flex items-center justify-center flex-shrink-0 relative">
                        <c:choose>
                            <c:when test="${a.hazardous == 'true'}">
                                <div class="absolute w-12 h-12 bg-secondary/20 blur-xl rounded-full animate-pulse"></div>
                                <div class="w-10 h-10 bg-secondary/80 rounded-full relative z-10 shadow-[0_0_20px_rgba(253,182,75,0.4)]"></div>
                            </c:when>
                            <c:otherwise>
                                <div class="absolute w-8 h-8 bg-primary/10 blur-lg rounded-full"></div>
                                <div class="w-4 h-4 bg-primary/60 rounded-full relative z-10"></div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Data Grid -->
                    <div class="flex-1 grid grid-cols-1 md:grid-cols-4 gap-6 items-center">
                        <div>
                            <p class="font-label text-[9px] tracking-[0.25em] uppercase mb-1 ${a.hazardous == 'true' ? 'text-secondary' : 'text-primary'}">${a.hazardous == 'true' ? 'Hazardous' : 'Safe'}</p>
                            <h3 class="font-headline text-xl font-bold leading-tight">${a.name}</h3>
                            <p class="font-label text-[9px] text-on-surface/40 mt-1 uppercase tracking-wider">${a.close_approach_date}</p>
                        </div>
                        <div>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest mb-1">Diameter</p>
                            <p class="font-headline text-lg italic">${a.diameter}</p>
                        </div>
                        <div>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest mb-1">Velocity</p>
                            <p class="font-headline text-lg italic">${a.velocity} <span class="text-xs font-body text-on-surface/50">km/s</span></p>
                        </div>
                        <div>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest mb-1">Miss Distance</p>
                            <p class="font-headline text-lg italic">${a.miss_distance_lunar} <span class="text-xs font-body text-on-surface/50">LD</span></p>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="flex items-center gap-3 flex-shrink-0">
                        <form method="POST" action="${pageContext.request.contextPath}/favorites">
                            <input type="hidden" name="action" value="save"/>
                            <input type="hidden" name="type" value="asteroid"/>
                            <input type="hidden" name="title" value="${a.name}"/>
                            <input type="hidden" name="description" value="Diameter: ${a.diameter}, Velocity: ${a.velocity} km/s"/>
                            <input type="hidden" name="sourceDate" value="${a.close_approach_date}"/>
                            <button type="submit" class="w-8 h-8 flex items-center justify-center text-on-surface/30 hover:text-primary transition-colors">
                                <span class="material-symbols-outlined text-sm">favorite</span>
                            </button>
                        </form>
                        <span class="text-on-surface/20 text-sm">↗</span>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>

        <!-- Load More -->
        <div class="mt-10 flex justify-end items-center" id="load-more-container">
            <button onclick="loadMore()" id="load-more-btn"
                    class="flex items-center gap-3 text-on-surface/40 hover:text-primary transition-colors font-label text-[10px] uppercase tracking-[0.3em] group">
                Load additional telemetry
                <span class="w-10 h-[1px] bg-current inline-block"></span>
                <span class="material-symbols-outlined text-base group-hover:translate-y-1 transition-transform">keyboard_arrow_down</span>
            </button>
        </div>

        <!-- Footer note -->
        <div class="mt-16 pt-8 border-t border-white/5 flex justify-between items-center">
            <p class="font-label text-[9px] text-on-surface/20 uppercase tracking-widest">Data aggregated from NASA NeoWs API · Refresh rate: 60s</p>
            <p class="font-label text-[9px] text-on-surface/20 uppercase tracking-widest">© 2025 CosmosIQ Orbital Command. All rights reserved.</p>
        </div>
    </section>

</main>

<%@ include file="common/footer.jspf" %>

<script>
const rows = document.querySelectorAll('.asteroid-row');

function loadMore() {
    let shown = 0;
    rows.forEach(row => {
        if (row.classList.contains('hidden-row') && !row.classList.contains('filter-hidden') && shown < 5) {
            row.classList.remove('hidden-row');
            shown++;
        }
    });
    const remaining = document.querySelectorAll('.asteroid-row.hidden-row:not(.filter-hidden)').length;
    if (remaining === 0) {
        document.getElementById('load-more-container').style.display = 'none';
    }
}

function filterAsteroids(type) {
    document.getElementById('btn-all').className = 'filter-btn' + (type === 'all' ? ' active' : '');
    document.getElementById('btn-hazardous').className = 'filter-btn' + (type === 'hazardous' ? ' active-hazardous' : '');
    document.getElementById('btn-safe').className = 'filter-btn' + (type === 'safe' ? ' active' : '');

    let visibleIndex = 0;
    rows.forEach(row => {
        const isHazardous = row.dataset.hazardous === 'true';
        const matches = type === 'all'
            || (type === 'hazardous' && isHazardous)
            || (type === 'safe' && !isHazardous);

        if (matches) {
            row.classList.remove('filter-hidden');
            if (visibleIndex < 5) {
                row.classList.remove('hidden-row');
            } else {
                row.classList.add('hidden-row');
            }
            visibleIndex++;
        } else {
            row.classList.add('filter-hidden');
            row.classList.add('hidden-row');
        }
    });

    const remaining = document.querySelectorAll('.asteroid-row.hidden-row:not(.filter-hidden)').length;
    document.getElementById('load-more-container').style.display = remaining > 0 ? 'flex' : 'none';
}
</script>
</body>
</html>