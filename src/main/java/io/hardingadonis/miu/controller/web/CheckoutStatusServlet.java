package io.hardingadonis.miu.controller.web;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "CheckoutStatusServlet", urlPatterns = {"/checkout-status"})
public class CheckoutStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();

        if ((session.getAttribute("user") == null) || (session.getAttribute("order") == null) || (session.getAttribute("cart_cookie") == null)) {
            response.sendRedirect("home");
        }

        request.getRequestDispatcher("/view/web/checkout-success.jsp").forward(request, response);
    }
}
