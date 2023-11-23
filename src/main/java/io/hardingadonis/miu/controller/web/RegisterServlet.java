package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.services.Hash;
import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "register", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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

        if (sex == null || sex.trim().isEmpty()) {
            sex = "Male"; // Giá trị mặc định
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/miu", "root", "");

            // Kiểm tra xem email đã tồn tại chưa
            if (isEmailExists(conn, email)) {
                out.println("<h2>Email đã tồn tại, vui lòng sử dụng email khác.</h2>");
            } else {
                // Thêm dữ liệu vào cơ sở dữ liệu
                String query = "INSERT INTO user (full_name, birth_year, gender, email, hashed_password, status) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    preparedStatement.setString(1, name);
                    preparedStatement.setInt(2, yob);
                    preparedStatement.setString(3, sex);
                    preparedStatement.setString(4, email);
                    preparedStatement.setString(5, Hash.SHA256(password)); // Băm mật khẩu trước khi lưu
                    preparedStatement.setString(6, "activate");

                    conn.setAutoCommit(true);

                    int rowsAffected = preparedStatement.executeUpdate();
                    System.out.println("Rows affected: " + rowsAffected);
                    if (rowsAffected > 0) {
                        out.println("Register Successfully!");
                        response.sendRedirect("login");
                    } else {
                        out.println("Register fail. Please try again!");
                    }
                }
            }

            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Fail!");
            e.printStackTrace(out);
            out.println("Database error: " + e.getMessage());
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
