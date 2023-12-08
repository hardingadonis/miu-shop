package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.*;

@WebServlet(name = "CategoryAdmin", urlPatterns = {"/admin/category"})
public class CategoryAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();

        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        request.getRequestDispatcher("/view/admin/category-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            String name = request.getParameter("name");

            Category category = new Category(name);

            Singleton.categoryDAO.insert(category);

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Order canceled successfully");

            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());

            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }
    }
}
