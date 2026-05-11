<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="adminPage" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Mission Control</title>
<%@ include file="../common/head.jspf" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<style>
.stat-card { position: relative; overflow: hidden; }
.stat-card::before { content:''; position:absolute; top:-40px; right:-40px; width:120px; height:120px; background:radial-gradient(circle, rgba(109,221,255,0.08) 0%, transparent 70%); border-radius:50%; }
.bar { display:inline-flex; align-items:flex-end; gap:2px; height:40px; }
.bar span { width:4px; background:rgba(109,221,255,0.4); border-radius:2px; animation:grow 1s ease-out forwards; transform-origin:bottom; }
@keyframes grow { from{transform:scaleY(0)} to{transform:scaleY(1)} }
</style>
</head>
<body class="bg-surface text-on-surface font-body">
<div class="grain-overlay"></div>
<%@ include file="../common/admin-sidebar.jspf" %>

<main class="ml-64 min-h-screen">

    <!-- Top Header -->
    <header class="flex justify-between items-center px-10 py-6 border-b border-white/5">
        <div>
            <p class="font-label text-[10px] uppercase tracking-[0.3em] text-on-surface/40 mb-1">Orbital Command Center</p>
            <h2 class="font-headline text-3xl font-black text-shimmer">Mission Control</h2>
        </div>
        <div class="flex items-center gap-4">
            <div class="glass-panel px-4 py-2 flex items-center gap-2">
                <span class="material-symbols-outlined text-sm text-on-surface/40">search</span>
                <span class="font-label text-[10px] uppercase tracking-widest text-on-surface/30">Query Coordinates...</span>
            </div>
            <div class="w-9 h-9 glass-panel rounded-full flex items-center justify-center relative">
                <span class="material-symbols-outlined text-sm">notifications</span>
                <c:if test="${unreadMessages > 0}">
                    <span class="absolute -top-1 -right-1 w-4 h-4 bg-error rounded-full text-[8px] flex items-center justify-center font-bold">${unreadMessages}</span>
                </c:if>
            </div>
            <div class="flex items-center gap-3 glass-panel px-4 py-2">
                <div class="w-7 h-7 bg-primary/20 border border-primary/30 rounded-full flex items-center justify-center">
                    <span class="material-symbols-outlined text-primary text-sm">person</span>
                </div>
                <div>
                    <p class="font-label text-[10px] font-bold uppercase tracking-wider text-on-surface">${sessionScope.user.fullName}</p>
                    <p class="font-label text-[8px] uppercase tracking-widest text-primary">Level 4 Clearance</p>
                </div>
            </div>
        </div>
    </header>

    <div class="px-10 py-8 space-y-8">

        <!-- Stats Grid -->
        <div class="grid grid-cols-4 gap-5">
            <div class="stat-card glass-panel p-6 rounded-sm">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/40 mb-3">Total Commanders</p>
                <div class="flex items-end justify-between">
                    <div>
                        <h3 class="font-headline text-4xl font-black text-shimmer">${totalUsers}</h3>
                        <p class="font-label text-[9px] text-primary mt-1">↑ Active Personnel</p>
                    </div>
                    <div class="bar">
                        <span style="height:30%;animation-delay:0.1s"></span>
                        <span style="height:50%;animation-delay:0.2s"></span>
                        <span style="height:40%;animation-delay:0.3s"></span>
                        <span style="height:70%;animation-delay:0.4s"></span>
                        <span style="height:60%;animation-delay:0.5s"></span>
                        <span style="height:90%;animation-delay:0.6s"></span>
                        <span style="height:80%;animation-delay:0.7s"></span>
                    </div>
                </div>
            </div>
            <div class="stat-card glass-panel p-6 rounded-sm">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/40 mb-3">Active Sessions</p>
                <div class="flex items-end justify-between">
                    <div>
                        <h3 class="font-headline text-4xl font-black text-shimmer">Live</h3>
                        <p class="font-label text-[9px] text-primary mt-1 flex items-center gap-1"><span class="w-1.5 h-1.5 bg-primary rounded-full animate-pulse inline-block"></span> Online Now</p>
                    </div>
                    <div class="bar">
                        <span style="height:60%;animation-delay:0.1s"></span>
                        <span style="height:80%;animation-delay:0.2s"></span>
                        <span style="height:50%;animation-delay:0.3s"></span>
                        <span style="height:90%;animation-delay:0.4s"></span>
                        <span style="height:70%;animation-delay:0.5s"></span>
                        <span style="height:100%;animation-delay:0.6s"></span>
                        <span style="height:85%;animation-delay:0.7s"></span>
                    </div>
                </div>
            </div>
            <div class="stat-card glass-panel p-6 rounded-sm">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/40 mb-3">Favorites Saved</p>
                <div class="flex items-end justify-between">
                    <div>
                        <h3 class="font-headline text-4xl font-black text-shimmer">${totalFavorites}</h3>
                        <p class="font-label text-[9px] text-primary mt-1">↑ Archive entries</p>
                    </div>
                    <div class="bar">
                        <span style="height:40%;animation-delay:0.1s"></span>
                        <span style="height:60%;animation-delay:0.2s"></span>
                        <span style="height:75%;animation-delay:0.3s"></span>
                        <span style="height:55%;animation-delay:0.4s"></span>
                        <span style="height:85%;animation-delay:0.5s"></span>
                        <span style="height:70%;animation-delay:0.6s"></span>
                        <span style="height:95%;animation-delay:0.7s"></span>
                    </div>
                </div>
            </div>
            <div class="stat-card glass-panel p-6 rounded-sm">
                <p class="font-label text-[9px] uppercase tracking-[0.25em] text-on-surface/40 mb-3">Unread Messages</p>
                <div class="flex items-end justify-between">
                    <div>
                        <h3 class="font-headline text-4xl font-black ${unreadMessages > 0 ? 'text-error' : 'text-shimmer'}">${unreadMessages}</h3>
                        <p class="font-label text-[9px] ${unreadMessages > 0 ? 'text-error' : 'text-primary'} mt-1">${unreadMessages > 0 ? '⚠ Needs attention' : '✓ All clear'}</p>
                    </div>
                    <div class="bar">
                        <span style="height:20%;animation-delay:0.1s"></span>
                        <span style="height:45%;animation-delay:0.2s"></span>
                        <span style="height:30%;animation-delay:0.3s"></span>
                        <span style="height:60%;animation-delay:0.4s"></span>
                        <span style="height:40%;animation-delay:0.5s"></span>
                        <span style="height:75%;animation-delay:0.6s"></span>
                        <span style="height:50%;animation-delay:0.7s"></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart + Recent Activity -->
        <div class="grid grid-cols-3 gap-6">
            <!-- User Growth Chart -->
            <div class="col-span-2 glass-panel rounded-sm p-8">
                <div class="flex justify-between items-start mb-6">
                    <div>
                        <h4 class="font-headline text-xl font-bold">User Growth</h4>
                        <p class="font-label text-[9px] uppercase tracking-widest text-on-surface/40">Temporal Analysis • Last 7 Days</p>
                    </div>
                    <div class="flex gap-2">
                        <span class="px-3 py-1 bg-primary text-on-primary font-label text-[9px] uppercase tracking-widest rounded-sm">Cycle</span>
                        <span class="px-3 py-1 glass-panel font-label text-[9px] uppercase tracking-widest text-on-surface/40 rounded-sm">Orbit</span>
                    </div>
                </div>
                <canvas id="growthChart" height="120"></canvas>
            </div>

            <!-- Recent Activity -->
            <div class="glass-panel rounded-sm p-8">
                <h4 class="font-headline text-xl font-bold mb-1">Recent Activity</h4>
                <p class="font-label text-[9px] uppercase tracking-widest text-on-surface/40 mb-6">System Events</p>
                <div class="space-y-4">
                    <div class="flex items-start gap-3">
                        <div class="w-8 h-8 bg-primary/10 border border-primary/20 rounded-full flex items-center justify-center flex-shrink-0">
                            <span class="material-symbols-outlined text-primary text-sm">person_add</span>
                        </div>
                        <div>
                            <p class="font-body text-xs font-semibold">New user registered</p>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest">User Management</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-3">
                        <div class="w-8 h-8 bg-secondary/10 border border-secondary/20 rounded-full flex items-center justify-center flex-shrink-0">
                            <span class="material-symbols-outlined text-secondary text-sm">favorite</span>
                        </div>
                        <div>
                            <p class="font-body text-xs font-semibold">Favorites archived</p>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest">Archive System</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-3">
                        <div class="w-8 h-8 bg-error/10 border border-error/20 rounded-full flex items-center justify-center flex-shrink-0">
                            <span class="material-symbols-outlined text-error text-sm">mail</span>
                        </div>
                        <div>
                            <p class="font-body text-xs font-semibold">${unreadMessages} unread messages</p>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest">Communications</p>
                        </div>
                    </div>
                    <div class="flex items-start gap-3">
                        <div class="w-8 h-8 bg-primary/10 border border-primary/20 rounded-full flex items-center justify-center flex-shrink-0">
                            <span class="material-symbols-outlined text-primary text-sm">rocket_launch</span>
                        </div>
                        <div>
                            <p class="font-body text-xs font-semibold">System operational</p>
                            <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest">Global Command</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- User Directory -->
        <div class="glass-panel overflow-hidden rounded-sm">
            <div class="p-8 border-b border-white/5 flex justify-between items-center">
                <div>
                    <h4 class="font-headline text-xl font-bold">Commander Directory</h4>
                    <p class="font-label text-[9px] text-on-surface/40 uppercase tracking-widest">Live registry of all orbital personnel</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/users" class="px-5 py-2 border border-primary/30 text-primary font-label text-[9px] uppercase tracking-widest hover:bg-primary hover:text-on-primary transition-all">
                    Manage All
                </a>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-white/[0.02]">
                        <tr>
                            <th class="px-8 py-4 font-label text-[9px] uppercase tracking-widest text-on-surface/30">Identifier</th>
                            <th class="px-8 py-4 font-label text-[9px] uppercase tracking-widest text-on-surface/30">Clearance</th>
                            <th class="px-8 py-4 font-label text-[9px] uppercase tracking-widest text-on-surface/30">Status</th>
                            <th class="px-8 py-4 font-label text-[9px] uppercase tracking-widest text-on-surface/30">Enlistment</th>
                            <th class="px-8 py-4 font-label text-[9px] uppercase tracking-widest text-on-surface/30 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach items="${allUsers}" var="u">
                        <tr class="hover:bg-white/[0.03] transition-colors">
                            <td class="px-8 py-5">
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 bg-primary/10 border border-primary/20 rounded-full flex items-center justify-center">
                                        <span class="material-symbols-outlined text-primary text-sm">person</span>
                                    </div>
                                    <div>
                                        <p class="font-body text-xs font-semibold">${u.fullName}</p>
                                        <p class="font-label text-[9px] text-on-surface/40">${u.email}</p>
                                    </div>
                                </div>
                            </td>
                            <td class="px-8 py-5">
                                <span class="px-2 py-1 ${u.admin ? 'bg-secondary/10 border-secondary/20 text-secondary' : 'bg-primary/10 border-primary/20 text-primary'} border text-[8px] font-label uppercase tracking-widest rounded-sm">${u.admin ? 'Director' : 'Specialist'}</span>
                            </td>
                            <td class="px-8 py-5">
                                <div class="flex items-center gap-2">
                                    <div class="w-2 h-2 rounded-full ${u.locked ? 'bg-error' : 'bg-primary shadow-[0_0_6px_#6dddff] animate-pulse'}"></div>
                                    <span class="font-label text-[9px] uppercase tracking-wider">${u.locked ? 'Offline' : 'Online'}</span>
                                </div>
                            </td>
                            <td class="px-8 py-5 font-label text-[9px] text-on-surface/50">${u.createdAt}</td>
                            <td class="px-8 py-5 text-right">
                                <form method="POST" action="${pageContext.request.contextPath}/admin/users" class="inline-flex gap-3">
                                    <input type="hidden" name="userId" value="${u.id}"/>
                                    <c:choose>
                                        <c:when test="${u.id == pageContext.session.getAttribute('user').id}">
                                            <span class="text-primary text-[9px] font-label uppercase tracking-widest">You</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${u.locked}">
                                                <button name="action" value="unlock" class="text-primary text-[9px] font-label uppercase hover:underline">Unlock</button>
                                            </c:if>
                                            <c:if test="${!u.locked and !u.admin}">
                                                <button name="action" value="lock" class="text-secondary text-[9px] font-label uppercase hover:underline">Lock</button>
                                            </c:if>
                                            <c:if test="${!u.admin}">
                                                <button name="action" value="delete" class="text-error text-[9px] font-label uppercase hover:underline" onclick="return confirm('Delete this user?')">Delete</button>
                                            </c:if>
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

<script>
const ctx = document.getElementById('growthChart').getContext('2d');
new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['Day 1','Day 2','Day 3','Day 4','Day 5','Day 6','Day 7'],
        datasets: [{
            data: [2, 5, 4, 8, 6, 11, ${totalUsers}],
            borderColor: '#6dddff',
            borderWidth: 2,
            pointBackgroundColor: '#6dddff',
            pointRadius: 4,
            tension: 0.4,
            fill: true,
            backgroundColor: (ctx) => {
                const g = ctx.chart.ctx.createLinearGradient(0,0,0,200);
                g.addColorStop(0,'rgba(109,221,255,0.15)');
                g.addColorStop(1,'rgba(109,221,255,0)');
                return g;
            }
        }]
    },
    options: {
        responsive: true,
        plugins: { legend: { display: false } },
        scales: {
            x: { grid: { color: 'rgba(255,255,255,0.03)' }, ticks: { color: 'rgba(255,255,255,0.3)', font: { size: 9 } } },
            y: { grid: { color: 'rgba(255,255,255,0.03)' }, ticks: { color: 'rgba(255,255,255,0.3)', font: { size: 9 } } }
        }
    }
});
</script>
</body>
</html>