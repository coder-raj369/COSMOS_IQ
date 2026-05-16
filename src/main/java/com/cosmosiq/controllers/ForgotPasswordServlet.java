package com.cosmosiq.controllers;

import com.cosmosiq.config.DBConfig;
import com.cosmosiq.model.User;
import com.cosmosiq.model.UserDAO;
import com.cosmosiq.util.PasswordUtil;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        if (token != null) {
            User user = userDAO.findByResetToken(token);
            if (user == null) {
                req.setAttribute("error", "Reset link is invalid or has expired. Please request a new one.");
                req.setAttribute("step", "request");
            } else {
                req.setAttribute("token", token);
                req.setAttribute("step", "reset");
            }
        } else {
            req.setAttribute("step", "request");
        }
        req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String step = req.getParameter("step");

        if ("request".equals(step)) {
            String email = req.getParameter("email");

            User user = userDAO.findByEmail(email);
            if (user == null) {
                // Don't reveal if email exists
                req.setAttribute("success", "If that email is registered, a reset link has been sent to it.");
                req.setAttribute("step", "request");
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
                return;
            }

            // Generate token — 1 hour expiry
            String token = UUID.randomUUID().toString().replace("-", "");
            Timestamp expiry = new Timestamp(System.currentTimeMillis() + 60 * 60 * 1000);
            userDAO.saveResetToken(email, token, expiry);

            String resetLink = req.getScheme() + "://" + req.getServerName() + ":"
                             + req.getServerPort() + req.getContextPath()
                             + "/forgot-password?token=" + token;

            boolean sent = sendResetEmail(email, user.getFullName(), resetLink);

            if (sent) {
                req.setAttribute("success", "A password reset link has been sent to " + email + ". Check your inbox.");
            } else {
                req.setAttribute("error", "Failed to send email. Please try again later.");
            }
            req.setAttribute("step", "request");
            req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);

        } else if ("reset".equals(step)) {
        	String token = req.getParameter("token");
            String newPassword = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Passwords do not match.");
                req.setAttribute("token", token);
                req.setAttribute("step", "reset");
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
                return;
            }
            if (newPassword.length() < 6) {
                req.setAttribute("error", "Password must be at least 6 characters.");
                req.setAttribute("token", token);
                req.setAttribute("step", "reset");
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
                return;
            }

            User user = userDAO.findByResetToken(token);

            if (user == null || user.getResetExpiry() == null) {
                req.setAttribute("error", "Reset link is invalid or expired.");
                req.setAttribute("step", "request");
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
                return;
            }

            if (user.getResetExpiry().before(new Timestamp(System.currentTimeMillis()))) {
                req.setAttribute("error", "Reset link is expired.");
                req.setAttribute("step", "request");
                req.getRequestDispatcher("/WEB-INF/pages/forgotpassword.jsp").forward(req, resp);
                return;
            }

            userDAO.updatePassword(user.getId(), PasswordUtil.hash(newPassword));
            userDAO.clearResetToken(user.getId());
            userDAO.resetFailedAttempts(user.getEmail());

            resp.sendRedirect(req.getContextPath() + "/login?success=Password+reset+successfully.+Please+log+in.");
        }
    }

    private boolean sendResetEmail(String toEmail, String name, String resetLink) {
        final String fromEmail = DBConfig.SMTP_EMAIL;
        final String password  = DBConfig.SMTP_PASSWORD;

        Properties props = new Properties();
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            String displayName = (name != null && !name.isEmpty()) ? name : "Explorer";
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "CosmosIQ"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("CosmosIQ — Password Reset Request");
            message.setContent(buildEmailHtml(displayName, resetLink), "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String buildEmailHtml(String name, String resetLink) {
        return "<!DOCTYPE html><html><body style='margin:0;padding:0;background:#050510;font-family:sans-serif'>"
             + "<div style='max-width:520px;margin:40px auto;background:#0d0f1f;border:1px solid rgba(109,221,255,0.15);border-radius:16px;overflow:hidden'>"
             + "<div style='padding:40px;text-align:center;border-bottom:1px solid rgba(255,255,255,0.05)'>"
             + "<h1 style='color:#fff;font-size:32px;font-style:italic;margin:0'>CosmosIQ</h1>"
             + "<p style='color:#6dddff;font-size:10px;letter-spacing:4px;text-transform:uppercase;margin:8px 0 0'>Password Recovery</p>"
             + "</div>"
             + "<div style='padding:40px'>"
             + "<p style='color:#f1effb;font-size:15px;margin:0 0 12px'>Hello, " + name + "</p>"
             + "<p style='color:#a0a0b0;font-size:14px;line-height:1.6;margin:0 0 32px'>We received a request to reset your CosmosIQ password. Click the button below to set a new password. This link expires in <strong style='color:#f1effb'>1 hour</strong>.</p>"
             + "<div style='text-align:center;margin:32px 0'>"
             + "<a href='" + resetLink + "' style='display:inline-block;background:#6dddff;color:#050510;font-size:12px;font-weight:700;letter-spacing:3px;text-transform:uppercase;text-decoration:none;padding:16px 40px;border-radius:4px'>Reset Password</a>"
             + "</div>"
             + "<p style='color:#555;font-size:12px;margin:32px 0 0'>If you didn't request this, ignore this email — your account is safe.</p>"
             + "</div>"
             + "<div style='padding:24px 40px;border-top:1px solid rgba(255,255,255,0.05);text-align:center'>"
             + "<p style='color:#333;font-size:11px;margin:0'>CosmosIQ · NASA Space Explorer · " + new java.util.Date().getYear() + 1900 + "</p>"
             + "</div>"
             + "</div></body></html>";
    }
}