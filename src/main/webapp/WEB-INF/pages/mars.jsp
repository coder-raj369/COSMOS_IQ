<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="mars" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Mars Rover</title>
<%@ include file="common/head.jspf" %>
<style>.masonry-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));grid-auto-rows:250px;gap:24px}.masonry-item-large{grid-row:span 2}</style>
</head>
<body class="bg-surface text-on-surface">
<%@ include file="common/navbar.jspf" %>

<main class="relative pt-20">
<!-- Hero -->
<section class="relative min-h-[60vh] flex flex-col items-center justify-center text-center overflow-hidden px-6"
         style="background:radial-gradient(circle at 70% 30%,rgba(196,77,46,0.15) 0%,transparent 60%)">
    <div class="absolute inset-0 z-0">
        <img class="w-full h-full object-cover opacity-40" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDBVVYUEggiT027Yo2-N-Z5yIOM-VoTTWCpGMM0tGzRZwTwlRZYKz51jJ78VTpsHHMbcuSawxaxvlgYxfkWWIWU3kfZVPcS4bd3J2ZSOLVN8rIfYhilvovxy3TwEL54S4prFe77cWml9mgj-r0MeHoKmQ9d3-G6mIXkdcvOoCfbjbsY4sMCkMbI8Y34zQo34uIquCe4NlsTULsYVM5Sfu_DuJH6F824vVsiBPfl1lqoqWK0YFUsaEiIKJF2_1hIdCP4CzVK7HzJkCA" alt="Mars"/>
        <div class="absolute inset-0 bg-gradient-to-b from-[#0c0e16]/20 via-transparent to-[#0c0e16]"></div>
    </div>
    <div class="relative z-10 space-y-8 max-w-5xl">
        <h1 class="text-[100px] md:text-[140px] leading-none font-headline font-light italic tracking-tight text-on-surface">Meet Mars.</h1>
        <p class="text-xl font-body font-light text-on-surface-variant max-w-2xl mx-auto">Real photos from NASA rovers exploring the red planet.</p>
        <!-- Rover Selector -->
        <div class="flex flex-wrap justify-center gap-12 mt-16">
		    <a href="${pageContext.request.contextPath}/mars?rover=curiosity" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${selectedRover == 'curiosity' ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">curiosity</a>
		    <a href="${pageContext.request.contextPath}/mars?rover=perseverance" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${selectedRover == 'perseverance' ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">perseverance</a>
		    <a href="${pageContext.request.contextPath}/mars?rover=opportunity" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${selectedRover == 'opportunity' ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">opportunity</a>
		    <a href="${pageContext.request.contextPath}/mars?rover=spirit" class="font-label text-xs tracking-[0.2em] uppercase pb-2 ${selectedRover == 'spirit' ? 'border-b-2 border-primary text-primary' : 'border-b-2 border-transparent text-on-surface/40 hover:text-on-surface'} transition-colors">spirit</a>
		</div>
    </div>
</section>

<!-- Filters -->
<section class="max-w-7xl mx-auto px-8 -mt-12 relative z-20">
    <form method="GET" action="${pageContext.request.contextPath}/mars" class="bg-surface-container/60 backdrop-blur-[40px] border border-white/10 p-8 rounded-lg shadow-2xl flex flex-wrap items-center gap-8">
        <input type="hidden" name="rover" value="${selectedRover}"/>
        <div class="flex flex-col">
            <span class="font-label text-[10px] text-on-surface/40 uppercase mb-1">Earth Date</span>
            <input type="date" name="earth_date" value="${selectedDate}" class="bg-surface-container-lowest/40 border border-white/5 text-sm py-2 px-4 focus:border-primary focus:ring-0 text-on-surface"/>
        </div>
        <div class="flex flex-col">
            <span class="font-label text-[10px] text-on-surface/40 uppercase mb-1">Camera</span>
            <select name="camera" class="bg-surface-container-lowest/40 border border-white/5 text-sm py-2 px-4 focus:border-primary focus:ring-0 text-on-surface">
                <option value="">All Cameras</option>
                <option value="fhaz" ${selectedCamera=='fhaz'?'selected':''}>FHAZ</option>
                <option value="rhaz" ${selectedCamera=='rhaz'?'selected':''}>RHAZ</option>
                <option value="mast" ${selectedCamera=='mast'?'selected':''}>MAST</option>
                <option value="navcam" ${selectedCamera=='navcam'?'selected':''}>NAVCAM</option>
            </select>
        </div>
        <button type="submit" class="bg-primary text-on-primary px-8 py-2 font-label text-[10px] uppercase tracking-widest mt-4">Search</button>
    </form>
</section>

<!-- Photo Grid -->
<section class="max-w-7xl mx-auto px-8 py-24">
    <c:if test="${empty photos}">
        <div class="text-center py-24">
            <span class="material-symbols-outlined text-6xl text-on-surface-variant/30 mb-6">image_not_supported</span>
            <p class="font-headline text-2xl italic text-on-surface-variant">No photos found for this selection.</p>
            <p class="text-sm text-on-surface-variant/60 mt-2">Try a different date or camera.</p>
        </div>
    </c:if>
    <div class="masonry-grid">
        <c:forEach items="${photos}" var="photo" varStatus="s">
        <div class="group relative overflow-hidden bg-surface-container-low rounded-lg border border-white/5 hover:scale-[1.02] transition-all duration-500 ${s.index % 5 == 0 ? 'masonry-item-large' : ''}">
            <img class="w-full h-full object-cover" src="${photo.img_src}" alt="Mars ${photo.camera}"/>
            <div class="absolute inset-0 bg-gradient-to-t from-surface-container-lowest via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
            <div class="absolute bottom-0 left-0 right-0 p-4 translate-y-8 group-hover:translate-y-0 transition-transform duration-500">
                <div class="flex justify-between items-end">
                    <div class="space-y-1">
                        <span class="font-label text-[10px] tracking-[0.2em] text-primary uppercase">SOL ${photo.sol}</span>
                        <p class="font-body text-xs text-on-surface-variant uppercase tracking-widest">${photo.camera}</p>
                        <p class="font-body text-[10px] text-on-surface/40">${photo.earth_date}</p>
                    </div>
                    <div class="flex gap-2">
                        <form method="POST" action="${pageContext.request.contextPath}/favorites">
                            <input type="hidden" name="action" value="save"/>
                            <input type="hidden" name="type" value="mars"/>
                            <input type="hidden" name="title" value="${photo.rover} - Sol ${photo.sol}"/>
                            <input type="hidden" name="imageUrl" value="${photo.img_src}"/>
                            <input type="hidden" name="sourceDate" value="${photo.earth_date}"/>
                            <input type="hidden" name="description" value="Camera: ${photo.camera}"/>
                            <button type="submit" class="w-8 h-8 rounded-full border border-white/10 flex items-center justify-center hover:bg-primary/20 hover:text-primary transition-colors">
                                <span class="material-symbols-outlined text-sm">favorite</span>
                            </button>
                        </form>
                        <button onclick="generateAiFact('mars:${photo.id}','Mars rover photo from ${photo.rover}, camera ${photo.camera}, sol ${photo.sol}','mars-fact-${photo.id}')" class="w-8 h-8 rounded-full border border-white/10 flex items-center justify-center hover:bg-primary/20 hover:text-primary transition-colors">
                            <span class="material-symbols-outlined text-sm">auto_awesome</span>
                        </button>
                    </div>
                </div>
                <div id="mars-fact-${photo.id}" class="mt-2 text-[10px] text-primary/80 hidden"></div>
            </div>
        </div>
        </c:forEach>
    </div>
</section>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
