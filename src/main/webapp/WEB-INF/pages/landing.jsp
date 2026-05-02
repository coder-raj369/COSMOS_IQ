<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Explore the Cosmos</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body selection:bg-primary selection:text-on-primary-container">
<div class="grain-overlay"></div>
<nav class="fixed top-4 left-1/2 -translate-x-1/2 w-[95%] rounded-full border border-white/10 bg-slate-950/60 backdrop-blur-3xl z-50 flex justify-between items-center px-8 py-3 max-w-7xl mx-auto shadow-[0_20px_50px_rgba(0,0,0,0.5)]">
    <a class="text-2xl font-serif italic text-white" href="#">CosmosIQ</a>
    <div class="hidden md:flex gap-8 items-center">
        <a class="font-serif text-lg tracking-tight uppercase text-slate-300 hover:text-white transition-all" href="${pageContext.request.contextPath}/about">About</a>
        <a class="font-serif text-lg tracking-tight uppercase text-slate-300 hover:text-white transition-all" href="${pageContext.request.contextPath}/contact">Contact</a>
    </div>
    <div class="flex items-center gap-4">
        <a href="${pageContext.request.contextPath}/login" class="bg-primary text-on-primary px-6 py-1.5 rounded-full font-label text-sm font-bold uppercase tracking-widest hover:shadow-[0_0_20px_rgba(109,221,255,0.4)] transition-all">Launch</a>
    </div>
</nav>

<main class="relative min-h-screen w-full flex flex-col items-center justify-center overflow-hidden">
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_center,_rgba(109,221,255,0.08)_0%,_transparent_70%)] -z-10"></div>
    <div class="container mx-auto px-6 relative z-10 flex flex-col items-center text-center">
        <div class="absolute w-full max-w-3xl aspect-square top-1/2 left-1/2 -translate-x-1/2 -translate-y-[55%] pointer-events-none -z-10">
		    <img alt="Planet Earth from space" class="w-full h-full object-contain opacity-50"
		         src="${pageContext.request.contextPath}/images/earth_PNG39.png"/>
		</div>
        <h1 class="font-headline font-light italic text-[80px] md:text-[180px] leading-[0.85] tracking-tighter text-shimmer mb-8 select-none">
            Explore <br/> the cosmos.
        </h1>
        <p class="max-w-2xl text-on-surface-variant font-body text-lg md:text-xl leading-relaxed mb-12 opacity-80">
            NASA imagery, live asteroid tracking, and AI insights<br class="hidden md:block"/> for the curious. Peer into the void with professional precision.
        </p>
        <div class="flex flex-col sm:flex-row items-center gap-6">
            <a href="${pageContext.request.contextPath}/register" class="group relative bg-primary text-on-primary px-10 py-5 rounded-full font-label font-bold uppercase tracking-[0.2em] transition-all duration-500 hover:scale-105 hover:shadow-[0_0_40px_rgba(109,221,255,0.6)]">
                Begin journey
            </a>
            <a href="${pageContext.request.contextPath}/login" class="flex items-center gap-3 px-10 py-5 rounded-full border border-white/10 bg-white/5 font-label font-bold uppercase tracking-[0.2em] text-on-surface hover:bg-white/10 transition-all">
                <span class="material-symbols-outlined text-xl">login</span> Sign in
            </a>
        </div>
    </div>
    <div class="absolute bottom-12 left-1/2 -translate-x-1/2 flex flex-col items-center gap-4 opacity-40">
        <span class="font-label text-[10px] tracking-[0.5em] uppercase">Scroll to explore</span>
        <div class="w-[1px] h-20 bg-gradient-to-b from-primary to-transparent"></div>
    </div>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
