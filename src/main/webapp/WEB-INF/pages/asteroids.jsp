<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="asteroids" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Asteroid Tracker</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-background text-on-surface font-body">
<%@ include file="common/navbar.jspf" %>

<main class="pt-24 min-h-screen">
<!-- Hero -->
<section class="relative h-[60vh] flex flex-col justify-center px-8 md:px-20 overflow-hidden">
    <div class="absolute inset-0 z-0">
        <div class="absolute inset-0 bg-gradient-to-b from-transparent via-background/40 to-background"></div>
        <img class="w-full h-full object-cover opacity-30 grayscale contrast-125" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCjSSGo7SrgJFiiZI5DYKbl3t9T4P8SqcMJtoZEZKfg0rV07P8QWZCo2PFAHxrpadp3lU29ggzn_zdobgKyaijpVUHIkjowxoTOb4zuZ6Vmpwmf7_0F2WWgfPMV_HungOKhlhtImiYL6mfXkHFYHkO9s6d9FSghfv5wbLwpmFUPINmRRgvPRlnyBRL76mvJMTK0rDmH1oPcY4gLQKjPxBzO56A2I3FeFgJIJLUSYwSIh1l4kp_s_1KnyQ_3we-Stc3WOfSerMokc1I" alt="Asteroids"/>
    </div>
    <div class="relative z-10 max-w-6xl">
        <p class="font-label text-primary tracking-[0.4em] text-xs mb-6 flex items-center gap-3">
            <span class="w-12 h-[1px] bg-primary"></span> PLANETARY DEFENSE // LIVE FEED
        </p>
        <h1 class="a-split font-headline text-7xl md:text-[100px] leading-[0.9] font-light italic text-shimmer mb-8 tracking-tighter">Threats in the<br/>neighborhood.</h1>
    </div>
</section>

<!-- Stat Bar -->
<section class="px-8 -mt-12 relative z-20">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 max-w-7xl mx-auto">
        <div class="glass-panel p-8 a-reveal">
            <p class="font-label text-[10px] text-on-surface-variant uppercase tracking-widest mb-4">Total Tracked</p>
            <p class="text-4xl font-headline a-counter">${totalCount}</p>
        </div>
        <div class="glass-panel p-8 border-l-4 border-secondary a-reveal a-d2">
            <p class="font-label text-[10px] text-secondary uppercase tracking-widest mb-4">Potentially Hazardous</p>
            <p class="text-4xl font-headline text-secondary a-counter">${hazardousCount}</p>
        </div>
        <div class="glass-panel p-8 a-reveal a-d4">
            <p class="font-label text-[10px] text-on-surface-variant uppercase tracking-widest mb-4">Data Source</p>
            <p class="text-lg font-label">NASA NeoWs API</p>
        </div>
        <div class="glass-panel p-8 a-reveal a-d6">
            <p class="font-label text-[10px] text-primary uppercase tracking-widest mb-4">Status</p>
            <p class="text-lg font-label text-primary flex items-center gap-2"><span class="w-2 h-2 rounded-full bg-primary animate-pulse"></span> Live Feed</p>
        </div>
    </div>
</section>

<!-- Asteroid List -->
<section class="py-24 px-8 max-w-7xl mx-auto">
    <div class="space-y-4" data-stagger="0.05">
        <c:forEach items="${asteroids}" var="a">
        <div class="glass-panel group flex flex-col md:flex-row items-center gap-8 p-8 hover:bg-surface-bright transition-all duration-500">
            <!-- Size Viz -->
            <div class="w-24 h-24 flex items-center justify-center relative">
                <c:choose>
                    <c:when test="${a.hazardous == 'true'}">
                        <div class="absolute w-16 h-16 bg-secondary/20 blur-xl rounded-full animate-pulse"></div>
                        <div class="w-12 h-12 bg-secondary rounded-full relative z-10 shadow-[0_0_20px_rgba(253,182,75,0.5)]"></div>
                    </c:when>
                    <c:otherwise>
                        <div class="absolute w-8 h-8 bg-primary/20 blur-xl rounded-full"></div>
                        <div class="w-4 h-4 bg-primary rounded-full relative z-10 opacity-80"></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- Info -->
            <div class="flex-1 grid grid-cols-1 lg:grid-cols-4 items-center gap-8">
                <div>
                    <p class="font-label text-[10px] ${a.hazardous == 'true' ? 'text-secondary' : 'text-primary'} tracking-widest uppercase mb-1">${a.hazardous == 'true' ? 'HAZARDOUS' : 'SAFE'}</p>
                    <h3 class="font-headline text-2xl font-bold">${a.name}</h3>
                    <p class="font-label text-xs text-on-surface-variant mt-1">${a.close_approach_date}</p>
                </div>
                <div class="space-y-1">
                    <p class="font-label text-[9px] text-on-surface-variant uppercase">Diameter</p>
                    <p class="text-lg font-headline italic">${a.diameter}</p>
                </div>
                <div class="space-y-1">
                    <p class="font-label text-[9px] text-on-surface-variant uppercase">Velocity</p>
                    <p class="text-lg font-headline italic">${a.velocity} <span class="text-xs">km/s</span></p>
                </div>
                <div class="space-y-1">
                    <p class="font-label text-[9px] text-on-surface-variant uppercase">Miss Distance</p>
                    <p class="text-lg font-headline italic">${a.miss_distance_lunar} <span class="text-xs">LD</span></p>
                </div>
            </div>
            <!-- AI Fact + Save -->
            <div class="flex items-center gap-2">
                <button onclick="generateAiFact('asteroid:${a.id}','Near-Earth asteroid ${a.name}, diameter ${a.diameter}, velocity ${a.velocity} km/s','ast-fact-${a.id}')" class="p-2 hover:text-primary transition-colors">
                    <span class="material-symbols-outlined">auto_awesome</span>
                </button>
                <form method="POST" action="${pageContext.request.contextPath}/favorites" style="display:inline">
                    <input type="hidden" name="action" value="save"/>
                    <input type="hidden" name="type" value="asteroid"/>
                    <input type="hidden" name="title" value="${a.name}"/>
                    <input type="hidden" name="description" value="Diameter: ${a.diameter}, Velocity: ${a.velocity} km/s"/>
                    <input type="hidden" name="sourceDate" value="${a.close_approach_date}"/>
                    <button type="submit" class="p-2 hover:text-primary transition-colors"><span class="material-symbols-outlined">favorite</span></button>
                </form>
            </div>
        </div>
        <div id="ast-fact-${a.id}" class="ml-32 text-xs text-primary/80 hidden mb-2"></div>
        </c:forEach>
    </div>
</section>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
