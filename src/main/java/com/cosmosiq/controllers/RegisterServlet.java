package com.cosmosiq.controllers;

import com.cosmosiq.service.AuthService;
import com.cosmosiq.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");

        // Validation
        if (!ValidationUtil.isValidFullName(fullName)) {
            setError(req, resp, "Full name must not contain numbers.", fullName, username, email);
            return;
        }
        if (!ValidationUtil.isValidUsername(username)) {
            setError(req, resp, "Username must be 3-30 characters, alphanumeric only.", fullName, username, email);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            setError(req, resp, "Please enter a valid email address.", fullName, username, email);
            return;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            setError(req, resp, "Password must be at least 8 characters with at least one letter and one digit.", fullName, username, email);
            return;
        }
        if (!password.equals(confirm)) {
            setError(req, resp, "Passwords do not match.", fullName, username, email);
            return;
        }

        String error = authService.register(username, email, password, fullName);
        if (error == null) {
            req.setAttribute("success", "Account created successfully. Please sign in.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        } else {
            setError(req, resp, error, fullName, username, email);
        }
    }

    private void setError(HttpServletRequest req, HttpServletResponse resp, String msg,
                           String fullName, String username, String email)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.setAttribute("fullName", fullName);
        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }
}
