package com.cosmosiq.controllers;

import com.cosmosiq.service.AiFactService;
import com.google.gson.JsonObject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/aifact")
public class AIFactServlet extends HttpServlet {

    private final AiFactService aiFactService = new AiFactService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String topicKey = req.getParameter("key");
        String topicDesc = req.getParameter("topic");

        if (topicKey == null || topicDesc == null) {
            resp.setStatus(400);
            return;
        }

        String fact = aiFactService.getAIFact(topicKey, topicDesc);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        JsonObject json = new JsonObject();
        json.addProperty("fact", fact);
        resp.getWriter().write(json.toString());
    }
}
