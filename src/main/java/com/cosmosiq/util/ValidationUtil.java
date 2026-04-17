package com.cosmosiq.util;

import java.util.regex.Pattern;

/**
 * Reusable validation helpers used by servlets when processing form input.
 */
public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[a-zA-Z0-9_]{3,30}$");

    /** Trim and check that a string is non-null and non-empty. */
    public static boolean isNotBlank(String s) {
        return s != null && !s.trim().isEmpty();
    }

    /** Standard email format check. */
    public static boolean isValidEmail(String email) {
        return isNotBlank(email) && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /** Username: 3–30 chars, alphanumeric + underscore. */
    public static boolean isValidUsername(String username) {
        return isNotBlank(username) && USERNAME_PATTERN.matcher(username.trim()).matches();
    }

    /** Password strength: minimum 8 chars, at least one letter and one digit. */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) return false;
        boolean hasLetter = false, hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isLetter(c)) hasLetter = true;
            if (Character.isDigit(c)) hasDigit = true;
        }
        return hasLetter && hasDigit;
    }

    /** Reject any string that contains numerical digits — for the "name" field. */
    public static boolean isValidFullName(String name) {
        if (!isNotBlank(name)) return false;
        for (char c : name.toCharArray()) {
            if (Character.isDigit(c)) return false;
        }
        return name.trim().length() >= 2;
    }
}
