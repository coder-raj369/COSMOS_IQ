package com.cosmosiq.util;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Tiny HTTP client wrapper using java.net.http (built into Java 11+).
 * Used by NasaService and AiFactService to call external APIs.
 */
public class HttpUtil {

    private static final HttpClient CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(15))
            .followRedirects(HttpClient.Redirect.NORMAL)
            .build();

    /** Simple GET — returns response body as string. */
    public static String get(String url) throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(20))
                .header("Accept", "application/json")
                .header("User-Agent", "CosmosIQ/1.0")
                .GET()
                .build();
        HttpResponse<String> response = CLIENT.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() >= 400) {
            throw new IOException("HTTP " + response.statusCode() + " from " + url);
        }
        return response.body();
    }

    /** POST with JSON body and bearer token (used for OpenRouter). */
    public static String postJson(String url, String jsonBody, String bearerToken)
            throws IOException, InterruptedException {
        HttpRequest.Builder builder = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(30))
                .header("Content-Type", "application/json")
                .header("Accept", "application/json")
                .header("User-Agent", "CosmosIQ/1.0")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody));
        if (bearerToken != null && !bearerToken.isEmpty()) {
            builder.header("Authorization", "Bearer " + bearerToken);
        }
        HttpResponse<String> response = CLIENT.send(builder.build(), HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() >= 400) {
            throw new IOException("HTTP " + response.statusCode() + ": " + response.body());
        }
        return response.body();
    }
}
