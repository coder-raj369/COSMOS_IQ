<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | 500</title>
<%@ include file="common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body overflow-hidden">
<div class="grain-overlay"></div>
<div class="min-h-screen flex flex-col items-center justify-center text-center px-6 relative">
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_center,_rgba(255,113,108,0.05)_0%,_transparent_60%)]"></div>
    <div class="relative z-10">
        <span class="material-symbols-outlined text-[120px] text-error/10 mb-4 block">warning</span>
        <h1 class="font-headline font-extralight italic text-[180px] md:text-[200px] leading-none mb-4" style="background:linear-gradient(to right,#ff716c 20%,#d7383b 80%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">500</h1>
        <p class="font-headline italic text-2xl text-on-surface-variant mb-2">Mission control is experiencing turbulence.</p>
        <p class="font-label text-[10px] tracking-[0.3em] text-on-surface-variant/40 uppercase mb-12">ERROR: SYSTEM_MALFUNCTION // OUR ENGINEERS HAVE BEEN NOTIFIED</p>
        <div class="flex gap-6 justify-center">
            <a href="${pageContext.request.contextPath}/home" class="bg-primary text-on-primary px-8 py-4 rounded-full font-label text-xs font-bold uppercase tracking-widest hover:shadow-[0_0_20px_rgba(109,221,255,0.4)] transition-all">RETURN TO BASE</a>
        </div>
    </div>
</div>
</body>
</html>
