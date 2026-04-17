<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="home" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Dashboard</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="selection:bg-primary selection:text-on-primary">
<%@ include file="common/navbar.jspf" %>

<main>
<!-- Hero Section -->
<section class="relative h-screen flex flex-col justify-center items-center overflow-hidden">
    <div class="absolute inset-0 z-0">
        <c:choose>
            <c:when test="${not empty apod && not empty apod.url}">
                <img class="w-full h-full object-cover scale-110" src="${apod.url}" alt="${apod.title}"/>
            </c:when>
            <c:otherwise>
                <img class="w-full h-full object-cover scale-110" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBDG4YvoBTm--5HNgiCDREXYlO1LkGBA5aEcHPMaZyc7sT7aRQiNxSuAI5iFSRsN2VG5vcniTaPVGJXg3HCDbhzUVAwybMEXddoh2POnUtRjrds-GECansMg3W_U20bADosrFBom17eicawe1_UIeku-u7Tq58YvNDrIYGKPEVBvz8l4ksZ4n8j1bYWklgzAuF9r90Hs84MqJw8tF5tQa4oSwTuygQWSXftFnIesK2igt3HNx1D30hlao2-Vikxxa4WuC7tZXVJ1wA" alt="Earth from space"/>
            </c:otherwise>
        </c:choose>
        <div class="absolute inset-0 bg-gradient-to-b from-surface/20 via-surface/40 to-surface"></div>
        <div class="absolute inset-0 bg-[radial-gradient(circle_at_center,_transparent_0%,_#0c0e16_70%)]"></div>
    </div>
    <div class="relative z-10 text-center px-4 max-w-5xl">
        <span class="font-label text-primary text-xs uppercase tracking-[0.4em] mb-4 block">Orbital Status: Synchronized</span>
        <h1 class="font-headline text-6xl md:text-8xl font-bold tracking-tighter text-shimmer mb-12">
            Welcome back,<br/><span class="italic">${sessionScope.user.fullName}</span>
        </h1>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-full mt-12">
            <div class="bg-surface-container/60 backdrop-blur-xl border border-white/5 p-8 rounded-xl text-left hover:bg-surface-container-highest/80 transition-all duration-500">
                <div class="font-label text-primary-fixed-dim text-4xl mb-2">${favoritesCount}</div>
                <div class="font-label text-[10px] uppercase tracking-widest text-on-surface-variant">Favorites</div>
                <p class="text-xs text-on-surface-variant mt-4 leading-relaxed">Celestial bodies saved to your archive.</p>
            </div>
            <div class="bg-surface-container/60 backdrop-blur-xl border border-white/5 p-8 rounded-xl text-left hover:bg-surface-container-highest/80 transition-all duration-500 transform md:-translate-y-4">
                <div class="font-label text-primary-fixed-dim text-4xl mb-2">${asteroidCount}</div>
                <div class="font-label text-[10px] uppercase tracking-widest text-on-surface-variant">Asteroids This Week</div>
                <p class="text-xs text-on-surface-variant mt-4 leading-relaxed"><span class="text-secondary">${hazardousCount}</span> potentially hazardous.</p>
            </div>
            <div class="bg-surface-container/60 backdrop-blur-xl border border-white/5 p-8 rounded-xl text-left hover:bg-surface-container-highest/80 transition-all duration-500">
                <div class="font-label text-primary-fixed-dim text-4xl mb-2">${aiFactsCount}</div>
                <div class="font-label text-[10px] uppercase tracking-widest text-on-surface-variant">AI Facts Generated</div>
                <p class="text-xs text-on-surface-variant mt-4 leading-relaxed">Deep-space insights from the CosmosIQ AI core.</p>
            </div>
        </div>
    </div>
</section>

<!-- Today's APOD Section -->
<section class="relative min-h-screen bg-surface py-24 px-6 md:px-12 flex flex-col items-center">
    <div class="w-full max-w-7xl">
        <h2 class="font-headline text-5xl md:text-7xl font-bold tracking-tighter leading-none mb-6">Today in the<br/><span class="text-primary italic">Cosmos</span></h2>
        <p class="text-on-surface-variant font-body text-lg leading-relaxed mb-16 max-w-2xl">Daily observations captured and processed for your exploration.</p>

        <c:if test="${not empty apod}">
        <div class="relative group aspect-video md:aspect-[21/9] w-full rounded-2xl overflow-hidden shadow-2xl">
            <img class="w-full h-full object-cover transition-transform duration-[2000ms] group-hover:scale-105" src="${apod.url}" alt="${apod.title}"/>
            <div class="absolute bottom-0 left-0 p-8 md:p-12 w-full bg-gradient-to-t from-black/80 to-transparent">
                <div class="flex flex-col md:flex-row justify-between items-end gap-6">
                    <div>
                        <span class="font-label text-primary-dim text-xs uppercase tracking-widest mb-2 block">Astronomy Picture of the Day</span>
                        <h3 class="font-headline text-3xl md:text-5xl font-bold text-white mb-2">${apod.title}</h3>
                        <p class="font-label text-on-surface-variant text-sm tracking-widest">${apod.date}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/apod" class="flex items-center gap-4 bg-white/10 backdrop-blur-md border border-white/20 hover:bg-white/20 px-8 py-4 rounded-full transition-all">
                        <span class="font-label text-sm uppercase tracking-widest text-white">Explore APOD</span>
                        <span class="material-symbols-outlined text-primary">arrow_forward</span>
                    </a>
                </div>
            </div>
        </div>
        </c:if>

        <!-- Quick Links Grid -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mt-12">
            <a href="${pageContext.request.contextPath}/mars" class="bg-surface-container-low p-10 rounded-2xl border border-white/5 hover:bg-surface-container-high transition-colors group">
                <span class="material-symbols-outlined text-primary text-4xl mb-6">public</span>
                <h4 class="font-headline text-2xl font-bold mb-4">Mars Rover</h4>
                <p class="text-on-surface-variant text-sm leading-relaxed">Browse real photos from Curiosity and Perseverance.</p>
            </a>
            <a href="${pageContext.request.contextPath}/asteroids" class="bg-surface-container-low p-10 rounded-2xl border border-white/5 hover:bg-surface-container-high transition-colors group">
                <span class="material-symbols-outlined text-secondary text-4xl mb-6">sensors</span>
                <h4 class="font-headline text-2xl font-bold mb-4">Asteroid Tracker</h4>
                <p class="text-on-surface-variant text-sm leading-relaxed">Near-Earth objects passing by this week.</p>
            </a>
            <a href="${pageContext.request.contextPath}/favorites" class="bg-surface-container-low p-10 rounded-2xl border border-white/5 hover:bg-surface-container-high transition-colors group">
                <span class="material-symbols-outlined text-primary text-4xl mb-6">favorite</span>
                <h4 class="font-headline text-2xl font-bold mb-4">Your Archive</h4>
                <p class="text-on-surface-variant text-sm leading-relaxed">View your saved celestial objects.</p>
            </a>
        </div>
    </div>
</section>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
