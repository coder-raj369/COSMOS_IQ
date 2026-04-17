package com.cosmosiq.controllers;

import com.cosmosiq.service.NasaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/mars")
public class MarsServlet extends HttpServlet {

    private final NasaService nasaService = new NasaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String rover = req.getParameter("rover");
        if (rover == null || rover.isEmpty()) rover = "curiosity";
        String earthDate = req.getParameter("earth_date");
        String camera = req.getParameter("camera");

        List<Map<String, String>> photos = nasaService.getMarsPhotos(rover, earthDate, camera);
        req.setAttribute("photos", photos);
        req.setAttribute("selectedRover", rover);
        req.setAttribute("selectedDate", earthDate);
        req.setAttribute("selectedCamera", camera);
        req.getRequestDispatcher("/WEB-INF/pages/mars.jsp").forward(req, resp);
    }
}
