<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="currentPage" value="apod" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | APOD</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface">
<%@ include file="common/navbar.jspf" %>

<main class="relative pt-20">
<c:if test="${not empty apod}">
<!-- Hero Image -->
<section class="relative min-h-[80vh] flex items-end overflow-hidden">
    <c:choose>
        <c:when test="${apod.media_type == 'video' && not empty apod.video_url && fn:contains(apod.video_url, 'youtube')}">
            <iframe class="absolute inset-0 w-full h-full" src="${apod.video_url}" frameborder="0" allowfullscreen></iframe>
        </c:when>
        <c:otherwise>
            <%-- apod.url is always an image (thumbnail for video days, or the actual image) --%>
            <img class="absolute inset-0 w-full h-full object-cover" src="${apod.url}" alt="${apod.title}"/>
        </c:otherwise>
    </c:choose>
    <div class="absolute inset-0 bg-gradient-to-t from-[#05060d] via-transparent to-black/40"></div>
    <div class="container mx-auto px-6 pb-24 relative z-10 grid grid-cols-12 items-end">
        <div class="col-span-12 lg:col-span-8">
            <p class="a-reveal font-label text-primary tracking-[0.4em] uppercase text-[10px] mb-4">Stellar Archive // ${apod.date}</p>
            <h1 class="a-split font-headline font-light italic text-7xl md:text-[100px] text-shimmer leading-[0.9]">${apod.title}</h1>
        </div>
        <div class="col-span-12 lg:col-span-4 mt-12 lg:mt-0 flex justify-end">
            <div class="a-reveal a-d3 glass-panel p-8 rounded-xl max-w-sm w-full">
                <p class="font-body text-sm text-on-surface-variant leading-relaxed mb-6">${apod.explanation}</p>
                <c:if test="${not empty apod.copyright}">
                    <p class="font-label text-[10px] text-on-surface-variant mb-4">Credit: ${apod.copyright}</p>
                </c:if>
                <button onclick="generateAiFact('apod:${apod.date}', '${apod.title}', 'apod-fact')" class="w-full py-4 glass-panel border-primary/30 text-primary font-label text-[11px] uppercase tracking-[0.2em] flex items-center justify-center gap-3 hover:bg-primary hover:text-on-primary transition-all duration-500">
                    <span class="material-symbols-outlined text-sm" style="font-variation-settings:'FILL' 1;">auto_awesome</span>
                    Generate AI Insight
                </button>
                <div id="apod-fact" class="mt-4 text-xs text-primary/80 leading-relaxed hidden"></div>
                <!-- Save to favorites -->
                <form method="POST" action="${pageContext.request.contextPath}/favorites" class="mt-4">
                    <input type="hidden" name="action" value="save"/>
                    <input type="hidden" name="type" value="apod"/>
                    <input type="hidden" name="title" value="${apod.title}"/>
                    <input type="hidden" name="description" value="${apod.explanation}"/>
                    <input type="hidden" name="imageUrl" value="${apod.url}"/>
                    <input type="hidden" name="sourceDate" value="${apod.date}"/>
                    <button type="submit" class="w-full py-3 border border-white/10 text-on-surface-variant font-label text-[10px] uppercase tracking-widest hover:text-primary hover:border-primary/30 transition-all flex items-center justify-center gap-2">
                        <span class="material-symbols-outlined text-sm">favorite</span> Save to Archive
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>
</c:if>

<!-- Date Picker -->
<section class="bg-surface-container-lowest border-y border-white/5 py-4">
    <div class="container mx-auto px-6 flex items-center gap-6">
        <span class="font-label text-[10px] text-on-surface-variant uppercase tracking-widest">Timeline:</span>
        <form method="GET" action="${pageContext.request.contextPath}/apod" class="flex items-center gap-4 flex-1">
            <input type="date" name="date" value="${selectedDate}" class="bg-surface-container-lowest border border-white/10 text-sm py-2 px-4 focus:border-primary focus:ring-0 font-label text-on-surface"/>
            <button type="submit" class="bg-primary text-on-primary px-6 py-2 font-label text-[10px] uppercase tracking-widest">Load</button>
        </form>
    </div>
</section>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
