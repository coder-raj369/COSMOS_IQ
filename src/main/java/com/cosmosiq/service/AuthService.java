package com.cosmosiq.service;

import com.cosmosiq.model.User;
import com.cosmosiq.model.UserDAO;
import com.cosmosiq.util.PasswordUtil;

/**
 * Business logic for authentication.
 * Handles login validation, account lockout, and registration.
 */
public class AuthService {

    private static final int MAX_FAILED_ATTEMPTS = 5;
    private final UserDAO userDAO = new UserDAO();

    /**
     * Attempt login. Returns the User on success, null on failure.
     * Handles failed-attempt counting and account locking.
     */
    public User login(String email, String password) {
        User user = userDAO.findByEmail(email);
        if (user == null) return null;

        // Check if account is locked
        if (user.isLocked()) return null;

        // Verify password
        if (PasswordUtil.verify(password, user.getPassword())) {
            // Success — reset counter
            userDAO.resetFailedAttempts(email);
            return user;
        } else {
            // Failure  increment counter
            userDAO.incrementFailedAttempts(email);
            user = userDAO.findByEmail(email); // refresh
            if (user != null && user.getFailedAttempts() >= MAX_FAILED_ATTEMPTS) {
                userDAO.lockAccount(email);
            }
            return null;
        }
    }

    /**
     * Register a new user. Returns error message or null on success.
     */
    public String register(String username, String email, String password, String fullName) {
        if (userDAO.emailExists(email)) {
            return "An account with this email already exists.";
        }
        if (userDAO.usernameExists(username)) {
            return "This username is already taken.";
        }
        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPassword(PasswordUtil.hash(password));
        user.setFullName(fullName != null ? fullName.trim() : username);
        user.setRole("member");

        if (userDAO.insert(user)) {
            return null; // success
        }
        return "Registration failed. Please try again.";
    }

    /**
     * Check if account is locked
     */
    public boolean isAccountLocked(String email) {
        User user = userDAO.findByEmail(email);
        return user != null && user.isLocked();
    }
}
