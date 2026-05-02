<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Sign In</title>
<%@ include file="common/head.jspf" %>
<style>
input:focus + label, input:not(:placeholder-shown) + label { transform: translateY(-1.5rem) scale(0.85); color: #6dddff; }
input:-webkit-autofill { -webkit-text-fill-color: #f1effb; -webkit-box-shadow: 0 0 0px 1000px #0a0b14 inset; }
@keyframes float { 0%,100%{transform:translateY(0) rotate(0deg)} 50%{transform:translateY(-15px) rotate(-2deg)} }
@keyframes pulse-glow { 0%,100%{box-shadow:0 0 20px rgba(109,221,255,0.05)} 50%{box-shadow:0 0 50px rgba(109,221,255,0.15)} }
@keyframes drift { 0%{transform:translate(0,0)} 25%{transform:translate(10px,-15px)} 50%{transform:translate(-5px,-25px)} 75%{transform:translate(-15px,-10px)} 100%{transform:translate(0,0)} }
@keyframes twinkle { 0%,100%{opacity:0.1} 50%{opacity:0.8} }
@keyframes slide-up { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
@keyframes orbit { 0%{transform:rotate(0deg) translateX(180px) rotate(0deg)} 100%{transform:rotate(360deg) translateX(180px) rotate(-360deg)} }
.star{position:absolute;width:2px;height:2px;background:#fff;border-radius:50%;animation:twinkle var(--d) ease-in-out infinite;animation-delay:var(--dl)}
</style>
</head>
<body class="bg-[#050510] text-on-surface font-body overflow-hidden">
<div class="grain-overlay"></div>

<main class="relative min-h-screen flex items-center justify-center">

    <!-- Nebula blobs -->
    <div class="absolute w-[600px] h-[600px] bg-primary/8 rounded-full blur-[180px] top-[-10%] right-[-10%]" style="animation:drift 25s ease-in-out infinite"></div>
    <div class="absolute w-[500px] h-[500px] bg-purple-600/8 rounded-full blur-[150px] bottom-[-10%] left-[-5%]" style="animation:drift 20s ease-in-out infinite;animation-delay:-8s"></div>
    <div class="absolute w-[300px] h-[300px] bg-secondary/5 rounded-full blur-[120px] top-[40%] left-[30%]" style="animation:drift 18s ease-in-out infinite;animation-delay:-14s"></div>

    <!-- Stars -->
    <div class="star" style="top:5%;left:10%;--d:3s;--dl:0s;width:3px;height:3px"></div>
    <div class="star" style="top:12%;left:65%;--d:4s;--dl:1s"></div>
    <div class="star" style="top:20%;left:25%;--d:2.5s;--dl:0.5s;width:3px;height:3px"></div>
    <div class="star" style="top:30%;left:80%;--d:3.5s;--dl:2s"></div>
    <div class="star" style="top:40%;left:15%;--d:4s;--dl:1.5s"></div>
    <div class="star" style="top:50%;left:55%;--d:3s;--dl:0.8s;width:3px;height:3px"></div>
    <div class="star" style="top:60%;left:35%;--d:2s;--dl:2.5s"></div>
    <div class="star" style="top:70%;left:72%;--d:3.5s;--dl:0.3s"></div>
    <div class="star" style="top:80%;left:20%;--d:4s;--dl:1.8s;width:3px;height:3px"></div>
    <div class="star" style="top:88%;left:50%;--d:2.5s;--dl:0.7s"></div>
    <div class="star" style="top:15%;left:45%;--d:3s;--dl:2.2s"></div>
    <div class="star" style="top:45%;left:90%;--d:4s;--dl:0.4s;width:3px;height:3px"></div>
    <div class="star" style="top:65%;left:8%;--d:3.5s;--dl:1.2s"></div>
    <div class="star" style="top:35%;left:92%;--d:2s;--dl:2.8s;width:3px;height:3px"></div>
    <div class="star" style="top:75%;left:3%;--d:4s;--dl:0.6s"></div>
    <div class="star" style="top:8%;left:88%;--d:3s;--dl:1.6s"></div>
    <div class="star" style="top:92%;left:78%;--d:2.5s;--dl:0.2s"></div>

    <!-- Floating Earth on right side -->
    <div class="absolute right-[5%] top-1/2 -translate-y-1/2 pointer-events-none hidden lg:block" style="animation:float 8s ease-in-out infinite">
        <img src="${pageContext.request.contextPath}/images/earth_PNG39.png" alt="Earth" class="w-[380px] h-[380px] object-contain opacity-40 drop-shadow-[0_0_80px_rgba(109,221,255,0.2)]"/>
        <div class="absolute top-1/2 left-1/2 w-0 h-0" style="animation:orbit 18s linear infinite">
            <div class="w-2 h-2 bg-primary rounded-full shadow-[0_0_10px_#6dddff]"></div>
        </div>
    </div>

    <!-- Corner decorations -->
    <div class="absolute top-6 left-8 font-label text-[9px] tracking-[0.3em] text-primary/30 uppercase hidden lg:block">Sector 7G // Authentication Bay</div>
    <div class="absolute top-6 right-8 flex items-center gap-2 hidden lg:block">
        <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse inline-block"></span>
        <span class="font-label text-[9px] tracking-widest text-primary/40 uppercase">Secure Channel</span>
    </div>
    <div class="absolute bottom-6 left-8 font-label text-[9px] tracking-[0.2em] text-on-surface-variant/20 uppercase hidden lg:block">CosmosIQ v1.0 // Orbital Command</div>

    <!-- Login card -->
    <div class="glass-panel w-full max-w-[480px] p-10 md:p-14 rounded-2xl relative z-10" style="animation:pulse-glow 4s ease-in-out infinite">

        <div class="flex flex-col items-center mb-10" style="animation:slide-up 0.6s ease-out forwards">
            <h1 class="font-headline text-5xl italic font-bold tracking-tighter text-white mb-2">CosmosIQ</h1>
            <div class="flex items-center gap-4 mb-8">
                <span class="h-[1px] w-8 bg-primary/30"></span>
                <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary">Orbital Authentication</p>
                <span class="h-[1px] w-8 bg-primary/30"></span>
            </div>
            <div class="flex gap-8">
                <div class="relative">
                    <span class="font-label text-sm uppercase tracking-widest text-primary">Login</span>
                    <div class="absolute -bottom-2 left-0 w-full h-[2px] bg-primary shadow-[0_0_8px_rgba(109,221,255,0.8)]"></div>
                </div>
                <a class="font-label text-sm uppercase tracking-widest text-on-surface/40 hover:text-on-surface transition-colors" href="${pageContext.request.contextPath}/register">Register</a>
            </div>
        </div>

        <c:if test="${not empty error}"><div class="mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div></c:if>
        <c:if test="${not empty success}"><div class="mb-6 p-4 bg-primary/10 border border-primary/30 rounded-lg text-primary text-sm">${success}</div></c:if>

        <form class="space-y-8" method="POST" action="${pageContext.request.contextPath}/login">
            <div class="relative" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.1s;opacity:0">
                <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer" id="email" name="email" placeholder=" " required type="email" value="${email}"/>
                <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="email">Mission ID / Email</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">alternate_email</span></div>
            </div>
            <div class="relative" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.2s;opacity:0">
                <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer" id="password" name="password" placeholder=" " required type="password"/>
                <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="password">Access Key</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">lock</span></div>
            </div>
            <div class="pt-4" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.3s;opacity:0">
                <button class="group relative w-full bg-primary py-5 flex items-center justify-center gap-3 transition-all duration-500 hover:shadow-[0_0_30px_rgba(109,221,255,0.5)] hover:scale-[1.02] active:scale-[0.98] overflow-hidden" type="submit">
                    <div class="absolute inset-0 opacity-0 group-hover:opacity-20 bg-[radial-gradient(circle,rgba(255,255,255,1)_0%,transparent_70%)] transition-opacity"></div>
                    <span class="material-symbols-outlined text-on-primary text-xl">rocket_launch</span>
                    <span class="font-label text-xs font-bold uppercase tracking-[0.3em] text-on-primary">Initiate Authorization</span>
                </button>
            </div>
        </form>

        <div class="mt-10 pt-8 border-t border-white/5 text-center" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.4s;opacity:0">
            <p class="text-xs text-on-surface-variant">Don't have an account? <a class="text-primary hover:text-white transition-colors underline underline-offset-4" href="${pageContext.request.contextPath}/register">Create one</a></p>
        </div>
    </div>
</main>
</body>
</html>