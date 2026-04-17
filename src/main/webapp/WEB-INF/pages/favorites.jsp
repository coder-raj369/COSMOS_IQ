<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="favorites" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Favorites</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-background text-on-surface font-body">
<%@ include file="common/navbar.jspf" %>

<!-- Hero -->
<header class="min-h-[40vh] w-full flex flex-col justify-end px-12 pb-16 pt-32" style="background:radial-gradient(circle at 20% 30%,rgba(109,221,255,0.05) 0%,transparent 50%),linear-gradient(to bottom,#1a0b2e 0%,#0c0e16 100%)">
    <span class="font-label text-[10px] tracking-[0.4em] text-primary uppercase mb-4">PERSONAL ARCHIVE</span>
    <h1 class="font-headline italic font-light text-7xl md:text-[100px] leading-none mb-6 tracking-tighter text-shimmer">Your saved universe.</h1>
    <p class="font-label text-on-surface-variant text-sm">${totalCount} stellar objects saved</p>
</header>

<!-- Filter Bar -->
<div class="sticky top-[72px] z-[40] px-8 py-4">
    <div class="glass-panel rounded-full px-6 py-3 flex flex-wrap md:flex-nowrap items-center justify-between gap-6 shadow-2xl">
        <div class="flex items-center gap-6">
            <a href="${pageContext.request.contextPath}/favorites" class="font-label text-xs uppercase tracking-widest ${activeFilter == 'all' || empty activeFilter ? 'text-primary border-b-2 border-primary' : 'text-on-surface-variant hover:text-on-surface'} pb-1 transition-colors">ALL</a>
            <a href="${pageContext.request.contextPath}/favorites?type=apod" class="font-label text-xs uppercase tracking-widest ${activeFilter == 'apod' ? 'text-primary border-b-2 border-primary' : 'text-on-surface-variant hover:text-on-surface'} pb-1 transition-colors">APOD</a>
            <a href="${pageContext.request.contextPath}/favorites?type=mars" class="font-label text-xs uppercase tracking-widest ${activeFilter == 'mars' ? 'text-primary border-b-2 border-primary' : 'text-on-surface-variant hover:text-on-surface'} pb-1 transition-colors">MARS</a>
            <a href="${pageContext.request.contextPath}/favorites?type=asteroid" class="font-label text-xs uppercase tracking-widest ${activeFilter == 'asteroid' ? 'text-primary border-b-2 border-primary' : 'text-on-surface-variant hover:text-on-surface'} pb-1 transition-colors">ASTEROIDS</a>
        </div>
        <form method="GET" action="${pageContext.request.contextPath}/favorites" class="flex-1 max-w-md relative">
            <input type="text" name="search" value="${searchQuery}" placeholder="Search your archive..." class="w-full bg-surface-container-lowest border border-white/10 rounded-full py-2 px-10 text-sm focus:outline-none focus:ring-1 focus:ring-primary/50"/>
            <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/60 text-lg">search</span>
        </form>
    </div>
</div>

<!-- Grid -->
<main class="px-8 py-12">
    <c:if test="${empty favorites}">
        <div class="flex flex-col items-center justify-center py-24">
            <span class="material-symbols-outlined text-6xl text-on-surface-variant/20 mb-6">rocket</span>
            <h3 class="font-headline text-3xl italic text-on-surface-variant mb-2">Your universe awaits</h3>
            <p class="text-sm text-on-surface-variant/60">Start exploring and save your favorite discoveries.</p>
            <a href="${pageContext.request.contextPath}/apod" class="mt-8 bg-primary text-on-primary px-8 py-3 rounded-full font-label text-xs uppercase tracking-widest">Begin Exploring</a>
        </div>
    </c:if>

    <div class="columns-1 md:columns-2 lg:columns-3 xl:columns-4 gap-8 space-y-8">
        <c:forEach items="${favorites}" var="fav">
        <div class="break-inside-avoid group relative rounded-lg overflow-hidden glass-panel hover:scale-[1.02] transition-all duration-500">
            <!-- Delete button -->
            <form method="POST" action="${pageContext.request.contextPath}/favorites" class="absolute top-4 right-4 z-20 opacity-0 group-hover:opacity-100 transition-opacity">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="favId" value="${fav.id}"/>
                <button type="submit" class="w-8 h-8 rounded-full bg-black/40 backdrop-blur-md flex items-center justify-center hover:bg-error/20 transition-colors">
                    <span class="material-symbols-outlined text-sm text-on-surface">close</span>
                </button>
            </form>
            <c:if test="${not empty fav.imageUrl}">
            <div class="relative h-64 overflow-hidden">
                <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" src="${fav.imageUrl}" alt="${fav.title}"/>
                <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
                <div class="absolute top-4 left-4">
                    <span class="font-label text-[10px] tracking-widest bg-primary text-on-primary px-2 py-0.5 rounded-full uppercase">${fav.type}</span>
                </div>
            </div>
            </c:if>
            <c:if test="${empty fav.imageUrl}">
            <div class="p-6 pb-0">
                <span class="font-label text-[10px] tracking-widest bg-secondary/20 text-secondary px-2 py-0.5 rounded-full uppercase">${fav.type}</span>
            </div>
            </c:if>
            <div class="p-6">
                <div class="flex justify-between items-start mb-2">
                    <h3 class="font-headline text-xl text-on-surface leading-tight">${fav.title}</h3>
                    <span class="material-symbols-outlined text-primary" style="font-variation-settings:'FILL' 1;">favorite</span>
                </div>
                <p class="font-label text-[10px] text-on-surface-variant uppercase tracking-widest mb-2">${fav.sourceDate}</p>
                <c:if test="${not empty fav.description}">
                    <p class="text-xs text-on-surface-variant leading-relaxed line-clamp-2">${fav.description}</p>
                </c:if>
            </div>
        </div>
        </c:forEach>
    </div>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
