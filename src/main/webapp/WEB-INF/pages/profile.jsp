<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="profile" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Profile</title>
<%@ include file="common/head.jspf" %>
<style>body{background:radial-gradient(circle at 50% -20%,#171a2b 0%,#0c0e16 100%)}</style>
</head>
<body class="font-body text-on-surface">
<%@ include file="common/navbar.jspf" %>

<main class="relative z-10 pt-32 pb-24 max-w-[720px] mx-auto px-6">
    <!-- Profile Hero -->
    <section class="flex flex-col items-center mb-16">
        <div class="w-[120px] h-[120px] rounded-full border-[3px] border-cyan-400 shadow-[0_0_20px_rgba(109,221,255,0.3)] bg-surface-container flex items-center justify-center">
            <span class="material-symbols-outlined text-5xl text-primary">person</span>
        </div>
        <h1 class="mt-8 font-headline italic font-light text-5xl tracking-tight text-shimmer">${sessionScope.user.fullName}</h1>
        <p class="mt-4 font-label text-[10px] tracking-[0.3em] text-on-surface-variant uppercase">${sessionScope.user.email} &bull; Member since ${sessionScope.user.createdAt}</p>
    </section>

    <c:if test="${not empty error}"><div class="mb-6 p-4 bg-error-container/20 border border-error/30 rounded-lg text-error text-sm">${error}</div></c:if>
    <c:if test="${not empty success}"><div class="mb-6 p-4 bg-primary/10 border border-primary/30 rounded-lg text-primary text-sm">${success}</div></c:if>

    <!-- Profile Form -->
    <div class="space-y-8">
        <div class="glass-panel p-10 rounded-xl">
            <h3 class="font-headline text-xl mb-8">Personal Information</h3>
            <form method="POST" action="${pageContext.request.contextPath}/profile" class="space-y-6">
                <input type="hidden" name="action" value="updateProfile"/>
                <div>
                    <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Full Name</label>
                    <input type="text" name="fullName" value="${sessionScope.user.fullName}" class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                </div>
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Username</label>
                        <input type="text" name="username" value="${sessionScope.user.username}" class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                    </div>
                    <div>
                        <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Email</label>
                        <input type="email" name="email" value="${sessionScope.user.email}" class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                    </div>
                </div>
                <div>
                    <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Bio</label>
                    <textarea name="bio" rows="3" class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface resize-none">${sessionScope.user.bio}</textarea>
                </div>
                <div class="flex justify-end">
                    <button type="submit" class="bg-primary text-on-primary font-label text-[12px] tracking-widest px-8 py-3 rounded-lg hover:shadow-[0_0_15px_rgba(109,221,255,0.4)] font-bold">SAVE CHANGES</button>
                </div>
            </form>
        </div>

        <!-- Change Password -->
        <div class="glass-panel p-10 rounded-xl">
            <h3 class="font-headline text-xl mb-8">Security</h3>
            <form method="POST" action="${pageContext.request.contextPath}/profile" class="space-y-6">
                <input type="hidden" name="action" value="changePassword"/>
                <div>
                    <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Current Password</label>
                    <input type="password" name="currentPassword" required class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                </div>
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">New Password</label>
                        <input type="password" name="newPassword" required class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                    </div>
                    <div>
                        <label class="block font-label text-[10px] tracking-widest text-primary mb-2 uppercase">Confirm</label>
                        <input type="password" name="confirmPassword" required class="w-full bg-surface-container-lowest border border-white/10 rounded-lg px-4 py-3 focus:border-primary focus:ring-1 focus:ring-primary/30 outline-none text-on-surface"/>
                    </div>
                </div>
                <div class="flex justify-end">
                    <button type="submit" class="bg-surface-bright text-on-surface font-label text-[12px] tracking-widest px-8 py-3 rounded-lg border border-white/10 hover:border-primary/30 font-bold">CHANGE PASSWORD</button>
                </div>
            </form>
        </div>
    </div>
</main>

<%@ include file="common/footer.jspf" %>
</body>
</html>
