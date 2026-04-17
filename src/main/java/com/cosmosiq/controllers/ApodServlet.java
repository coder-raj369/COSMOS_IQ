package com.cosmosiq.controllers;

import com.cosmosiq.service.NasaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/apod")
public class ApodServlet extends HttpServlet {

    private final NasaService nasaService = new NasaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String date = req.getParameter("date");
        Map<String, String> apod = nasaService.getApod(date);
        req.setAttribute("apod", apod);
        req.setAttribute("selectedDate", date);
        req.getRequestDispatcher("/WEB-INF/pages/apod.jsp").forward(req, resp);
    }
}
