package com.cosmosiq.model;

import com.cosmosiq.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FavoriteDAO {

    public boolean insert(Favorite f) {
        String sql = "INSERT INTO favorites (user_id, type, title, description, image_url, source_date) VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, f.getUserId());
            ps.setString(2, f.getType());
            ps.setString(3, f.getTitle());
            ps.setString(4, f.getDescription());
            ps.setString(5, f.getImageUrl());
            ps.setString(6, f.getSourceDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean delete(int favId, int userId) {
        String sql = "DELETE FROM favorites WHERE id=? AND user_id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, favId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<Favorite> findByUser(int userId) {
        List<Favorite> list = new ArrayList<>();
        String sql = "SELECT * FROM favorites WHERE user_id=? ORDER BY saved_at DESC";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Favorite> findByUserAndType(int userId, String type) {
        List<Favorite> list = new ArrayList<>();
        String sql = "SELECT * FROM favorites WHERE user_id=? AND type=? ORDER BY saved_at DESC";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, type);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Favorite> searchByUser(int userId, String keyword) {
        List<Favorite> list = new ArrayList<>();
        String sql = "SELECT * FROM favorites WHERE user_id=? AND (title LIKE ? OR description LIKE ?) ORDER BY saved_at DESC";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            String pattern = "%" + keyword + "%";
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM favorites";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public boolean exists(int userId, String type, String title) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id=? AND type=? AND title=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, type);
            ps.setString(3, title);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    private Favorite map(ResultSet rs) throws SQLException {
        Favorite f = new Favorite();
        f.setId(rs.getInt("id"));
        f.setUserId(rs.getInt("user_id"));
        f.setType(rs.getString("type"));
        f.setTitle(rs.getString("title"));
        f.setDescription(rs.getString("description"));
        f.setImageUrl(rs.getString("image_url"));
        f.setSourceDate(rs.getString("source_date"));
        f.setSavedAt(rs.getTimestamp("saved_at"));
        return f;
    }
}
