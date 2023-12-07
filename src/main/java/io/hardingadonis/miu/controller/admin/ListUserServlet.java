package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.model.User;
import io.hardingadonis.miu.services.Singleton;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

@WebServlet(name = "ListUserServlet", urlPatterns = {"/listUser"})
public class ListUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/admin/list_user.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int ID = Integer.parseInt(request.getParameter("id"));

            Singleton.userDAO.delete(ID);

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Order canceled successfully");

            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());

            response.setStatus(HttpServletResponse.SC_OK);

        } catch (NumberFormatException ex) {
            System.err.println(ex.getMessage());
        }
    }
}
