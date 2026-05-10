package com.cosmosiq.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Central configuration class for CosmosIQ.
 *
 * EDIT THE CONSTANTS BELOW TO MATCH YOUR ENVIRONMENT.
 *
 * Default values assume XAMPP MySQL running on localhost with no root password
 * (the standard XAMPP fresh-install state).
 */
public class DBConfig {

    

    /** JDBC URL for MySQL. */
    public static final String DB_URL = "jdbc:mysql://localhost:3306/cosmosiq_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    public static final String DB_USER = "root";
    public static final String DB_PASSWORD = "";

  
    // EXTERNAL API KEYS

    /** NASA API key */
    public static final String NASA_API_KEY = "spiLUFcT3cxfsgiHWZYKEVS9rZRS8v3SK6YBDG1y";

    /** OpenRouter API key */
    public static final String OPENROUTER_API_KEY = "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";

    /** OpenRouter model */
    public static final String OPENROUTER_MODEL = "openai/gpt-oss-20b:free";
    
    // Email config
    public static final String SMTP_EMAIL    = "rajpandit69365@gmail.com";
    public static final String SMTP_PASSWORD = "fmfyglxqvhkuvjut"; 
   

    static {
        try {
            // Force-load the MySQL driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. Check pom.xml dependencies.", e);
        }
    }

    /**
     * Get a fresh JDBC connection. Caller is responsible for closing it
     * (use try-with-resources).
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
