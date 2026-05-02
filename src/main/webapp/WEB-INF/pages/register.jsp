<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Register</title>
<%@ include file="common/head.jspf" %>
<style>
.floating-label-input input:focus + label, .floating-label-input input:not(:placeholder-shown) + label { transform: translateY(-1.5rem) scale(0.85); color: #6dddff; }
input:-webkit-autofill { -webkit-text-fill-color: #f1effb; -webkit-box-shadow: 0 0 0px 1000px #0a0b14 inset; }
@keyframes float { 0%,100%{transform:translateY(0) rotate(0deg)} 50%{transform:translateY(-15px) rotate(2deg)} }
@keyframes pulse-glow { 0%,100%{box-shadow:0 0 20px rgba(109,221,255,0.05)} 50%{box-shadow:0 0 50px rgba(109,221,255,0.15)} }
@keyframes drift { 0%{transform:translate(0,0)} 25%{transform:translate(10px,-15px)} 50%{transform:translate(-5px,-25px)} 75%{transform:translate(-15px,-10px)} 100%{transform:translate(0,0)} }
@keyframes twinkle { 0%,100%{opacity:0.1} 50%{opacity:0.8} }
@keyframes slide-up { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
@keyframes orbit { 0%{transform:rotate(0deg) translateX(200px) rotate(0deg)} 100%{transform:rotate(360deg) translateX(200px) rotate(-360deg)} }
.star{position:absolute;width:2px;height:2px;background:#fff;border-radius:50%;animation:twinkle var(--d) ease-in-out infinite;animation-delay:var(--dl)}
</style>
</head>
<body class="bg-[#050510] text-on-surface font-body overflow-hidden">
<div class="grain-overlay"></div>

<main class="relative min-h-screen flex items-center justify-center">

    <!-- Nebula blobs -->
    <div class="absolute w-[600px] h-[600px] bg-primary/8 rounded-full blur-[180px] top-[-10%] left-[-10%]" style="animation:drift 25s ease-in-out infinite"></div>
    <div class="absolute w-[500px] h-[500px] bg-purple-600/8 rounded-full blur-[150px] bottom-[-10%] right-[-5%]" style="animation:drift 20s ease-in-out infinite;animation-delay:-8s"></div>
    <div class="absolute w-[300px] h-[300px] bg-secondary/5 rounded-full blur-[120px] top-[40%] right-[30%]" style="animation:drift 18s ease-in-out infinite;animation-delay:-14s"></div>

    <!-- Stars scattered across full screen -->
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
    <div class="star" style="top:55%;left:5%;--d:3.5s;--dl:2.1s;width:3px;height:3px"></div>

    <!-- Floating Earth behind the form -->
    <div class="absolute left-[8%] top-1/2 -translate-y-1/2 pointer-events-none hidden lg:block" style="animation:float 8s ease-in-out infinite">
        <img src="${pageContext.request.contextPath}/images/earth_PNG39.png" alt="Earth" class="w-[420px] h-[420px] object-contain opacity-60 drop-shadow-[0_0_80px_rgba(109,221,255,0.2)]"/>
        <!-- Orbiting dot -->
        <div class="absolute top-1/2 left-1/2 w-0 h-0" style="animation:orbit 15s linear infinite">
            <div class="w-2 h-2 bg-primary rounded-full shadow-[0_0_10px_#6dddff]"></div>
        </div>
    </div>

    <!-- Corner decorations -->
    <div class="absolute top-6 left-8 font-label text-[9px] tracking-[0.3em] text-primary/30 uppercase hidden lg:block">Sector 7G // Registration Bay</div>
    <div class="absolute top-6 right-8 flex items-center gap-2 hidden lg:block">
        <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse inline-block"></span>
        <span class="font-label text-[9px] tracking-widest text-primary/40 uppercase">Encrypted Channel</span>
    </div>
    <div class="absolute bottom-6 left-8 font-label text-[9px] tracking-[0.2em] text-on-surface-variant/20 uppercase hidden lg:block">CosmosIQ v1.0 // Orbital Command</div>

    <!-- Registration form card -->
    <div class="glass-panel w-full max-w-lg p-10 lg:p-14 rounded-2xl relative z-10" style="animation:pulse-glow 4s ease-in-out infinite">

        <div class="flex flex-col items-center mb-10" style="animation:slide-up 0.6s ease-out forwards">
            <h1 class="font-headline text-4xl italic font-bold tracking-tighter text-white mb-2">CosmosIQ</h1>
            <div class="flex items-center gap-4 mb-8">
                <span class="h-[1px] w-8 bg-primary/30"></span>
                <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary">Mission Enrollment</p>
                <span class="h-[1px] w-8 bg-primary/30"></span>
            </div>
            <div class="flex space-x-8">
                <a class="font-label text-sm tracking-[0.2em] text-on-surface-variant hover:text-white transition-colors uppercase" href="${pageContext.request.contextPath}/login">LOGIN</a>
                <div class="relative">
                    <span class="font-label text-sm tracking-[0.2em] text-primary uppercase">REGISTER</span>
                    <div class="absolute -bottom-2 left-0 w-full h-[2px] bg-primary shadow-[0_0_8px_rgba(109,221,255,0.8)]"></div>
                </div>
            </div>
        </div>

        <c:if test="${not empty error}"><div class="mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div></c:if>

        <form class="space-y-5" method="POST" action="${pageContext.request.contextPath}/register">
            <div class="relative floating-label-input" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.1s;opacity:0">
                <input class="w-full bg-transparent border-b border-outline-variant py-3 outline-none focus:border-primary transition-all text-on-surface" id="fullName" name="fullName" placeholder=" " type="text" value="${fullName}" required/>
                <label class="absolute left-0 top-3 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="fullName">Full Name</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">person</span></div>
            </div>
            <div class="relative floating-label-input" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.2s;opacity:0">
                <input class="w-full bg-transparent border-b border-outline-variant py-3 outline-none focus:border-primary transition-all text-on-surface" id="username" name="username" placeholder=" " type="text" value="${username}" required/>
                <label class="absolute left-0 top-3 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="username">Username</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">badge</span></div>
            </div>
            <div class="relative floating-label-input" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.3s;opacity:0">
                <input class="w-full bg-transparent border-b border-outline-variant py-3 outline-none focus:border-primary transition-all text-on-surface" id="email" name="email" placeholder=" " type="email" value="${email}" required/>
                <label class="absolute left-0 top-3 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="email">Email Address</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">alternate_email</span></div>
            </div>
            <div class="relative floating-label-input" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.4s;opacity:0">
                <input class="w-full bg-transparent border-b border-outline-variant py-3 outline-none focus:border-primary transition-all text-on-surface" id="password" name="password" placeholder=" " type="password" required/>
                <label class="absolute left-0 top-3 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="password">Password</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">lock</span></div>
            </div>
            <div class="relative floating-label-input" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.5s;opacity:0">
                <input class="w-full bg-transparent border-b border-outline-variant py-3 outline-none focus:border-primary transition-all text-on-surface" id="confirmPassword" name="confirmPassword" placeholder=" " type="password" required/>
                <label class="absolute left-0 top-3 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="confirmPassword">Confirm Password</label>
                <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">lock_open</span></div>
            </div>
            <div class="pt-3" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.6s;opacity:0">
                <button class="group w-full py-4 bg-primary text-on-primary font-label text-sm tracking-[0.3em] uppercase flex items-center justify-center gap-3 hover:shadow-[0_0_30px_rgba(109,221,255,0.5)] hover:scale-[1.02] active:scale-[0.98] transition-all duration-500 relative overflow-hidden" type="submit">
                    <div class="absolute inset-0 opacity-0 group-hover:opacity-20 bg-[radial-gradient(circle,rgba(255,255,255,1)_0%,transparent_70%)] transition-opacity"></div>
                    <span class="material-symbols-outlined">rocket_launch</span>
                    <span>INITIATE ENROLLMENT</span>
                </button>
            </div>
        </form>
        <div class="mt-8 pt-6 border-t border-white/5 text-center" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.7s;opacity:0">
            <p class="font-body text-xs text-on-surface-variant">Already a commander? <a class="text-primary hover:text-white transition-colors underline underline-offset-4" href="${pageContext.request.contextPath}/login">Sign in</a></p>
        </div>
    </div>
</main>
</body>
</html>