package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.services.Singleton;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

@WebServlet(name = "ProductManagement", urlPatterns = {"/productmanagement"})
public class ProductManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/admin/product-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle form submission here
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int ID = Integer.parseInt(request.getParameter("id"));

            Singleton.productDAO.delete(ID);

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "User canceled successfully");

            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());

            response.setStatus(HttpServletResponse.SC_OK);

        } catch (NumberFormatException ex) {
            System.err.println(ex.getMessage());
        }
    }

}
