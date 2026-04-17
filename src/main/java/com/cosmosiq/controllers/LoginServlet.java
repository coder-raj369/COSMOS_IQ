package com.cosmosiq.controllers;

import com.cosmosiq.model.User;
import com.cosmosiq.service.AuthService;
import com.cosmosiq.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (!ValidationUtil.isNotBlank(email) || !ValidationUtil.isNotBlank(password)) {
            req.setAttribute("error", "Please fill in all fields.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }

        // Check if locked
        if (authService.isAccountLocked(email)) {
            req.setAttribute("error", "Account is locked due to too many failed attempts. Contact an administrator.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }

        User user = authService.login(email.trim(), password);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Invalid credentials. Your account may be locked after 5 failed attempts.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}
