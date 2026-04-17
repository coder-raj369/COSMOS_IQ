<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="adminPage" value="events" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Manage Events</title>
<%@ include file="../common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body">
<div class="grain-overlay"></div>
<%@ include file="../common/admin-sidebar.jspf" %>

<main class="ml-64 min-h-screen pt-8">
    <header class="px-10 pb-8 flex justify-between items-center">
        <h2 class="font-headline text-3xl font-black text-shimmer">Celestial Events</h2>
    </header>

    <div class="px-10 pb-16 space-y-10">
        <!-- Create Event Form -->
        <div class="glass-panel p-8 rounded-sm">
            <h3 class="font-headline text-lg mb-6">Schedule New Event</h3>
            <form method="POST" action="${pageContext.request.contextPath}/admin/events" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <input type="hidden" name="action" value="create"/>
                <div>
                    <label class="block font-label text-[10px] text-primary uppercase tracking-widest mb-2">Title</label>
                    <input type="text" name="title" required class="w-full bg-surface-container-lowest border border-white/10 px-4 py-2 text-sm focus:border-primary focus:ring-0 text-on-surface"/>
                </div>
                <div>
                    <label class="block font-label text-[10px] text-primary uppercase tracking-widest mb-2">Date</label>
                    <input type="date" name="eventDate" required class="w-full bg-surface-container-lowest border border-white/10 px-4 py-2 text-sm focus:border-primary focus:ring-0 text-on-surface"/>
                </div>
                <div>
                    <label class="block font-label text-[10px] text-primary uppercase tracking-widest mb-2">Type</label>
                    <select name="type" class="w-full bg-surface-container-lowest border border-white/10 px-4 py-2 text-sm focus:border-primary focus:ring-0 text-on-surface">
                        <option value="Eclipse">Eclipse</option>
                        <option value="Meteor">Meteor Shower</option>
                        <option value="Transit">Transit</option>
                        <option value="Launch">Launch</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="flex items-end gap-4">
                    <label class="flex items-center gap-2 cursor-pointer">
                        <input type="checkbox" name="featured" class="bg-surface-container-lowest border-white/20 rounded text-primary focus:ring-primary"/>
                        <span class="font-label text-[10px] uppercase tracking-widest">Featured</span>
                    </label>
                    <button type="submit" class="bg-primary text-on-primary px-6 py-2 font-label text-[10px] uppercase tracking-widest font-bold">Create</button>
                </div>
                <div class="md:col-span-2 lg:col-span-4">
                    <label class="block font-label text-[10px] text-primary uppercase tracking-widest mb-2">Description</label>
                    <textarea name="description" rows="2" class="w-full bg-surface-container-lowest border border-white/10 px-4 py-2 text-sm focus:border-primary focus:ring-0 text-on-surface resize-none"></textarea>
                </div>
            </form>
        </div>

        <!-- Events Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach items="${events}" var="e">
            <div class="glass-panel p-6 rounded-sm group hover:bg-surface-bright transition-all">
                <div class="flex justify-between items-start mb-4">
                    <div>
                        <span class="font-label text-[9px] tracking-widest uppercase ${e.type == 'Eclipse' ? 'text-primary' : e.type == 'Meteor' ? 'text-secondary' : 'text-tertiary-dim'}">${e.type}</span>
                        <c:if test="${e.featured}"><span class="material-symbols-outlined text-sm text-secondary ml-2" style="font-variation-settings:'FILL' 1;">star</span></c:if>
                    </div>
                    <div class="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <form method="POST" action="${pageContext.request.contextPath}/admin/events" class="inline">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="eventId" value="${e.id}"/>
                            <button type="submit" onclick="return confirm('Delete this event?')" class="text-error hover:text-error-dim">
                                <span class="material-symbols-outlined text-[18px]">delete</span>
                            </button>
                        </form>
                    </div>
                </div>
                <h3 class="font-headline text-xl font-bold mb-2">${e.title}</h3>
                <p class="font-label text-primary text-[11px] tracking-widest font-bold mb-4">${e.eventDate}</p>
                <p class="text-on-surface/70 text-sm leading-relaxed">${e.description}</p>
            </div>
            </c:forEach>
        </div>
    </div>
</main>
</body>
</html>
