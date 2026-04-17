package com.cosmosiq.config;

import com.cosmosiq.model.User;
import com.cosmosiq.model.UserDAO;
import com.cosmosiq.util.PasswordUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Runs once when the app starts.
 * Ensures a default admin account exists with a properly hashed password.
 */
@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("==============================================");
        System.out.println("  CosmosIQ is starting up...");
        System.out.println("==============================================");

        UserDAO userDAO = new UserDAO();

        // Create default admin if none exists
        if (!userDAO.emailExists("admin@cosmosiq.io")) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setEmail("admin@cosmosiq.io");
            admin.setPassword(PasswordUtil.hash("Admin@123"));
            admin.setFullName("Mission Commander");
            admin.setRole("admin");
            if (userDAO.insert(admin)) {
                System.out.println("  [OK] Default admin created: admin@cosmosiq.io / Admin@123");
            } else {
                System.out.println("  [WARN] Could not create default admin. Check DB connection.");
            }
        } else {
            System.out.println("  [OK] Admin account already exists.");
        }

        System.out.println("  [OK] CosmosIQ ready.");
        System.out.println("==============================================");
    }
}
