package com.cosmosiq.service;

import com.cosmosiq.config.DBConfig;
import com.cosmosiq.model.AiFactDAO;
import com.cosmosiq.util.HttpUtil;
import com.google.gson.*;

/**
 * Generates AI-powered space facts using OpenRouter's free API.
 * Caches results in the database to avoid repeat API calls.
 */
public class AiFactService {

    private static final String OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions";
    private final AiFactDAO aiFactDAO = new AiFactDAO();

    /**
     * Get an AI fact about the given topic. Checks cache first.
     */
    public String getAIFact(String topicKey, String topicDescription) {
        // 1. Check cache
        String cached = aiFactDAO.getCached(topicKey);
        if (cached != null) return cached;

        // 2. Call OpenRouter
        String fact = callOpenRouter(topicDescription);

        // 3. Cache the result
        if (fact != null && !fact.isEmpty()) {
            aiFactDAO.saveFact(topicKey, fact);
        }
        return fact;
    }

    private String callOpenRouter(String topic) {
        String apiKey = DBConfig.OPENROUTER_API_KEY;
        if (apiKey == null || apiKey.isEmpty() || apiKey.startsWith("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")) {
            return "AI insights are coming soon! Configure your OpenRouter API key in DBConfig.java to enable this feature.";
        }

        try {
            String prompt = "Give me one fascinating science fact about: " + topic
                    + ". Keep it under 3 sentences. Be specific and mind-blowing.";

            JsonObject message = new JsonObject();
            message.addProperty("role", "user");
            message.addProperty("content", prompt);

            JsonArray messages = new JsonArray();
            messages.add(message);

            JsonObject body = new JsonObject();
            body.addProperty("model", DBConfig.OPENROUTER_MODEL);
            body.add("messages", messages);
            body.addProperty("max_tokens", 200);
            body.addProperty("temperature", 0.7);

            String response = HttpUtil.postJson(OPENROUTER_URL, body.toString(), apiKey);
            JsonObject resp = JsonParser.parseString(response).getAsJsonObject();

            if (resp.has("choices")) {
                JsonArray choices = resp.getAsJsonArray("choices");
                if (choices.size() > 0) {
                    return choices.get(0).getAsJsonObject()
                            .getAsJsonObject("message")
                            .get("content").getAsString().trim();
                }
            }
            return "The cosmos holds mysteries we are still unraveling.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Unable to connect to AI service. Try again later.";
        }
    }
}
