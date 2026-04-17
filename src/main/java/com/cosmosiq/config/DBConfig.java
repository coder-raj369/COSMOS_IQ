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

    // =================================================================
    // EDIT THESE VALUES IF NEEDED
    // =================================================================

    /** JDBC URL for MySQL. XAMPP default is localhost:3306. */
    public static final String DB_URL = "jdbc:mysql://localhost:3306/cosmosiq_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    /** MySQL username. XAMPP default is "root". */
    public static final String DB_USER = "root";

    /** MySQL password. XAMPP default is empty string "". */
    public static final String DB_PASSWORD = "";

    // -----------------------------------------------------------------
    // EXTERNAL API KEYS
    // -----------------------------------------------------------------

    /** NASA API key — get a free one at https://api.nasa.gov (instant). */
    public static final String NASA_API_KEY = "DEMO_KEY";

    /** OpenRouter API key — get free credits at https://openrouter.ai */
    public static final String OPENROUTER_API_KEY = "PUT_YOUR_OPENROUTER_KEY_HERE";

    /** OpenRouter model to use for AI facts. */
    public static final String OPENROUTER_MODEL = "meta-llama/llama-3.2-3b-instruct:free";

    // =================================================================
    // INTERNALS — do not edit below
    // =================================================================

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
