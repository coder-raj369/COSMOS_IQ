<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Reset Password</title>
<%@ include file="common/head.jspf" %>
<style>
input:focus + label, input:not(:placeholder-shown) + label { transform: translateY(-1.5rem) scale(0.85); color: #6dddff; }
@keyframes float { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-15px)} }
@keyframes twinkle { 0%,100%{opacity:0.1} 50%{opacity:0.8} }
@keyframes slide-up { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
@keyframes pulse-glow { 0%,100%{box-shadow:0 0 20px rgba(109,221,255,0.05)} 50%{box-shadow:0 0 50px rgba(109,221,255,0.15)} }
.star{position:absolute;width:2px;height:2px;background:#fff;border-radius:50%;animation:twinkle var(--d) ease-in-out infinite;animation-delay:var(--dl)}
</style>
</head>
<body class="bg-[#050510] text-on-surface font-body overflow-hidden">
<div class="grain-overlay"></div>

<main class="relative min-h-screen flex items-center justify-center">

    <!-- Nebula blobs -->
    <div class="absolute w-[600px] h-[600px] bg-primary/8 rounded-full blur-[180px] top-[-10%] right-[-10%]"></div>
    <div class="absolute w-[500px] h-[500px] bg-purple-600/8 rounded-full blur-[150px] bottom-[-10%] left-[-5%]"></div>

    <!-- Stars -->
    <div class="star" style="top:5%;left:10%;--d:3s;--dl:0s;width:3px;height:3px"></div>
    <div class="star" style="top:20%;left:70%;--d:4s;--dl:1s"></div>
    <div class="star" style="top:50%;left:20%;--d:2.5s;--dl:0.5s"></div>
    <div class="star" style="top:75%;left:80%;--d:3.5s;--dl:2s"></div>
    <div class="star" style="top:88%;left:45%;--d:3s;--dl:0.8s"></div>

    <!-- Floating Earth -->
    <div class="absolute right-[5%] top-1/2 -translate-y-1/2 pointer-events-none hidden lg:block" style="animation:float 8s ease-in-out infinite">
        <img src="${pageContext.request.contextPath}/images/earth_PNG39.png" alt="Earth" class="w-[340px] h-[340px] object-contain opacity-30 drop-shadow-[0_0_80px_rgba(109,221,255,0.2)]"/>
    </div>

    <!-- Card -->
    <div class="glass-panel w-full max-w-[480px] p-10 md:p-14 rounded-2xl relative z-10" style="animation:pulse-glow 4s ease-in-out infinite">

        <div class="flex flex-col items-center mb-10" style="animation:slide-up 0.6s ease-out forwards">
            <h1 class="font-headline text-5xl italic font-bold tracking-tighter text-white mb-2">CosmosIQ</h1>
            <div class="flex items-center gap-4 mb-2">
                <span class="h-[1px] w-8 bg-primary/30"></span>
                <p class="font-label text-[10px] uppercase tracking-[0.4em] text-primary">
                    <c:choose>
                        <c:when test="${step == 'reset'}">Set New Password</c:when>
                        <c:otherwise>Password Recovery</c:otherwise>
                    </c:choose>
                </p>
                <span class="h-[1px] w-8 bg-primary/30"></span>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div>
        </c:if>

        <!-- Step 1: Request reset -->
        <c:if test="${step == 'request'}">
            <c:if test="${not empty resetLink}">
                <div class="mb-6 p-4 bg-primary/10 border border-primary/30 rounded-lg space-y-2">
                    <p class="text-primary text-xs font-label uppercase tracking-widest">Reset Link Generated</p>
                    <a href="${resetLink}" class="text-white text-xs break-all underline underline-offset-2 hover:text-primary transition-colors">${resetLink}</a>
                    <p class="text-on-surface-variant text-[10px]">This link expires in 30 minutes.</p>
                </div>
            </c:if>
            <form class="space-y-8" method="POST" action="${pageContext.request.contextPath}/forgot-password">
                <input type="hidden" name="step" value="request"/>
                <div class="relative" style="animation:slide-up 0.7s ease-out forwards">
                    <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer"
                           id="email" name="email" placeholder=" " required type="email"/>
                    <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="email">Your Email Address</label>
                    <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">alternate_email</span></div>
                </div>
                <div class="pt-4">
                    <button class="group relative w-full bg-primary py-5 flex items-center justify-center gap-3 transition-all duration-500 hover:shadow-[0_0_30px_rgba(109,221,255,0.5)] hover:scale-[1.02] active:scale-[0.98]" type="submit">
                        <span class="material-symbols-outlined text-on-primary text-xl">key</span>
                        <span class="font-label text-xs font-bold uppercase tracking-[0.3em] text-on-primary">Generate Reset Link</span>
                    </button>
                </div>
            </form>
        </c:if>

        <!-- Step 2: Set new password -->
        <c:if test="${step == 'reset'}">
            <form class="space-y-8" method="POST" action="${pageContext.request.contextPath}/forgot-password">
                <input type="hidden" name="step" value="reset"/>
                <input type="hidden" name="token" value="${token}"/>
                <div class="relative" style="animation:slide-up 0.7s ease-out forwards">
                    <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer"
                           id="password" name="password" placeholder=" " required type="password" minlength="6"/>
                    <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="password">New Password</label>
                    <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">lock</span></div>
                </div>
                <div class="relative" style="animation:slide-up 0.7s ease-out forwards;animation-delay:0.1s">
                    <input class="block w-full px-0 py-3 bg-transparent border-0 border-b border-white/10 text-on-surface focus:ring-0 focus:border-primary transition-all peer"
                           id="confirmPassword" name="confirmPassword" placeholder=" " required type="password" minlength="6"/>
                    <label class="absolute left-0 top-3 text-on-surface/50 font-label text-xs uppercase tracking-widest pointer-events-none transition-all duration-300" for="confirmPassword">Confirm Password</label>
                    <div class="absolute right-0 top-3"><span class="material-symbols-outlined text-sm text-on-surface/20">lock_reset</span></div>
                </div>
                <div class="pt-4">
                    <button class="group relative w-full bg-primary py-5 flex items-center justify-center gap-3 transition-all duration-500 hover:shadow-[0_0_30px_rgba(109,221,255,0.5)] hover:scale-[1.02] active:scale-[0.98]" type="submit">
                        <span class="material-symbols-outlined text-on-primary text-xl">lock_reset</span>
                        <span class="font-label text-xs font-bold uppercase tracking-[0.3em] text-on-primary">Reset Password</span>
                    </button>
                </div>
            </form>
        </c:if>

        <div class="mt-10 pt-8 border-t border-white/5 text-center">
            <p class="text-xs text-on-surface-variant">Remember it? <a class="text-primary hover:text-white transition-colors underline underline-offset-4" href="${pageContext.request.contextPath}/login">Back to Login</a></p>
        </div>
    </div>
</main>
</body>
</html>