package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.User;
import io.hardingadonis.miu.model.detail.*;
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

        User user = (User) session.getAttribute("user");

        if ((user != null) && (user.getStatus() == UserStatus.DEACTIVATE)) {
            response.sendRedirect("verify");
            return;
        }

        if ((user == null) || (session.getAttribute("order") == null) || (session.getAttribute("cart_cookie") == null)) {
            response.sendRedirect("home");
            return;
        }

        request.getRequestDispatcher("/view/web/checkout-status.jsp").forward(request, response);
    }
}
