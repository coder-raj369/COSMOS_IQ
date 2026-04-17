package com.cosmosiq.model;

import com.cosmosiq.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SpaceEventDAO {

    public boolean insert(SpaceEvent e) {
        String sql = "INSERT INTO space_events (title, event_date, description, type, image_url, is_featured, created_by) VALUES (?,?,?,?,?,?,?)";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, e.getTitle());
            ps.setDate(2, e.getEventDate());
            ps.setString(3, e.getDescription());
            ps.setString(4, e.getType());
            ps.setString(5, e.getImageUrl());
            ps.setBoolean(6, e.isFeatured());
            if (e.getCreatedBy() != null) ps.setInt(7, e.getCreatedBy()); else ps.setNull(7, Types.INTEGER);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) { ex.printStackTrace(); }
        return false;
    }

    public boolean update(SpaceEvent e) {
        String sql = "UPDATE space_events SET title=?, event_date=?, description=?, type=?, image_url=?, is_featured=? WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, e.getTitle());
            ps.setDate(2, e.getEventDate());
            ps.setString(3, e.getDescription());
            ps.setString(4, e.getType());
            ps.setString(5, e.getImageUrl());
            ps.setBoolean(6, e.isFeatured());
            ps.setInt(7, e.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) { ex.printStackTrace(); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM space_events WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public SpaceEvent findById(int id) {
        String sql = "SELECT * FROM space_events WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<SpaceEvent> findAll() {
        List<SpaceEvent> list = new ArrayList<>();
        String sql = "SELECT * FROM space_events ORDER BY event_date DESC";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<SpaceEvent> findFeatured() {
        List<SpaceEvent> list = new ArrayList<>();
        String sql = "SELECT * FROM space_events WHERE is_featured=TRUE ORDER BY event_date ASC";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private SpaceEvent map(ResultSet rs) throws SQLException {
        SpaceEvent e = new SpaceEvent();
        e.setId(rs.getInt("id"));
        e.setTitle(rs.getString("title"));
        e.setEventDate(rs.getDate("event_date"));
        e.setDescription(rs.getString("description"));
        e.setType(rs.getString("type"));
        e.setImageUrl(rs.getString("image_url"));
        e.setFeatured(rs.getBoolean("is_featured"));
        e.setCreatedBy(rs.getObject("created_by") != null ? rs.getInt("created_by") : null);
        e.setCreatedAt(rs.getTimestamp("created_at"));
        return e;
    }
}
