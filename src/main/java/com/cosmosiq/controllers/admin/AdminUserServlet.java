package com.cosmosiq.controllers.admin;

import com.cosmosiq.model.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userDAO.findAll());
        req.getRequestDispatcher("/WEB-INF/pages/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        int userId = Integer.parseInt(req.getParameter("userId"));

        switch (action) {
            case "lock":   userDAO.toggleLock(userId, true); break;
            case "unlock": userDAO.toggleLock(userId, false); break;
            case "delete": userDAO.delete(userId); break;
            case "makeAdmin":  userDAO.updateRole(userId, "admin"); break;
            case "makeMember": userDAO.updateRole(userId, "member"); break;
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
