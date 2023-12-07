package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "PurchaseHistoryDetailServlet", urlPatterns = {"/purchase-history-detail"})
public class PurchaseHistoryDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        int orderID = Integer.parseInt(request.getParameter("id"));

        User user = (User) session.getAttribute("user");
        Order order = Singleton.orderDAO.get(orderID);

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if (order.getUserID() != user.getID()) {
            response.sendRedirect("purchase-history?tab=all");
            return;
        }

        String createAtStr = Converter.convert(order.getCreateAt());
        Map<Product, Integer> orderData = new HashMap<>();

        Singleton.orderDataDAO.getAll(orderID).forEach((element) -> {
            Product product = Singleton.productDAO.get(element.getProductID());

            orderData.put(product, element.getAmount());
        });

        session.setAttribute("order", order);
        session.setAttribute("create_at_str", createAtStr);
        session.setAttribute("order_data", orderData);

        request.getRequestDispatcher("/view/web/purchase-history-detail.jsp").forward(request, response);
    }
}
