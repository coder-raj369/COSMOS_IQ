<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="adminPage" value="users" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Manage Users</title>
<%@ include file="../common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body">
<div class="grain-overlay"></div>
<%@ include file="../common/admin-sidebar.jspf" %>

<main class="ml-64 min-h-screen pt-8">
    <header class="px-10 pb-8">
        <h2 class="font-headline text-3xl font-black text-shimmer">User Management</h2>
    </header>
    <div class="px-10 pb-16">
        <div class="glass-panel overflow-hidden rounded-sm">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-white/[0.02]">
                        <tr>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">User</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Email</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Role</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Status</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40">Joined</th>
                            <th class="px-8 py-4 font-label text-[10px] uppercase tracking-widest text-on-surface/40 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach items="${users}" var="u">
                        <tr class="hover:bg-white/5 transition-colors">
                            <td class="px-8 py-5 font-body text-sm">${u.fullName}</td>
                            <td class="px-8 py-5 font-label text-xs text-on-surface/60">${u.email}</td>
                            <td class="px-8 py-5"><span class="px-2 py-1 ${u.admin?'bg-secondary/10 text-secondary':'bg-primary/10 text-primary'} border ${u.admin?'border-secondary/20':'border-primary/20'} text-[8px] font-label uppercase tracking-widest rounded-sm">${u.role}</span></td>
                            <td class="px-8 py-5"><span class="flex items-center gap-2"><span class="w-2 h-2 rounded-full ${u.locked?'bg-error':'bg-primary'}"></span><span class="font-label text-[10px] uppercase">${u.locked?'Locked':'Active'}</span></span></td>
                            <td class="px-8 py-5 font-label text-[10px] text-on-surface/60">${u.createdAt}</td>
                            <td class="px-8 py-5 text-right">
							    <form method="POST" action="${pageContext.request.contextPath}/admin/users" class="inline-flex gap-3">
							        <input type="hidden" name="userId" value="${u.id}"/>
							        <c:choose>
							            <c:when test="${u.id == pageContext.session.getAttribute('user').id}">
							                <span class="text-on-surface/20 text-[10px] font-label uppercase">You</span>
							            </c:when>
							            <c:otherwise>
							                <c:if test="${u.locked}"><button name="action" value="unlock" class="text-primary text-[10px] font-label uppercase hover:underline">Unlock</button></c:if>
							                <c:if test="${!u.locked and !u.admin}"><button name="action" value="lock" class="text-secondary text-[10px] font-label uppercase hover:underline">Lock</button></c:if>
							                <c:if test="${u.admin}"><button name="action" value="makeMember" class="text-on-surface-variant text-[10px] font-label uppercase hover:underline">Demote</button></c:if>
							                <c:if test="${!u.admin}"><button name="action" value="delete" class="text-error text-[10px] font-label uppercase hover:underline" onclick="return confirm('Delete this user permanently?')">Delete</button></c:if>
							            </c:otherwise>
							        </c:choose>
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
