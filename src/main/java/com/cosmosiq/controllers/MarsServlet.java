package com.cosmosiq.controllers;

import com.cosmosiq.service.NasaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/mars")
public class MarsServlet extends HttpServlet {

    private final NasaService nasaService = new NasaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String rover  = req.getParameter("rover");
        String camera = req.getParameter("camera");

        List<Map<String, String>> photos;

        if (rover != null && !rover.isEmpty()) {
            // Specific rover selected — get 40 photos from that rover
            photos = nasaService.getMarsPhotosBySol(rover, camera);
        } else {
            // No rover selected — get mixed photos from all rovers
            photos = nasaService.getAllRoversPhotos(camera);
        }

        req.setAttribute("photos",         photos);
        req.setAttribute("selectedRover",  rover != null ? rover : "all");
        req.setAttribute("selectedCamera", camera);
        req.getRequestDispatcher("/WEB-INF/pages/mars.jsp").forward(req, resp);
    }
}