package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "login", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/web/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = Singleton.userDAO.get(email);

        if (user != null && user.getHashedPassword().equals(Hash.SHA256(password)) && user.getStatus() == UserStatus.ACTIVATE) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("home");
            
            return;
        }

        String errorMsg = "Sai mật khẩu!";
        if (user != null && user.getStatus() == UserStatus.DEACTIVATE) {
            errorMsg = "Tài khoản đã bị khóa!";
        }
        if (user == null) {
            errorMsg = "Tài khoản không tồn tại!";
            email = null;
        }

        request.setAttribute("email", email);
        request.setAttribute("errorMsg", errorMsg);
        
        this.doGet(request, response);
    }
}
