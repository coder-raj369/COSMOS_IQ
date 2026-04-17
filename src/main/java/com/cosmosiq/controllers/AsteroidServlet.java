package com.cosmosiq.controllers;

import com.cosmosiq.service.NasaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/asteroids")
public class AsteroidServlet extends HttpServlet {

    private final NasaService nasaService = new NasaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Map<String, String>> asteroids = nasaService.getNearEarthObjects();
        req.setAttribute("asteroids", asteroids);
        long hazCount = asteroids.stream().filter(a -> "true".equals(a.get("hazardous"))).count();
        req.setAttribute("totalCount", asteroids.size());
        req.setAttribute("hazardousCount", hazCount);
        req.getRequestDispatcher("/WEB-INF/pages/asteroids.jsp").forward(req, resp);
    }
}
