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
    public static final String OPENROUTER_MODEL = "meta-llama/llama-3.2-3b-instruct:free";

   

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
