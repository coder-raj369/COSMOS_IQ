package com.cosmosiq.controllers.admin;

import com.cosmosiq.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/admin/events")
public class AdminEventServlet extends HttpServlet {

    private final SpaceEventDAO eventDAO = new SpaceEventDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("events", eventDAO.findAll());
        req.getRequestDispatcher("/WEB-INF/pages/admin/events.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        User admin = (User) req.getSession().getAttribute("user");

        if ("create".equals(action) || "update".equals(action)) {
            SpaceEvent e = new SpaceEvent();
            if ("update".equals(action)) e.setId(Integer.parseInt(req.getParameter("eventId")));
            e.setTitle(req.getParameter("title"));
            e.setEventDate(Date.valueOf(req.getParameter("eventDate")));
            e.setDescription(req.getParameter("description"));
            e.setType(req.getParameter("type"));
            e.setImageUrl(req.getParameter("imageUrl"));
            e.setFeatured(req.getParameter("featured") != null);
            e.setCreatedBy(admin.getId());

            if ("create".equals(action)) eventDAO.insert(e);
            else eventDAO.update(e);
        } else if ("delete".equals(action)) {
            eventDAO.delete(Integer.parseInt(req.getParameter("eventId")));
        }
        resp.sendRedirect(req.getContextPath() + "/admin/events");
    }
}
