<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="mars" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Mars Rover</title>
<%@ include file="common/head.jspf" %>
<style>.masonry-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:16px}</style>
</head>
<body class="bg-surface text-on-surface">
<%@ include file="common/navbar.jspf" %>

<main class="relative pt-20">

    <!-- Hero -->
    <section class="relative min-h-[50vh] flex flex-col items-center justify-center text-center overflow-hidden px-6"
             style="background:radial-gradient(circle at 70% 30%,rgba(196,77,46,0.15) 0%,transparent 60%)">
        <div class="absolute inset-0 z-0">
            <img class="w-full h-full object-cover opacity-40"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuDBVVYUEggiT027Yo2-N-Z5yIOM-VoTTWCpGMM0tGzRZwTwlRZYKz51jJ78VTpsHHMbcuSawxaxvlgYxfkWWIWU3kfZVPcS4bd3J2ZSOLVN8rIfYhilvovxy3TwEL54S4prFe77cWml9mgj-r0MeHoKmQ9d3-G6mIXkdcvOoCfbjbsY4sMCkMbI8Y34zQo34uIquCe4NlsTULsYVM5Sfu_DuJH6F824vVsiBPfl1lqoqWK0YFUsaEiIKJF2_1hIdCP4CzVK7HzJkCA" alt="Mars"/>
            <div class="absolute inset-0 bg-gradient-to-b from-[#0c0e16]/20 via-transparent to-[#0c0e16]"></div>
        </div>
        <div class="relative z-10 space-y-6 max-w-5xl">
            <h1 class="a-split text-[80px] md:text-[120px] leading-none font-headline font-light italic tracking-tight text-on-surface">Meet Mars.</h1>
            <p class="a-reveal a-d3 text-lg font-body font-light text-on-surface-variant max-w-2xl mx-auto">Real photos from NASA rovers exploring the red planet.</p>

            <!-- Rover Selector -->
            <div class="a-reveal a-d5 flex flex-wrap justify-center gap-10 mt-8">
                <a href="${pageContext.request.contextPath}/mars" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${'all' == selectedRover ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">All Rovers</a>
                <a href="${pageContext.request.contextPath}/mars?rover=curiosity" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${'curiosity' == selectedRover ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">Curiosity</a>
                <a href="${pageContext.request.contextPath}/mars?rover=perseverance" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${'perseverance' == selectedRover ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">Perseverance</a>
                <a href="${pageContext.request.contextPath}/mars?rover=opportunity" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${'opportunity' == selectedRover ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">Opportunity</a>
                <a href="${pageContext.request.contextPath}/mars?rover=spirit" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${'spirit' == selectedRover ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">Spirit</a>
            </div>
        </div>
    </section>

    <!-- Camera Filter -->
    <section class="max-w-7xl mx-auto px-8 py-6 border-b border-white/5">
        <div class="flex flex-wrap items-center gap-3">
            <span class="font-label text-[10px] text-on-surface-variant uppercase tracking-widest mr-2">Camera:</span>
            <c:set var="baseUrl" value="${pageContext.request.contextPath}/mars${not empty selectedRover and selectedRover != 'all' ? '?rover='.concat(selectedRover) : '?'}" />
            <a href="${pageContext.request.contextPath}/mars${not empty selectedRover and selectedRover != 'all' ? '?rover='.concat(selectedRover) : ''}"
               class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${empty selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">All</a>
            <a href="${pageContext.request.contextPath}/mars?${not empty selectedRover and selectedRover != 'all' ? 'rover='.concat(selectedRover).concat('&') : ''}camera=fhaz"
			   class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${'fhaz' == selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">FHAZ</a>
			<a href="${pageContext.request.contextPath}/mars?${not empty selectedRover and selectedRover != 'all' ? 'rover='.concat(selectedRover).concat('&') : ''}camera=rhaz"
			   class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${'rhaz' == selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">RHAZ</a>
			<a href="${pageContext.request.contextPath}/mars?${not empty selectedRover and selectedRover != 'all' ? 'rover='.concat(selectedRover).concat('&') : ''}camera=navcam"
			   class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${'navcam' == selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">NAVCAM</a>
			<a href="${pageContext.request.contextPath}/mars?${not empty selectedRover and selectedRover != 'all' ? 'rover='.concat(selectedRover).concat('&') : ''}camera=mast"
			   class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${'mast' == selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">MAST</a>
			<a href="${pageContext.request.contextPath}/mars?${not empty selectedRover and selectedRover != 'all' ? 'rover='.concat(selectedRover).concat('&') : ''}camera=pancam"
			   class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${'pancam' == selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">PANCAM</a>
			<a href="${pageContext.request.contextPath}/mars?${not empty selectedRover and selectedRover != 'all' ? 'rover='.concat(selectedRover).concat('&') : ''}camera=mahli"
			   class="px-3 py-1.5 font-label text-[10px] uppercase tracking-widest rounded ${'mahli' == selectedCamera ? 'bg-primary text-on-primary' : 'glass-panel text-on-surface-variant hover:text-on-surface'} transition-all">MAHLI</a>
            <c:if test="${not empty photos}">
                <span class="ml-auto font-label text-[10px] text-on-surface-variant/40 uppercase tracking-widest">${photos.size()} photos</span>
            </c:if>
        </div>
    </section>

    <!-- Photo Grid -->
    <section class="max-w-7xl mx-auto px-8 py-12 pb-24">
        <c:if test="${empty photos}">
            <div class="text-center py-24">
                <span class="material-symbols-outlined text-6xl text-on-surface-variant/30 mb-6 block">image_not_supported</span>
                <p class="font-headline text-2xl italic text-on-surface-variant">No photos found for this selection.</p>
                <p class="text-sm text-on-surface-variant/60 mt-2">Try a different camera or rover.</p>
            </div>
        </c:if>
        <div class="masonry-grid" data-stagger="0.06">
            <c:forEach items="${photos}" var="photo">
            <div class="group relative overflow-hidden bg-surface-container-low rounded-lg border border-white/5 hover:border-primary/20 hover:scale-[1.02] transition-all duration-500 aspect-square">
                <img class="w-full h-full object-cover" src="${photo.img_src}" alt="Mars photo" loading="lazy"/>
                <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
                <div class="absolute bottom-0 left-0 right-0 p-4 translate-y-8 group-hover:translate-y-0 transition-transform duration-500">
                    <div class="flex justify-between items-end">
                        <div class="space-y-0.5">
                            <span class="font-label text-[9px] tracking-[0.2em] text-primary uppercase block">${photo.rover}</span>
                            <p class="font-body text-[10px] text-on-surface-variant uppercase tracking-widest">${photo.camera}</p>
                            <p class="font-body text-[9px] text-on-surface/50">${photo.earth_date} · Sol ${photo.sol}</p>
                        </div>
                        <div class="flex gap-2">
                            <button onclick="generateAiFact('mars:${photo.id}','Mars rover photo from ${photo.rover}, camera ${photo.camera}, date ${photo.earth_date}','mars-fact-${photo.id}')"
                                    class="w-8 h-8 rounded-full border border-white/10 flex items-center justify-center hover:bg-primary/20 hover:text-primary transition-colors">
                                <span class="material-symbols-outlined text-sm">auto_awesome</span>
                            </button>
                            <form method="POST" action="${pageContext.request.contextPath}/favorites">
                                <input type="hidden" name="action" value="save"/>
                                <input type="hidden" name="type" value="mars"/>
                                <input type="hidden" name="title" value="${photo.rover} - ${photo.earth_date}"/>
                                <input type="hidden" name="imageUrl" value="${photo.img_src}"/>
                                <input type="hidden" name="sourceDate" value="${photo.earth_date}"/>
                                <input type="hidden" name="description" value="Camera: ${photo.camera}"/>
                                <button type="submit" class="w-8 h-8 rounded-full border border-white/10 flex items-center justify-center hover:bg-primary/20 hover:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-sm">favorite</span>
                                </button>
                            </form>
                        </div>
                    </div>
                    <div id="mars-fact-${photo.id}" class="mt-2 text-[10px] text-primary/80 hidden leading-relaxed"></div>
                </div>
            </div>
            </div>
            </c:forEach>
        </div>
    </section>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>