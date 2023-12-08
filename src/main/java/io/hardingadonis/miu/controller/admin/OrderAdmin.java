package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.OrderStatus;
import io.hardingadonis.miu.services.Singleton;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

@WebServlet(name = "OrderAdmin", urlPatterns = {"/admin/order"})
public class OrderAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();

        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        request.getRequestDispatcher("/view/admin/order-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        OrderStatus orderStatus = OrderStatus.create(request.getParameter("status"));

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Order order = Singleton.orderDAO.get(id);

            if (order != null) {
                order.setStatus(orderStatus);

                Singleton.orderDAO.update(order);
            }
        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            
            return;
        }

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("status", "success");
        jsonResponse.put("message", "Status updated successfully");

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());

        response.setStatus(HttpServletResponse.SC_OK);
    }

}
