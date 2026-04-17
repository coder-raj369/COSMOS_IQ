package com.cosmosiq.controllers.admin;

import com.cosmosiq.model.ContactMessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/messages")
public class AdminMessageServlet extends HttpServlet {

    private final ContactMessageDAO msgDAO = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("messages", msgDAO.findAll());
        String selectedId = req.getParameter("id");
        if (selectedId != null) {
            int id = Integer.parseInt(selectedId);
            req.setAttribute("selectedMessage", msgDAO.findById(id));
            msgDAO.markRead(id);
        }
        req.getRequestDispatcher("/WEB-INF/pages/admin/messages.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        int id = Integer.parseInt(req.getParameter("msgId"));
        if ("delete".equals(action)) msgDAO.delete(id);
        else if ("markRead".equals(action)) msgDAO.markRead(id);
        resp.sendRedirect(req.getContextPath() + "/admin/messages");
    }
}
