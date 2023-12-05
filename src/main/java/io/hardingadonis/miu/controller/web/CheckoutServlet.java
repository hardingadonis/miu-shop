package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import io.hardingadonis.miu.services.vnpay.*;
import java.io.*;
import java.net.*;
import java.nio.charset.*;
import java.text.*;
import java.util.*;
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

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        String cartCookie = getCartCookie(request);
        long totalPrice = getTotalPrice(cartCookie);
        String address = request.getParameter("address");
        Payment payment = Payment.create(request.getParameter("payment"));

        Order order = new Order(user.getID(), address, totalPrice, payment, OrderStatus.PROCESSING);

        session.setAttribute("order", order);
        session.setAttribute("cart_cookie", cartCookie);

        if (payment == Payment.COD) {
            response.sendRedirect("checkout-success");
        } else {
            handleVNPayCheckout(request, response, (int) totalPrice);
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
        } catch (org.json.simple.parser.ParseException ex) {
            System.err.println(ex.getMessage());
        }

        return total;
    }

    private static void handleVNPayCheckout(HttpServletRequest request, HttpServletResponse response, int totalPrice)
            throws UnsupportedEncodingException, IOException {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String vnp_OrderInfo = "Miu Shop - Thanh toán đơn hàng";
        String orderType = "other";
        String vnp_TxnRef = VNPayConfig.getRandomNumber(8);
        String vnp_IpAddr = VNPayConfig.getIpAddress(request);
        String vnp_TmnCode = VNPayConfig.vnp_TmnCode;

        Map vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(totalPrice * 100));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_BankCode", "");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", getDomainWithPortAndContextPath(request) + VNPayConfig.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());

        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();

        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);

            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }

        String queryUrl = query.toString();
        String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;

        response.sendRedirect(paymentUrl);
    }

    private static String getDomainWithPortAndContextPath(HttpServletRequest request)
            throws MalformedURLException {
        return "http://" + new URL(request.getRequestURL().toString()).getHost() + ":" + request.getServerPort() + "/miu/";
    }
}
