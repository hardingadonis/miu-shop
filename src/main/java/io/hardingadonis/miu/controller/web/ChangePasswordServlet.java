package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {
    
    private static final String CHANGE_PASSWORD_SUCCESS_PARAM = "changePasswordSuccess";

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

        request.getRequestDispatcher("/view/web/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String hashedCurrentPassword = Hash.SHA256(request.getParameter("current-password"));
        String hashedNewPassword = Hash.SHA256(request.getParameter("new-password"));

        User user = (User) request.getSession().getAttribute("user");

        if (!user.getHashedPassword().equals(hashedCurrentPassword)) {
            request.setAttribute("error_msg", "Sai mật khẩu!");
        } else if (hashedCurrentPassword.equals(hashedNewPassword)) {
            request.setAttribute("error_msg", "Mật khẩu mới không được trùng với mật khẩu cũ!");
        } else {
            user.setHashedPassword(hashedNewPassword);
            Singleton.userDAO.update(user);
            
            request.getSession(false).invalidate();
            response.sendRedirect("login?" + CHANGE_PASSWORD_SUCCESS_PARAM + "=true");
            
            return;
        }

        this.doGet(request, response);
    }
}
