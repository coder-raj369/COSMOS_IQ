package com.cosmosiq.controllers;

import com.cosmosiq.model.User;
import com.cosmosiq.model.UserDAO;
import com.cosmosiq.util.PasswordUtil;
import com.cosmosiq.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String action = req.getParameter("action");

        if ("updateProfile".equals(action)) {
            user.setFullName(req.getParameter("fullName"));
            user.setUsername(req.getParameter("username"));
            user.setEmail(req.getParameter("email"));
            user.setBio(req.getParameter("bio"));
            if (userDAO.updateProfile(user)) {
                req.getSession().setAttribute("user", userDAO.findById(user.getId()));
                req.setAttribute("success", "Profile updated successfully.");
            } else {
                req.setAttribute("error", "Failed to update profile.");
            }
        } else if ("changePassword".equals(action)) {
            String current = req.getParameter("currentPassword");
            String newPw = req.getParameter("newPassword");
            String confirm = req.getParameter("confirmPassword");

            if (!PasswordUtil.verify(current, user.getPassword())) {
                req.setAttribute("error", "Current password is incorrect.");
            } else if (!ValidationUtil.isValidPassword(newPw)) {
                req.setAttribute("error", "New password must be at least 8 characters with a letter and digit.");
            } else if (!newPw.equals(confirm)) {
                req.setAttribute("error", "New passwords do not match.");
            } else {
                userDAO.updatePassword(user.getId(), PasswordUtil.hash(newPw));
                req.getSession().setAttribute("user", userDAO.findById(user.getId()));
                req.setAttribute("success", "Password changed successfully.");
            }
        }
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
    }
}
