package com.cosmosiq.model;

import com.cosmosiq.config.DBConfig;
import java.sql.*;

public class AiFactDAO {

    public String getCached(String topicKey) {
        String sql = "SELECT fact_text FROM ai_facts_cache WHERE topic_key=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, topicKey);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("fact_text");
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean saveFact(String topicKey, String factText) {
        String sql = "INSERT INTO ai_facts_cache (topic_key, fact_text) VALUES (?,?) ON DUPLICATE KEY UPDATE fact_text=?, generated_at=CURRENT_TIMESTAMP";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, topicKey);
            ps.setString(2, factText);
            ps.setString(3, factText);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM ai_facts_cache";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
