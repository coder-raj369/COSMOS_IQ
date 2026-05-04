package com.cosmosiq.controllers;

import com.cosmosiq.util.HttpUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/iss", "/iss/*"})
public class ISSServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if ("/crew".equals(pathInfo)) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.setHeader("Cache-Control", "no-cache");
            try {
                String json = HttpUtil.get("http://api.open-notify.org/astros.json");
                resp.getWriter().write(json);
            } catch (Exception e) {
                resp.getWriter().write("{\"people\":[],\"number\":0}");
            }
        } else {
            req.getRequestDispatcher("/WEB-INF/pages/iss.jsp").forward(req, resp);
        }
    }
}
