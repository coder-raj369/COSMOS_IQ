package com.cosmosiq.controllers.admin;

import com.cosmosiq.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        FavoriteDAO favDAO = new FavoriteDAO();
//        AiFactDAO aiDAO = new AiFactDAO();
        ContactMessageDAO msgDAO = new ContactMessageDAO();

        req.setAttribute("totalUsers", userDAO.countAll());
        req.setAttribute("totalFavorites", favDAO.countAll());
        req.setAttribute("unreadMessages", msgDAO.countUnread());
        req.setAttribute("allUsers", userDAO.findAll());

        req.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(req, resp);
    }
}
