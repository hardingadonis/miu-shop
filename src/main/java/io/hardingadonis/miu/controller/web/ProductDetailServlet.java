package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "product", urlPatterns = {"/product"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String IDStr = request.getParameter("id");

        try {
            int ID = Integer.parseInt(IDStr);

            Product product = Singleton.productDAO.get(ID);

            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/view/web/product.jsp").forward(request, response);

                return;
            }
        } catch (NumberFormatException ex) {
            System.err.println(ex.getMessage());
        }

        response.sendRedirect("home");
    }
}
