package com.cosmosiq.controllers;

import com.cosmosiq.model.User;
import com.cosmosiq.service.FavoriteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/favorites")
public class FavoriteServlet extends HttpServlet {

    private final FavoriteService favService = new FavoriteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String type = req.getParameter("type");
        String search = req.getParameter("search");

        if (search != null && !search.isEmpty()) {
            req.setAttribute("favorites", favService.searchFavorites(user.getId(), search));
            req.setAttribute("searchQuery", search);
        } else {
            req.setAttribute("favorites", favService.getUserFavorites(user.getId(), type));
        }
        req.setAttribute("activeFilter", type != null ? type : "all");
        req.setAttribute("totalCount", favService.countUserFavorites(user.getId()));
        req.getRequestDispatcher("/WEB-INF/pages/favorites.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        String action = req.getParameter("action");

        if ("save".equals(action)) {
            favService.saveFavorite(
                user.getId(),
                req.getParameter("type"),
                req.getParameter("title"),
                req.getParameter("description"),
                req.getParameter("imageUrl"),
                req.getParameter("sourceDate")
            );
        } else if ("delete".equals(action)) {
            int favId = Integer.parseInt(req.getParameter("favId"));
            favService.removeFavorite(favId, user.getId());
        }

        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/favorites");
    }
}
