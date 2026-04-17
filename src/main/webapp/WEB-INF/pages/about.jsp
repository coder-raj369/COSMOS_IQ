<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="about" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | About</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-[#05060d] text-on-surface font-body">
<%@ include file="common/navbar.jspf" %>

<main>
<!-- Hero -->
<section class="relative h-screen flex flex-col justify-center items-center overflow-hidden px-6">
    <div class="absolute inset-0 z-0">
        <img class="w-full h-full object-cover scale-110 opacity-50" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC65QO6o9UGdgsZcMxxrrMpZRBNe4x9ZID_atsS4m_KAuOpfoCV04qPYgy7XSaMdTIZHbesc3Shbxg0ma-Gb7550ZgRmW1mKt96yPo_UFX29gzDPERPjO0kkDb8u1cQc-5rjsasrOQlIP3rBrQqd-H1d4Ip2tkQPUXuntwXboa_zScr8-8qMM1KC6FoXm0xvCqBlZ4eaJcl3HHJMMpiamcopdtgDgapP1Rx3jZZoW9x0Mpx7GJsHkcfGUVUIHfW01TDNKM9IEjcpAc" alt="Nebula"/>
        <div class="absolute inset-0 bg-gradient-to-b from-transparent via-[#05060d]/20 to-[#05060d]"></div>
    </div>
    <div class="relative z-10 text-center">
        <p class="font-label text-xs uppercase tracking-[0.4em] text-primary mb-8">OUR MISSION</p>
        <h1 class="font-headline italic font-extralight text-6xl md:text-[120px] leading-tight text-shimmer mb-10 tracking-tighter">Making the cosmos<br/>accessible.</h1>
        <p class="font-body text-on-surface-variant max-w-2xl mx-auto text-lg leading-relaxed">CosmosIQ is the premier interface for celestial observation and planetary intelligence.</p>
    </div>
</section>

<!-- Why we exist -->
<section class="py-32 px-6 md:px-24">
    <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-20 items-center">
        <img class="rounded-lg shadow-2xl" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDFRxmtCkfsuYWKudPMQ-fmD3bHE279PxV1mOJbAlj0LDdq0SpqX_jR1oJyucovFEwxAKgsRy1w66WOk-HXc8050bFhBx6E87zOQimzIkZhULCXJeMd1IBr425TgqZpee9y5jO-RQfRx2DjJKxe6v1_9LKhyri6b6nT76_Kix1bxKQGs0iLgcdl-FR2eG9Fj3_U0W1HttEq9fFd-A5NTUPGZhu2aiqo9idoCo7EIWPBvL0NjNZNnZ9F3GNeTthhfbLg6h_Yt1qeMQc" alt="Earth"/>
        <div>
            <h2 class="font-headline text-4xl md:text-5xl mb-8">Why we exist</h2>
            <p class="text-on-surface-variant text-lg leading-relaxed mb-12">For decades, humanity's greatest discoveries have remained locked behind technical barriers and complex datasets. We believe the wonders of the universe should be accessible to everyone. CosmosIQ bridges the gap between raw NASA data and intuitive interfaces.</p>
            <div class="flex flex-wrap gap-12 border-t border-white/5 pt-12">
                <div><p class="font-label text-2xl text-primary">15K+</p><p class="font-label text-[10px] text-slate-500 uppercase tracking-widest">images archived</p></div>
                <div><p class="font-label text-2xl text-secondary">24/7</p><p class="font-label text-[10px] text-slate-500 uppercase tracking-widest">asteroid tracking</p></div>
                <div><p class="font-label text-2xl text-primary-dim">AI-POWERED</p><p class="font-label text-[10px] text-slate-500 uppercase tracking-widest">insights</p></div>
            </div>
        </div>
    </div>
</section>

<!-- Quote -->
<section class="relative py-48 overflow-hidden">
    <div class="absolute inset-0"><img class="w-full h-full object-cover opacity-20" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCeExUNUek0QGKivvG7kmnDy2MYscC4ifTQ_s8-3fN9yfPpAreKk2een0RNodhzb3Dzy-kyBHTMH_oSgLnKZrDmsFgur42Yrg0V5k0KRY7Xn9b9NrHBGZ_fE01e9Hg2kYj688Fvf__1YfMuTuVAtEcPnp7kh43nfuaW8jbYVkcFyimGkDqtSEaC429xv_uq9rF2_KgXsA-e834pxNemliU_iUJMervpO5T8VSPc06Mn89DIY885852o6J6-hs4794pt02xoOtz1u1k" alt="Stars"/></div>
    <div class="relative z-10 max-w-5xl mx-auto px-6 text-center">
        <blockquote class="font-headline italic text-4xl md:text-6xl leading-tight mb-12 text-shimmer">"The universe is not only stranger than we imagine, it is stranger than we can imagine."</blockquote>
        <cite class="font-label text-sm tracking-[0.5em] text-on-surface-variant uppercase">— J.B.S. Haldane</cite>
    </div>
</section>

<!-- What we do -->
<section class="py-32 px-6 md:px-24">
    <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-20 items-center">
        <div>
            <h2 class="font-headline text-4xl md:text-5xl mb-8">Real NASA data, reimagined</h2>
            <div class="space-y-10">
                <div class="flex gap-6"><span class="material-symbols-outlined text-primary text-3xl">satellite_alt</span><div><p class="font-label text-xs uppercase tracking-widest text-primary mb-2">Live Telemetry</p><p class="text-on-surface-variant">Access real-time positioning for orbital objects and scientific instruments.</p></div></div>
                <div class="flex gap-6"><span class="material-symbols-outlined text-primary text-3xl">psychology</span><div><p class="font-label text-xs uppercase tracking-widest text-primary mb-2">AI Processing</p><p class="text-on-surface-variant">AI-generated insights for every image, asteroid, and space event.</p></div></div>
                <div class="flex gap-6"><span class="material-symbols-outlined text-primary text-3xl">history_edu</span><div><p class="font-label text-xs uppercase tracking-widest text-primary mb-2">The Archive</p><p class="text-on-surface-variant">Every Astronomy Picture of the Day since 1995, meticulously tagged.</p></div></div>
            </div>
        </div>
        <img class="rounded-lg shadow-2xl" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBxGgI1WXNs1jWIjbZIm1Sy4RP3P9Er4wB0hfH2Ack0vtZcuOUMKsUn9qwKJflHDw4VjJW25k4XCcyVpuXBFd_h6Y5nrr5Yn9YF1nHabL5dgVCWX1TybVFMvIJLk2lWFCjBMt6cNvx_EiKIYdmRsoE0uxvRjs4Ign-cui4Dps8ENHwsN9e5dd1NpPgJbp0P9w3MxpH9nIsGAFTMvJTtmdoJ3JyWJG6M1AU_tZt6MLGX-35nNefeofE4d0Cz5jqZpKBe7YgwIgzSWkw" alt="Mars"/>
    </div>
</section>

<!-- CTA -->
<section class="relative py-48 px-6 text-center overflow-hidden">
    <div class="absolute inset-0"><img class="w-full h-full object-cover opacity-30" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDWaTqVDoDqCSkPrbT0GK-8z1CmrqT95cBlkSuM1W41i3Nix0E7p7Z9GhXvN-MaTOS_0Eh2onivMKqjBX3HLxWntS-5BLwFcWtsaWdMqNfSP4POAE0RsF86Cu25K3gJERNC8Z0BLtAbzFiGrCIXiczDwbMgIzxWp4RLcUCb5qZkWWattiWTOUqwhK4po1jkURa75zgiKGZLVUNPIQ3Wb6zrymx07aMlPqq2Lhy9z_9F8SiHKSai3w61Wd0k4Sk-RbkG4miRobcrh_w" alt="Nebula"/><div class="absolute inset-0 bg-[#05060d]/80"></div></div>
    <div class="relative z-10">
        <h2 class="font-headline text-5xl md:text-8xl mb-12">Ready to explore?</h2>
        <div class="flex flex-col md:flex-row gap-6 justify-center">
            <a href="${pageContext.request.contextPath}/register" class="bg-primary text-on-primary px-10 py-5 rounded-lg font-label tracking-widest uppercase text-sm hover:shadow-[0_0_30px_rgba(109,221,255,0.4)] transition-all">BEGIN JOURNEY</a>
            <a href="${pageContext.request.contextPath}/contact" class="border border-white/10 px-10 py-5 rounded-lg font-label tracking-widest uppercase text-sm hover:bg-white/5 transition-all">CONTACT US</a>
        </div>
    </div>
</section>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
