package com.cosmosiq.model;

import com.cosmosiq.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {

    public boolean insert(ContactMessage m) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?,?,?,?)";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getEmail());
            ps.setString(3, m.getSubject());
            ps.setString(4, m.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<ContactMessage> findAll() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY submitted_at DESC";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public ContactMessage findById(int id) {
        String sql = "SELECT * FROM contact_messages WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean markRead(int id) {
        String sql = "UPDATE contact_messages SET is_read=TRUE WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM contact_messages WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int countUnread() {
        String sql = "SELECT COUNT(*) FROM contact_messages WHERE is_read=FALSE";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private ContactMessage map(ResultSet rs) throws SQLException {
        ContactMessage m = new ContactMessage();
        m.setId(rs.getInt("id"));
        m.setName(rs.getString("name"));
        m.setEmail(rs.getString("email"));
        m.setSubject(rs.getString("subject"));
        m.setMessage(rs.getString("message"));
        m.setRead(rs.getBoolean("is_read"));
        m.setSubmittedAt(rs.getTimestamp("submitted_at"));
        return m;
    }
}
