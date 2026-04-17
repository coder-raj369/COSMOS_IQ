package com.cosmosiq.service;

import com.cosmosiq.model.Favorite;
import com.cosmosiq.model.FavoriteDAO;
import java.util.List;

public class FavoriteService {

    private final FavoriteDAO favoriteDAO = new FavoriteDAO();

    public boolean saveFavorite(int userId, String type, String title, String description, String imageUrl, String sourceDate) {
        // Prevent duplicates
        if (favoriteDAO.exists(userId, type, title)) return false;
        Favorite f = new Favorite();
        f.setUserId(userId);
        f.setType(type);
        f.setTitle(title);
        f.setDescription(description);
        f.setImageUrl(imageUrl);
        f.setSourceDate(sourceDate);
        return favoriteDAO.insert(f);
    }

    public boolean removeFavorite(int favId, int userId) {
        return favoriteDAO.delete(favId, userId);
    }

    public List<Favorite> getUserFavorites(int userId, String typeFilter) {
        if (typeFilter != null && !typeFilter.isEmpty() && !"all".equalsIgnoreCase(typeFilter)) {
            return favoriteDAO.findByUserAndType(userId, typeFilter);
        }
        return favoriteDAO.findByUser(userId);
    }

    public List<Favorite> searchFavorites(int userId, String query) {
        return favoriteDAO.searchByUser(userId, query);
    }

    public int countUserFavorites(int userId) {
        return favoriteDAO.countByUser(userId);
    }
}
