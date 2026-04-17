package com.cosmosiq.filter;

import com.cosmosiq.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Restricts /admin/* URLs to users with role "admin".
 * Non-admins are redirected to /home.
 */
@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.isAdmin()) {
                chain.doFilter(request, response);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
