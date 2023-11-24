package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "register", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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

        PrintWriter out = response.getWriter();

        /* Process*/
        String name = request.getParameter("name");
        int yob = Integer.parseInt(request.getParameter("yob"));
        String sex = request.getParameter("sex");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Check if email already exists
            User existingUser = Singleton.userDAO.get(email);
            if (existingUser != null) {
                response.sendRedirect("register?emailExist=true");
            } else {
                // Create a new user object
                User newUser = new User();
                newUser.setFullName(name);
                newUser.setBirthYear(yob);
                newUser.setGender(UserGender.create(sex));
                newUser.setEmail(email);
                newUser.setHashedPassword(Hash.SHA256(password));
                newUser.setStatus(UserStatus.ACTIVATE);

                // Insert the new user using the UserDAO
                Singleton.userDAO.insert(newUser);

                response.sendRedirect("login?registerSuccess=true");

            }
        } catch (Exception e) {
            out.println("Fail!");
            e.printStackTrace(out);
            out.println("Error: " + e.getMessage());
        }

        out.close();
    }
}
