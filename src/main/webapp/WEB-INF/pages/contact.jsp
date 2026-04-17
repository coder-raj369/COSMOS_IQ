<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="contact" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Contact</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body">
<%@ include file="common/navbar.jspf" %>

<!-- Hero -->
<header class="relative min-h-[50vh] flex flex-col items-center justify-center text-center px-6 pt-24 overflow-hidden">
    <div class="absolute inset-0 z-0">
        <img class="w-full h-full object-cover opacity-40 scale-110" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDjOAz4JygUE_YaV7nXjhlHT2NHSsmM0XLGVTej711sozelqSBc7OI3j7RO8GeOXIV-ir_HCsvata5ksek-xrOxHJ1oVMJ1Hlp-GKRibjRGq7FmdCFVmpBglNKfSjOTg15lvjFir0VZOB5Kf76yH8xOChZvF6LZWIV_RDS8zqEZHgLcGSWkXhs48aS1DViPIcJRAZlwJiSpopejH4QK-XzywhtOeR4X5xTIPX8hg1qOWmNDSetfaXdrJB5sMCU0bJ4HZZWZzV47jQo" alt="Nebula"/>
        <div class="absolute inset-0 bg-gradient-to-b from-transparent via-surface/60 to-surface"></div>
    </div>
    <div class="relative z-10">
        <span class="font-label text-primary tracking-[0.4em] uppercase text-xs">TRANSMISSION CENTER</span>
        <h1 class="font-headline italic font-bold text-5xl md:text-7xl tracking-tight text-shimmer mt-4">Hail mission control.</h1>
    </div>
</header>

<main class="max-w-7xl mx-auto px-6 lg:px-12 py-20">
<div class="grid grid-cols-1 lg:grid-cols-12 gap-16">
    <!-- Left: Info -->
    <div class="lg:col-span-5 space-y-12">
        <h2 class="font-headline text-4xl mb-8">Ways to reach us</h2>
        <div class="space-y-10">
            <div class="flex items-start space-x-6">
                <div class="p-3 bg-primary/10 rounded-xl"><span class="material-symbols-outlined text-primary text-3xl">alternate_email</span></div>
                <div><span class="font-label text-[10px] tracking-widest text-primary uppercase">Email</span><p class="font-label text-xl">mission@cosmosiq.io</p></div>
            </div>
            <div class="flex items-start space-x-6">
                <div class="p-3 bg-primary/10 rounded-xl"><span class="material-symbols-outlined text-primary text-3xl">schedule</span></div>
                <div><span class="font-label text-[10px] tracking-widest text-primary uppercase">Response Time</span><p class="font-label text-xl">Within 24 hours</p></div>
            </div>
            <div class="flex items-start space-x-6">
                <div class="p-3 bg-primary/10 rounded-xl"><span class="material-symbols-outlined text-primary text-3xl">distance</span></div>
                <div><span class="font-label text-[10px] tracking-widest text-primary uppercase">Location</span><p class="font-label text-xl">Earth, Sol System</p></div>
            </div>
        </div>
    </div>

    <!-- Right: Form or Success -->
    <div class="lg:col-span-7">
        <c:choose>
            <c:when test="${sent}">
                <!-- Success State -->
                <div class="glass-panel p-16 rounded-[2rem] flex flex-col items-center text-center">
                    <div class="w-24 h-24 rounded-full border-2 border-primary/30 flex items-center justify-center mb-8 bg-primary/5 shadow-[0_0_40px_rgba(109,221,255,0.2)]">
                        <span class="material-symbols-outlined text-5xl text-primary" style="font-variation-settings:'FILL' 1;">check_circle</span>
                    </div>
                    <h2 class="font-headline text-4xl font-bold mb-4">Transmission received</h2>
                    <p class="text-on-surface-variant max-w-md mb-10">Your message has been sent successfully. We'll get back to you shortly.</p>
                    <a href="${pageContext.request.contextPath}/home" class="bg-primary text-on-primary px-8 py-3 rounded-full font-label text-xs font-bold tracking-widest">RETURN TO DASHBOARD</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Contact Form -->
                <div class="glass-panel p-8 md:p-12 rounded-[2rem]">
                    <h2 class="font-headline text-3xl mb-2">Send a transmission</h2>
                    <div class="h-1 w-12 bg-primary mb-10"></div>
                    <c:if test="${not empty error}"><div class="mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div></c:if>
                    <form method="POST" action="${pageContext.request.contextPath}/contact" class="space-y-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Your Name</label>
                                <input type="text" name="name" required class="w-full bg-surface-container-lowest border border-white/10 px-4 py-3 rounded-xl focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                            </div>
                            <div>
                                <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Email</label>
                                <input type="email" name="email" required class="w-full bg-surface-container-lowest border border-white/10 px-4 py-3 rounded-xl focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                            </div>
                        </div>
                        <div>
                            <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Subject</label>
                            <select name="subject" required class="w-full bg-surface-container-lowest border border-white/10 px-4 py-3 rounded-xl focus:border-primary focus:ring-0 text-on-surface appearance-none">
                                <option value="">Select...</option>
                                <option value="General">General</option>
                                <option value="Technical">Technical</option>
                                <option value="Partnership">Partnership</option>
                                <option value="Bug Report">Bug Report</option>
                            </select>
                        </div>
                        <div>
                            <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Message</label>
                            <textarea name="message" rows="5" required class="w-full bg-surface-container-lowest border border-white/10 px-4 py-3 rounded-xl focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface resize-none"></textarea>
                        </div>
                        <button type="submit" class="flex items-center justify-center gap-3 bg-primary text-on-primary px-10 py-4 font-label font-bold uppercase tracking-widest rounded-xl hover:shadow-[0_0_20px_rgba(109,221,255,0.4)] transition-all">
                            <span>TRANSMIT MESSAGE</span>
                            <span class="material-symbols-outlined">send</span>
                        </button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
