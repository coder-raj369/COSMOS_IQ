<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="adminPage" value="messages" scope="request"/>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<title>CosmosIQ | Messages</title>
<%@ include file="../common/head.jspf" %>
</head>
<body class="bg-surface text-on-surface font-body">
<div class="grain-overlay"></div>
<%@ include file="../common/admin-sidebar.jspf" %>

<main class="ml-64 min-h-screen flex flex-col">
    <header class="h-20 flex items-center px-10 border-b border-white/5 pt-8">
        <h2 class="font-headline text-3xl font-black text-shimmer">Transmissions</h2>
    </header>

    <div class="flex-1 flex min-h-0">
        <!-- Message List -->
        <section class="w-96 flex flex-col border-r border-white/5 bg-surface-container-low/30 overflow-y-auto">
            <c:forEach items="${messages}" var="msg">
            <a href="${pageContext.request.contextPath}/admin/messages?id=${msg.id}" class="px-6 py-6 border-b border-white/5 hover:bg-white/5 transition-all cursor-pointer ${selectedMessage.id == msg.id ? 'bg-primary/5 border-l-2 border-l-primary' : ''}">
                <div class="flex justify-between items-start mb-2">
                    <div class="flex items-center gap-2">
                        <h3 class="font-headline text-sm font-bold">${msg.name}</h3>
                        <c:if test="${!msg.read}"><div class="w-1.5 h-1.5 rounded-full bg-primary shadow-[0_0_8px_rgba(109,221,255,0.8)]"></div></c:if>
                    </div>
                    <span class="font-label text-[9px] uppercase text-on-surface/40">${msg.submittedAt}</span>
                </div>
                <p class="text-xs font-semibold text-on-surface mb-1">${msg.subject}</p>
                <p class="text-[11px] text-on-surface/50 line-clamp-2">${msg.message}</p>
            </a>
            </c:forEach>
            <c:if test="${empty messages}">
                <div class="p-12 text-center text-on-surface-variant/40">
                    <span class="material-symbols-outlined text-4xl mb-4">inbox</span>
                    <p class="font-label text-xs uppercase tracking-widest">No transmissions</p>
                </div>
            </c:if>
        </section>

        <!-- Message Detail -->
        <section class="flex-1 flex flex-col bg-surface overflow-y-auto">
            <c:if test="${not empty selectedMessage}">
                <div class="p-10">
                    <div class="flex justify-between items-start mb-8">
                        <div>
                            <h4 class="font-headline text-xl font-bold">${selectedMessage.name}</h4>
                            <p class="text-[10px] font-label tracking-widest text-primary mt-1">${selectedMessage.email}</p>
                        </div>
                        <form method="POST" action="${pageContext.request.contextPath}/admin/messages">
                            <input type="hidden" name="msgId" value="${selectedMessage.id}"/>
                            <button name="action" value="delete" class="text-error text-[10px] font-label uppercase hover:underline" onclick="return confirm('Delete?')">Delete</button>
                        </form>
                    </div>
                    <h2 class="font-headline text-3xl font-bold mb-4 text-shimmer">${selectedMessage.subject}</h2>
                    <span class="font-label text-[10px] text-on-surface/40 uppercase tracking-widest">${selectedMessage.submittedAt}</span>
                    <div class="mt-8 text-on-surface/80 text-sm leading-relaxed whitespace-pre-line">${selectedMessage.message}</div>
                </div>
            </c:if>
            <c:if test="${empty selectedMessage}">
                <div class="flex-1 flex items-center justify-center text-on-surface-variant/30">
                    <div class="text-center">
                        <span class="material-symbols-outlined text-6xl mb-4">mail</span>
                        <p class="font-label text-xs uppercase tracking-widest">Select a transmission</p>
                    </div>
                </div>
            </c:if>
        </section>
    </div>
</main>
</body>
</html>
