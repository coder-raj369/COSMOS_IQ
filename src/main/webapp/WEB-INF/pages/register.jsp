<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Register</title>
<%@ include file="common/head.jspf" %>
<style>
.floating-label-input input:focus + label, .floating-label-input input:not(:placeholder-shown) + label { transform: translateY(-1.5rem) scale(0.85); color: #6dddff; }
input:-webkit-autofill { -webkit-text-fill-color: #f1effb; -webkit-box-shadow: 0 0 0px 1000px #11131c inset; }
</style>
</head>
<body class="bg-background text-on-surface font-body overflow-hidden">
<div class="grain-overlay"></div>
<main class="flex min-h-screen">
    <section class="hidden lg:block lg:w-1/2 relative overflow-hidden">
        <img class="absolute inset-0 w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCF1mgB8BKV_DtHThxvSrOHefEpPQL9jsm2GKFDRDUhFAEvHNHUQ3nAUeDvUbqfjEHcFnM0-xfbPnQSO-ZId8OV0Z0rdiA-m8rdgdZs2syVfAAiF05YD0EuoS4m-FHac81RD11N7FDk0nEJ4ugk3iI_wyq2ac1xvvWDplMBdCm5cq63Am8YtFCOuZrH18wIn7kG22t-auFoOCdYpeIyXpal_dTaVJOGirZ5fIglQE388QCwoRGFdCGvxsu_YKgL0zIneip2E4TBC1k" alt="Mars landscape"/>
        <div class="absolute inset-0 bg-gradient-to-r from-transparent to-surface-container-lowest/80"></div>
    </section>

    <section class="w-full lg:w-1/2 flex items-center justify-center p-6 bg-[#05060d] relative">
        <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[80%] h-[80%] bg-primary/5 rounded-full blur-[120px]"></div>
        <div class="glass-panel w-full max-w-lg p-10 lg:p-14 rounded-2xl relative z-10">
            <div class="flex flex-col items-center mb-12">
                <h1 class="font-headline text-4xl italic font-bold tracking-tighter text-white mb-8">CosmosIQ</h1>
                <div class="flex space-x-8">
                    <a class="font-label text-sm tracking-[0.2em] text-on-surface-variant hover:text-white transition-colors uppercase" href="${pageContext.request.contextPath}/login">LOGIN</a>
                    <div class="relative">
                        <span class="font-label text-sm tracking-[0.2em] text-primary uppercase">REGISTER</span>
                        <div class="absolute -bottom-2 left-0 w-full h-[2px] bg-primary shadow-[0_0_8px_rgba(109,221,255,0.8)]"></div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty error}"><div class="mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div></c:if>

            <form class="space-y-6" method="POST" action="${pageContext.request.contextPath}/register">
                <div class="relative floating-label-input">
                    <input class="w-full bg-transparent border-b border-outline-variant py-2 outline-none focus:border-primary transition-colors text-on-surface" id="fullName" name="fullName" placeholder=" " type="text" value="${fullName}" required/>
                    <label class="absolute left-0 top-2 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="fullName">Full Name</label>
                </div>
                <div class="relative floating-label-input">
                    <input class="w-full bg-transparent border-b border-outline-variant py-2 outline-none focus:border-primary transition-colors text-on-surface" id="username" name="username" placeholder=" " type="text" value="${username}" required/>
                    <label class="absolute left-0 top-2 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="username">Username</label>
                </div>
                <div class="relative floating-label-input">
                    <input class="w-full bg-transparent border-b border-outline-variant py-2 outline-none focus:border-primary transition-colors text-on-surface" id="email" name="email" placeholder=" " type="email" value="${email}" required/>
                    <label class="absolute left-0 top-2 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="email">Email Address</label>
                </div>
                <div class="relative floating-label-input">
                    <input class="w-full bg-transparent border-b border-outline-variant py-2 outline-none focus:border-primary transition-colors text-on-surface" id="password" name="password" placeholder=" " type="password" required/>
                    <label class="absolute left-0 top-2 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="password">Password</label>
                </div>
                <div class="relative floating-label-input">
                    <input class="w-full bg-transparent border-b border-outline-variant py-2 outline-none focus:border-primary transition-colors text-on-surface" id="confirmPassword" name="confirmPassword" placeholder=" " type="password" required/>
                    <label class="absolute left-0 top-2 font-label text-xs tracking-widest uppercase text-on-surface-variant transition-all pointer-events-none" for="confirmPassword">Confirm Password</label>
                </div>
                <div class="pt-4">
                    <button class="w-full py-4 bg-primary text-on-primary font-label text-sm tracking-[0.3em] uppercase flex items-center justify-center gap-3 hover:shadow-[0_0_20px_rgba(109,221,255,0.4)] transition-all duration-500" type="submit">
                        <span>INITIATE ENROLLMENT</span>
                        <span class="material-symbols-outlined">rocket_launch</span>
                    </button>
                </div>
            </form>
            <div class="mt-10 pt-8 border-t border-white/5 text-center">
                <p class="font-body text-xs text-on-surface-variant">Already a commander? <a class="text-primary hover:text-white transition-colors underline underline-offset-4" href="${pageContext.request.contextPath}/login">Sign in</a></p>
            </div>
        </div>
    </section>
</main>
</body>
</html>
