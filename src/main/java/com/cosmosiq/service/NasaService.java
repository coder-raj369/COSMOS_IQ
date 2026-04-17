package com.cosmosiq.service;

import com.cosmosiq.config.DBConfig;
import com.cosmosiq.util.HttpUtil;
import com.google.gson.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * Calls NASA free APIs and returns parsed data as Maps/Lists.
 * Uses Gson for JSON parsing. All methods return safe defaults on failure.
 */
public class NasaService {

    private static final String BASE = "https://api.nasa.gov";

    // ===== APOD (Astronomy Picture of the Day) =====

    /** Get APOD for a specific date (format: "yyyy-MM-dd"). */
    public Map<String, String> getApod(String date) {
        try {
            String url = BASE + "/planetary/apod?api_key=" + DBConfig.NASA_API_KEY;
            if (date != null && !date.isEmpty()) url += "&date=" + date;
            String json = HttpUtil.get(url);
            JsonObject obj = JsonParser.parseString(json).getAsJsonObject();
            Map<String, String> result = new HashMap<>();
            result.put("title",       getStr(obj, "title"));
            result.put("date",        getStr(obj, "date"));
            result.put("explanation", getStr(obj, "explanation"));
            result.put("url",         getStr(obj, "url"));
            result.put("hdurl",       getStr(obj, "hdurl"));
            result.put("media_type",  getStr(obj, "media_type"));
            result.put("copyright",   getStr(obj, "copyright"));
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return fallbackApod();
        }
    }

    /** Get today's APOD. */
    public Map<String, String> getTodayApod() {
        return getApod(null);
    }

    // ===== Mars Rover Photos =====

    /** Get Mars rover photos. rover: curiosity|perseverance|opportunity|spirit */
    public List<Map<String, String>> getMarsPhotos(String rover, String earthDate, String camera) {
        List<Map<String, String>> photos = new ArrayList<>();
        try {
            String url = BASE + "/mars-photos/api/v1/rovers/" + rover + "/photos?api_key=" + DBConfig.NASA_API_KEY;
            if (earthDate != null && !earthDate.isEmpty()) {
                url += "&earth_date=" + earthDate;
            } else {
                url += "&sol=1000";
            }
            if (camera != null && !camera.isEmpty()) url += "&camera=" + camera;
            url += "&page=1";

            String json = HttpUtil.get(url);
            JsonObject obj = JsonParser.parseString(json).getAsJsonObject();
            JsonArray arr = obj.getAsJsonArray("photos");
            if (arr != null) {
                int limit = Math.min(arr.size(), 20);
                for (int i = 0; i < limit; i++) {
                    JsonObject p = arr.get(i).getAsJsonObject();
                    Map<String, String> photo = new HashMap<>();
                    photo.put("id",        String.valueOf(p.get("id").getAsInt()));
                    photo.put("sol",       String.valueOf(p.get("sol").getAsInt()));
                    photo.put("img_src",   getStr(p, "img_src"));
                    photo.put("earth_date",getStr(p, "earth_date"));
                    if (p.has("camera") && p.get("camera").isJsonObject()) {
                        photo.put("camera", getStr(p.getAsJsonObject("camera"), "full_name"));
                    }
                    if (p.has("rover") && p.get("rover").isJsonObject()) {
                        photo.put("rover", getStr(p.getAsJsonObject("rover"), "name"));
                    }
                    photos.add(photo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return photos;
    }

    // ===== Near-Earth Objects (Asteroids) =====

    /** Get asteroids approaching Earth this week. */
    public List<Map<String, String>> getNearEarthObjects() {
        List<Map<String, String>> asteroids = new ArrayList<>();
        try {
            LocalDate today = LocalDate.now();
            String start = today.format(DateTimeFormatter.ISO_DATE);
            String end = today.plusDays(7).format(DateTimeFormatter.ISO_DATE);
            String url = BASE + "/neo/rest/v1/feed?start_date=" + start + "&end_date=" + end + "&api_key=" + DBConfig.NASA_API_KEY;

            String json = HttpUtil.get(url);
            JsonObject obj = JsonParser.parseString(json).getAsJsonObject();
            JsonObject neos = obj.getAsJsonObject("near_earth_objects");
            if (neos != null) {
                for (String dateKey : neos.keySet()) {
                    JsonArray arr = neos.getAsJsonArray(dateKey);
                    for (JsonElement el : arr) {
                        JsonObject neo = el.getAsJsonObject();
                        Map<String, String> a = new HashMap<>();
                        a.put("id",   getStr(neo, "id"));
                        a.put("name", getStr(neo, "name"));
                        a.put("hazardous", String.valueOf(neo.get("is_potentially_hazardous_asteroid").getAsBoolean()));
                        a.put("close_approach_date", dateKey);

                        // Diameter
                        if (neo.has("estimated_diameter")) {
                            JsonObject d = neo.getAsJsonObject("estimated_diameter").getAsJsonObject("meters");
                            double min = d.get("estimated_diameter_min").getAsDouble();
                            double max = d.get("estimated_diameter_max").getAsDouble();
                            a.put("diameter", String.format("%.0f - %.0f m", min, max));
                            a.put("diameter_avg", String.format("%.0f", (min + max) / 2));
                        }

                        // Close approach data
                        if (neo.has("close_approach_data")) {
                            JsonArray approaches = neo.getAsJsonArray("close_approach_data");
                            if (approaches.size() > 0) {
                                JsonObject ca = approaches.get(0).getAsJsonObject();
                                a.put("velocity", String.format("%.2f", ca.getAsJsonObject("relative_velocity").get("kilometers_per_second").getAsDouble()));
                                a.put("miss_distance_km", String.format("%.0f", ca.getAsJsonObject("miss_distance").get("kilometers").getAsDouble()));
                                a.put("miss_distance_lunar", String.format("%.2f", ca.getAsJsonObject("miss_distance").get("lunar").getAsDouble()));
                            }
                        }
                        asteroids.add(a);
                    }
                }
            }
            // Sort: hazardous first
            asteroids.sort((x, y) -> Boolean.compare("true".equals(y.get("hazardous")), "true".equals(x.get("hazardous"))));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return asteroids;
    }

    // ===== Helpers =====

    private String getStr(JsonObject obj, String key) {
        return obj.has(key) && !obj.get(key).isJsonNull() ? obj.get(key).getAsString() : "";
    }

    private Map<String, String> fallbackApod() {
        Map<String, String> m = new HashMap<>();
        m.put("title", "The Pillars of Creation");
        m.put("date", LocalDate.now().toString());
        m.put("explanation", "Massive columns of interstellar gas and dust in the Eagle Nebula where new stars are forming.");
        m.put("url", "https://apod.nasa.gov/apod/image/2301/PillarsOfCreation.jpg");
        m.put("media_type", "image");
        return m;
    }
}
