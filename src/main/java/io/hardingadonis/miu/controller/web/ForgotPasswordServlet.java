package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

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

        String code = request.getParameter("code");

        if ((code != null) && (code.equals((String) session.getAttribute("code")))) {
            session.removeAttribute("code");
        }

        request.getRequestDispatcher("/view/web/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter("email");

        User user = Singleton.userDAO.get(email);

        if (user != null) {
            String code = Hash.SHA256(email + System.currentTimeMillis());

            Singleton.email.sendForgotPasswordEmail(user, code, request);

            response.sendRedirect("forgot-password?sent=true");
            return;
        }

        String errorMsg = "Tài khoản không tồn tại!";

        request.setAttribute("errorMsg", errorMsg);

        this.doGet(request, response);
    }
}
