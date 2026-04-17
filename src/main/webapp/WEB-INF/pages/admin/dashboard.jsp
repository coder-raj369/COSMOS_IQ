<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="adminPage" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Admin Dashboard</title>
<%@ include file="../common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body">
<div class="grain-overlay"></div>
<%@ include file="../common/admin-sidebar.jspf" %>

<main class="ml-64 min-h-screen">
    <header class="h-20 flex justify-between items-center px-10 pt-8">
        <h2 class="font-headline text-2xl font-black text-shimmer">Mission Control</h2>
        <div class="flex items-center gap-3">
            <span class="material-symbols-outlined text-on-surface/60">account_circle</span>
            <span class="font-label text-[10px] uppercase tracking-widest">${sessionScope.user.fullName}</span>
        </div>
    </header>

    <div class="px-10 pb-16 space-y-10 pt-8">
        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div class="glass-panel p-6 rounded-sm">
                <p class="font-label text-[10px] text-on-surface/50 tracking-[0.2em] uppercase mb-1">Total Users</p>
                <h3 class="font-headline text-4xl font-bold text-shimmer">${totalUsers}</h3>
            </div>
            <div class="glass-panel p-6 rounded-sm">
                <p class="font-label text-[10px] text-on-surface/50 tracking-[0.2em] uppercase mb-1">Favorites Saved</p>
                <h3 class="font-headline text-4xl font-bold text-shimmer">${totalFavorites}</h3>
            </div>
            <div class="glass-panel p-6 rounded-sm">
                <p class="font-label text-[10px] text-on-surface/50 tracking-[0.2em] uppercase mb-1">AI Facts Generated</p>
                <h3 class="font-headline text-4xl font-bold text-shimmer">${totalAiFacts}</h3>
            </div>
            <div class="glass-panel p-6 rounded-sm">
                <p class="font-label text-[10px] text-on-surface/50 tracking-[0.2em] uppercase mb-1">Unread Messages</p>
                <h3 class="font-headline text-4xl font-bold text-shimmer">${unreadMessages}</h3>
            </div>
        </div>

        <!-- Users Table -->
        <div class="glass-panel overflow-hidden rounded-sm">
            <div class="p-8 border-b border-white/10 flex justify-between items-center">
                <div>
                    <h4 class="font-headline text-xl font-bold">User Directory</h4>
                    <p class="font-label text-[10px] text-on-surface/40 uppercase tracking-widest">All registered users</p>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-white/[0.02]">
                        <tr>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">User</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Role</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Status</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Joined</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach items="${allUsers}" var="u">
                        <tr class="hover:bg-white/5 transition-colors">
                            <td class="px-8 py-5">
                                <p class="font-body text-xs font-semibold">${u.fullName}</p>
                                <p class="font-label text-[9px] text-on-surface/40">${u.email}</p>
                            </td>
                            <td class="px-8 py-5">
                                <span class="inline-flex px-2 py-1 ${u.admin ? 'bg-secondary/10 border-secondary/20 text-secondary' : 'bg-primary/10 border-primary/20 text-primary'} border text-[8px] font-label uppercase tracking-widest rounded-sm">${u.role}</span>
                            </td>
                            <td class="px-8 py-5">
                                <div class="flex items-center gap-2">
                                    <div class="w-2 h-2 rounded-full ${u.locked ? 'bg-error' : 'bg-primary shadow-[0_0_8px_#6dddff]'}"></div>
                                    <span class="font-label text-[10px] uppercase">${u.locked ? 'Locked' : 'Active'}</span>
                                </div>
                            </td>
                            <td class="px-8 py-5 font-label text-[10px] text-on-surface/60">${u.createdAt}</td>
                            <td class="px-8 py-5 text-right">
                                <form method="POST" action="${pageContext.request.contextPath}/admin/users" class="inline-flex gap-2">
                                    <input type="hidden" name="userId" value="${u.id}"/>
                                    <c:if test="${u.locked}">
                                        <button name="action" value="unlock" class="text-primary text-[10px] font-label uppercase hover:underline">Unlock</button>
                                    </c:if>
                                    <c:if test="${!u.locked}">
                                        <button name="action" value="lock" class="text-secondary text-[10px] font-label uppercase hover:underline">Lock</button>
                                    </c:if>
                                    <c:if test="${!u.admin}">
                                        <button name="action" value="makeAdmin" class="text-primary text-[10px] font-label uppercase hover:underline ml-2">Promote</button>
                                    </c:if>
                                    <button name="action" value="delete" class="text-error text-[10px] font-label uppercase hover:underline ml-2" onclick="return confirm('Delete this user?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
</body>
</html>
