<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Sign In</title>
<%@ include file="common/head.jspf" %>
<style>
input:focus + label, input:not(:placeholder-shown) + label { transform: translateY(-1.5rem) scale(0.85); color: #6dddff; }
</style>
</head>
<body class="bg-surface text-on-surface font-body overflow-hidden">
<div class="fixed inset-0 z-0 bg-cover bg-center bg-no-repeat"
     style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuC0BEFDZhmXqJCErMcdRRfQAM4a4nCDBbC8DsM0phHrJzkgx_4rLmnAIO1zOeWqsigh9zYW9sFQ-puq_zaQfLSyfe2gVDQ_cyO9DAmX8DnQdPns3nzqNN_u3uKPmDxLDmLBmD_mMcJt8iWARt1ZOE7H_5QyjBVzvNRK-6pAhPMlx7m7de5pXc-7X2D5P23dJDixK2VsfXDzgKOJYNiN8oO2hwoRyfRocWVhyZre5z6l9_poZmWtc8rZufY6d45HptuOB9RcLYOSblQ')">
    <div class="absolute inset-0 bg-black/40"></div>
    <div class="absolute inset-0 grain-overlay"></div>
</div>
<main class="relative z-10 min-h-screen flex items-center justify-center p-6">
    <div class="w-full max-w-[480px] glass-panel rounded-xl overflow-hidden shadow-[0_40px_100px_rgba(0,0,0,0.8)] flex flex-col items-center p-10 md:p-16">
        <div class="mb-12 text-center">
            <h1 class="font-headline text-5xl md:text-6xl italic font-bold text-white tracking-tighter mb-2">CosmosIQ</h1>
            <div class="flex items-center justify-center gap-4">
                <span class="h-[1px] w-8 bg-primary/30"></span>
                <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary">Orbital Authentication</p>
                <span class="h-[1px] w-8 bg-primary/30"></span>
            </div>
        </div>
        <div class="flex gap-8 mb-10">
            <a class="font-label text-sm uppercase tracking-widest text-primary border-b-2 border-primary pb-2" href="${pageContext.request.contextPath}/login">Login</a>
            <a class="font-label text-sm uppercase tracking-widest text-on-surface/40 hover:text-on-surface transition-colors pb-2" href="${pageContext.request.contextPath}/register">Register</a>
        </div>

        <c:if test="${not empty error}"><div class="w-full mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div></c:if>
        <c:if test="${not empty success}"><div class="w-full mb-6 p-4 bg-primary/10 border border-primary/30 rounded-lg text-primary text-sm">${success}</div></c:if>

        <form class="w-full space-y-8" method="POST" action="${pageContext.request.contextPath}/login">
            <div class="relative">
                <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer" id="email" name="email" placeholder=" " required type="email" value="${email}"/>
                <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="email">Mission ID / Email</label>
            </div>
            <div class="relative">
                <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer" id="password" name="password" placeholder=" " required type="password"/>
                <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="password">Access Key</label>
            </div>
            <div class="pt-6">
                <button class="group relative w-full bg-primary py-5 rounded-sm flex items-center justify-center gap-3 transition-all duration-500 hover:shadow-[0_0_25px_rgba(109,221,255,0.4)]" type="submit">
                    <span class="material-symbols-outlined text-on-primary text-xl">rocket_launch</span>
                    <span class="font-label text-xs font-bold uppercase tracking-[0.3em] text-on-primary">Initiate Authorization</span>
                </button>
            </div>
        </form>
        <div class="mt-12 pt-8 border-t border-white/5 text-center w-full">
            <p class="text-xs text-on-surface-variant">Don't have an account? <a class="text-primary hover:text-white transition-colors underline underline-offset-4" href="${pageContext.request.contextPath}/register">Create one</a></p>
        </div>
    </div>
</main>
</body>
</html>
