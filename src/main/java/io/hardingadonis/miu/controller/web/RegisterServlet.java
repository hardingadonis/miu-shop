package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.User;
import io.hardingadonis.miu.model.detail.UserGender;
import io.hardingadonis.miu.model.detail.UserStatus;
import io.hardingadonis.miu.services.Hash;
import io.hardingadonis.miu.services.Singleton;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "register", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/web/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

        
        System.out.println("Sex from request: " + sex);
        String defaultSex = "male"; 
        if (sex == null || sex.trim().isEmpty()) {
            sex = defaultSex; 
        }

        try {
            // Check if email already exists
            User existingUser = Singleton.userDAO.get(email);
            if (existingUser != null) {
                out.println("<h2>Email đã tồn tại, vui lòng sử dụng email khác.</h2>");
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

                out.println("Register Successfully!");
                response.sendRedirect("login?success=true");
            }
        } catch (Exception e) {
            out.println("Fail!");
            e.printStackTrace(out);
            out.println("Error: " + e.getMessage());
        }

        out.close();
    }
    private boolean isEmailExists(Connection connection, String email) throws SQLException {
        String query = "SELECT * FROM user WHERE email=?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            return preparedStatement.executeQuery().next();
        }
    }

}
