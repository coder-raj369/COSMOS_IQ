package com.cosmosiq.controllers;

import com.cosmosiq.model.ContactMessage;
import com.cosmosiq.model.ContactMessageDAO;
import com.cosmosiq.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactMessageDAO messageDAO = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        if (!ValidationUtil.isNotBlank(name) || !ValidationUtil.isValidEmail(email)
                || !ValidationUtil.isNotBlank(subject) || !ValidationUtil.isNotBlank(message)) {
            req.setAttribute("error", "Please fill in all fields with valid data.");
            req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
            return;
        }

        ContactMessage msg = new ContactMessage();
        msg.setName(name.trim());
        msg.setEmail(email.trim());
        msg.setSubject(subject);
        msg.setMessage(message.trim());

        if (messageDAO.insert(msg)) {
            req.setAttribute("sent", true);
        } else {
            req.setAttribute("error", "Failed to send message. Try again.");
        }
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }
}
