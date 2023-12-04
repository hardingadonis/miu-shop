package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "DeliveryAddressServlet", urlPatterns = {"/delivery-address"})
public class DeliveryAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        request.getRequestDispatcher("/view/web/delivery-address.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
