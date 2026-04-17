package com.cosmosiq.model;

import java.sql.Timestamp;

public class Favorite {
    private int id;
    private int userId;
    private String type;          // "apod", "mars", "asteroid"
    private String title;
    private String description;
    private String imageUrl;
    private String sourceDate;
    private Timestamp savedAt;

    public Favorite() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getSourceDate() { return sourceDate; }
    public void setSourceDate(String sourceDate) { this.sourceDate = sourceDate; }

    public Timestamp getSavedAt() { return savedAt; }
    public void setSavedAt(Timestamp savedAt) { this.savedAt = savedAt; }
}
