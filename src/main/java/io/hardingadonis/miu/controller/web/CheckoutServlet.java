package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.simple.*;
import org.json.simple.parser.*;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

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

        long totalPrice = getTotalPrice(getCartCookie(request));

        request.setAttribute("total_price", totalPrice);

        request.getRequestDispatcher("/view/web/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        String cartCookie = getCartCookie(request);
        long totalPrice = getTotalPrice(cartCookie);
        String address = request.getParameter("address");
        Payment payment = Payment.create(request.getParameter("payment"));

        if (payment == Payment.COD) {
            Order order = new Order(user.getID(), address, totalPrice, payment, OrderStatus.PROCESSING);

            int id = Singleton.orderDAO.insert(order);

            moveCartToOrderData(id, cartCookie, response);

            response.sendRedirect("purchase-history");

            return;
        } else {
        }
    }

    private static String getCartCookie(HttpServletRequest request) {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("cart")) {
                return Hash.decodeURIComponent(cookie.getValue());
            }
        }

        return null;
    }

    private static long getTotalPrice(String cartData) {
        long total = 0;

        try {
            JSONObject data = (JSONObject) new JSONParser().parse(cartData);

            for (Object keyStr : data.keySet()) {
                Object valueStr = data.get(keyStr);
                int value = Integer.parseInt(valueStr.toString());
                int key = Integer.parseInt(keyStr.toString());

                Product product = Singleton.productDAO.get(key);
                total += product.getPrice() * value;
            }
        } catch (ParseException ex) {
            System.err.println(ex.getMessage());
        }

        return total;
    }

    private static void moveCartToOrderData(int id, String cartData, HttpServletResponse response) {
        try {
            JSONObject data = (JSONObject) new JSONParser().parse(cartData);

            for (Object keyStr : data.keySet()) {
                Object valueStr = data.get(keyStr);
                int value = Integer.parseInt(valueStr.toString());
                int key = Integer.parseInt(keyStr.toString());

                Singleton.orderDataDAO.insert(new OrderData(id, key, value));
                updateProductAmoutAferCheckout(key, value);
            }

            Cookie cookie = new Cookie("cart", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        } catch (ParseException ex) {
            System.err.println(ex.getMessage());
        }
    }

    private static void updateProductAmoutAferCheckout(int productID, int amount) {
        Product product = Singleton.productDAO.get(productID);
        product.setAmount(product.getAmount() - amount);

        Singleton.productDAO.update(product);
    }
}
