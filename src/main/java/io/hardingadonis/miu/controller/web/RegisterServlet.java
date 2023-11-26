package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    private static final String REGISTER_SUCCESS_PARAM = "registerSuccess";
    private static final String MALE_AVATAR = "assets/images/avatars/male.webp";
    private static final String FEMALE_AVATAR = "assets/images/avatars/female.webp";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        request.getRequestDispatcher("/view/web/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String fullName = request.getParameter("full-name");
        int birthYear = Integer.parseInt(request.getParameter("birth-year"));
        UserGender gender = UserGender.create(request.getParameter("gender"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        User user = Singleton.userDAO.get(email);
        
        if (user == null) {
            user = new User();
            
            user.setFullName(fullName);
            user.setBirthYear(birthYear);
            user.setGender(gender);
            user.setEmail(email);
            user.setHashedPassword(Hash.SHA256(password));
            user.setAvatarPath(gender == UserGender.MALE ? MALE_AVATAR : FEMALE_AVATAR);
            user.setAddress(Collections.emptyList());
            user.setStatus(UserStatus.ACTIVATE);
            
            Singleton.userDAO.insert(user);
            
            Singleton.email.sendWelcomeEmail(user);
            
            response.sendRedirect("login?" + REGISTER_SUCCESS_PARAM + "=true");
        } else {
            String errorMsg = "Email đã tồn tại!";
            
            request.setAttribute("fullName", fullName);
            request.setAttribute("birthYear", birthYear);
            request.setAttribute("gender", gender.toString());
            request.setAttribute("email", email);
            request.setAttribute("errorMsg", errorMsg);
            
            this.doGet(request, response);
        }
    }
}
