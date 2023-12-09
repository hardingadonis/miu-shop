package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.simple.*;

@WebServlet(name = "ForgotChangePasswordServlet", urlPatterns = {"/forgot-change-password"})
public class ForgotChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user != null) {
            response.sendRedirect("home");
            return;
        }

        request.getRequestDispatcher("/view/web/forgot-change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = Singleton.userDAO.get(email);

            if (user != null) {
                user.setHashedPassword(Hash.SHA256(password));
                Singleton.userDAO.update(user);

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Change password successfully");

                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());

                response.setStatus(HttpServletResponse.SC_OK);
            }

        } catch (NumberFormatException ex) {
            System.err.println(ex.getMessage());
        }
    }
}
