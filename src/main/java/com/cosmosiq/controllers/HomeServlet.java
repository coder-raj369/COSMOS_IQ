package com.cosmosiq.controllers;

import com.cosmosiq.model.*;
import com.cosmosiq.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
       

        try {
            req.setAttribute("favoritesCount", new FavoriteService().countUserFavorites(user.getId()));
        } catch (Exception e) {
            req.setAttribute("favoritesCount", 0);
        }

        try {
            req.setAttribute("aiFactsCount", new AiFactDAO().countAll());
        } catch (Exception e) {
            req.setAttribute("aiFactsCount", 0);
        }

        try {
            req.setAttribute("apod", new NasaService().getTodayApod());
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            List<Map<String, String>> asteroids = new NasaService().getNearEarthObjects();
            req.setAttribute("asteroidCount", asteroids.size());
            req.setAttribute("hazardousCount", asteroids.stream().filter(a -> "true".equals(a.get("hazardous"))).count());
        } catch (Exception e) {
            req.setAttribute("asteroidCount", 0);
            req.setAttribute("hazardousCount", 0);
        }

        try {
            req.setAttribute("featuredEvents", new SpaceEventDAO().findFeatured());
        } catch (Exception e) {
            req.setAttribute("featuredEvents", new ArrayList<>());
        }

        req.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(req, resp);
    }
}