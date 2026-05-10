package com.cosmosiq.model;

import com.cosmosiq.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // --- Find by email (login) ---
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // --- Find by username ---
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // --- Find by ID ---
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // --- Insert new user (register) ---
    public boolean insert(User u) {
        String sql = "INSERT INTO users (username, email, password, full_name, role) VALUES (?,?,?,?,?)";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getFullName());
            ps.setString(5, u.getRole() != null ? u.getRole() : "member");
            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) u.setId(keys.getInt(1));
                return true;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- Update profile ---
    public boolean updateProfile(User u) {
        String sql = "UPDATE users SET full_name=?, username=?, email=?, bio=? WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getBio());
            ps.setInt(5, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- Update password ---
    public boolean updatePassword(int userId, String newHashedPassword) {
        String sql = "UPDATE users SET password=? WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, newHashedPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- Increment failed attempts ---
    public void incrementFailedAttempts(String email) {
        String sql = "UPDATE users SET failed_attempts = failed_attempts + 1 WHERE email = ?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // --- Lock account ---
    public void lockAccount(String email) {
        String sql = "UPDATE users SET is_locked = TRUE WHERE email = ?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // --- Reset failed attempts on successful login ---
    public void resetFailedAttempts(String email) {
        String sql = "UPDATE users SET failed_attempts = 0 WHERE email = ?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // --- Toggle lock (admin) ---
    public boolean toggleLock(int userId, boolean lock) {
        String sql = "UPDATE users SET is_locked=?, failed_attempts=0 WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, lock);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- Change role (admin) ---
    public boolean updateRole(int userId, String role) {
        String sql = "UPDATE users SET role=? WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- Delete user (admin) ---
    public boolean delete(int userId) {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- List all users (admin) ---
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // --- Count all users ---
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection c = DBConfig.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // --- Check email exists ---
    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }

    // --- Check username exists ---
    public boolean usernameExists(String username) {
        return findByUsername(username) != null;
    }
    // --- Save reset token ---
    public boolean saveResetToken(String email, String token, Timestamp expiry) {
        String sql = "UPDATE users SET reset_token=?, reset_expiry=? WHERE email=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setTimestamp(2, expiry);
            ps.setString(3, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- Find by reset token ---
    public User findByResetToken(String token) {
        String sql = "SELECT * FROM users WHERE reset_token=? AND reset_expiry > NOW()";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // --- Clear reset token after use ---
    public boolean clearResetToken(int userId) {
        String sql = "UPDATE users SET reset_token=NULL, reset_expiry=NULL WHERE id=?";
        try (Connection c = DBConfig.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // --- ResultSet → User ---
    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setFullName(rs.getString("full_name"));
        u.setBio(rs.getString("bio"));
        u.setRole(rs.getString("role"));
        u.setLocked(rs.getBoolean("is_locked"));
        u.setFailedAttempts(rs.getInt("failed_attempts"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }
}
