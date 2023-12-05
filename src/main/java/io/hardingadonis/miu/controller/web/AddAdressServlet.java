package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "AddAdressServlet", urlPatterns = {"/add-address"})
public class AddAdressServlet extends HttpServlet {

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
        
        if (user.getAddress().size() >= 5) {
            response.sendRedirect("delivery-address");
            return;
        }

        request.getRequestDispatcher("/view/web/add-address.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String specific = request.getParameter("specific");
        String receiver = request.getParameter("receiver");
        String phone = request.getParameter("phone");

        String newAddress = phone + ", " + receiver + ", " + specific + ", " + ward + ", " + district + ", " + city;
        
        user.getAddress().add(newAddress);
        Singleton.userDAO.update(user);
        
        response.sendRedirect("delivery-address");
    }
}
