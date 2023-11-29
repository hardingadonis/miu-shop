package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String cartDataStr = getCartCookie(request);

        request.getRequestDispatcher("/view/web/cart.jsp").forward(request, response);
    }

    private static String getCartCookie(HttpServletRequest request) {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("cart")) {
                return Hash.decodeURIComponent(cookie.getValue());
            }
        }

        return null;
    }
}
