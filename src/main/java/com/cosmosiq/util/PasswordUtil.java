package com.cosmosiq.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Thin wrapper around jBCrypt for password hashing and verification.
 * BCrypt automatically salts and uses an adaptive cost factor.
 */
public class PasswordUtil {

    /** Cost factor: higher = more secure but slower. 10 is the standard default. */
    private static final int COST = 10;

    /** Hash a plaintext password for storage. */
    public static String hash(String plaintext) {
        return BCrypt.hashpw(plaintext, BCrypt.gensalt(COST));
    }

    /** Check a plaintext password against a stored BCrypt hash. */
    public static boolean verify(String plaintext, String storedHash) {
        if (plaintext == null || storedHash == null || storedHash.isEmpty()) {
            return false;
        }
        try {
            return BCrypt.checkpw(plaintext, storedHash);
        } catch (IllegalArgumentException e) {
            // Stored hash is malformed
            return false;
        }
    }
}
