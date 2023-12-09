package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "LoginAdmin", urlPatterns = {"/admin/login"})
public class LoginAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.getRequestDispatcher("/view/admin/login-admin.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin ad = Singleton.adminDAO.get(username);

        if (ad != null && ad.getHashedPassword().equals(Hash.SHA256(password))) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", ad);
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String errorMsg = "Sai mật khẩu!";

        if (ad == null) {
            errorMsg = "Tài khoản không tồn tại!";
            username = null;
        }

        request.setAttribute("username", username);
        request.setAttribute("errorMsg", errorMsg);

        this.doGet(request, response);
    }

}
