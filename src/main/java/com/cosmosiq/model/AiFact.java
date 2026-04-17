package com.cosmosiq.model;

import java.sql.Timestamp;

public class AiFact {
    private int id;
    private String topicKey;
    private String factText;
    private Timestamp generatedAt;

    public AiFact() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTopicKey() { return topicKey; }
    public void setTopicKey(String topicKey) { this.topicKey = topicKey; }

    public String getFactText() { return factText; }
    public void setFactText(String factText) { this.factText = factText; }

    public Timestamp getGeneratedAt() { return generatedAt; }
    public void setGeneratedAt(Timestamp generatedAt) { this.generatedAt = generatedAt; }
}
