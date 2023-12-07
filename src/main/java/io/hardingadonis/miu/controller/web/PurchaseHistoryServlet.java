package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.simple.*;

@WebServlet(name = "PurchaseHistoryServlet", urlPatterns = {"/purchase-history"})
public class PurchaseHistoryServlet extends HttpServlet {

    private static final int ORDER_PER_PAGE = 5;
    private static final int PAGES_PER_GROUP = 3;
    private static final int MINIMUM_TWO_SIDE = 1;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");
        String tab = request.getParameter("tab");

        if ((user == null) || (tab == null)) {
            response.sendRedirect("login");
            return;
        }

        List<Order> orderList = null;
        int endPage = 0;
        int page = 0;

        switch (tab) {
            case "all": {
                endPage = (int) Math.ceil(Singleton.orderDAO.countByUserID(user.getID()) / (double) ORDER_PER_PAGE);
                page = parsePage(request, endPage);

                orderList = Singleton.orderDAO.getAllWithUserID(user.getID(), (page - 1) * ORDER_PER_PAGE, ORDER_PER_PAGE);
                break;
            }

            case "processing": {
                endPage = (int) Math.ceil(Singleton.orderDAO.countAllWithUserIDAndStatus(user.getID(), OrderStatus.PROCESSING) / (double) ORDER_PER_PAGE);
                page = parsePage(request, endPage);

                orderList = Singleton.orderDAO.getAllWithUserIDAndStatus(user.getID(), OrderStatus.PROCESSING, (page - 1) * ORDER_PER_PAGE, ORDER_PER_PAGE);
                break;
            }

            case "shipping": {
                endPage = (int) Math.ceil(Singleton.orderDAO.countAllWithUserIDAndStatus(user.getID(), OrderStatus.SHIPPING) / (double) ORDER_PER_PAGE);
                page = parsePage(request, endPage);

                orderList = Singleton.orderDAO.getAllWithUserIDAndStatus(user.getID(), OrderStatus.SHIPPING, (page - 1) * ORDER_PER_PAGE, ORDER_PER_PAGE);
                break;
            }

            case "done": {
                endPage = (int) Math.ceil(Singleton.orderDAO.countAllWithUserIDAndStatus(user.getID(), OrderStatus.DONE) / (double) ORDER_PER_PAGE);
                page = parsePage(request, endPage);

                orderList = Singleton.orderDAO.getAllWithUserIDAndStatus(user.getID(), OrderStatus.DONE, (page - 1) * ORDER_PER_PAGE, ORDER_PER_PAGE);
                break;
            }

            case "canceled": {
                endPage = (int) Math.ceil(Singleton.orderDAO.countAllWithUserIDAndStatus(user.getID(), OrderStatus.CANCELED) / (double) ORDER_PER_PAGE);
                page = parsePage(request, endPage);

                orderList = Singleton.orderDAO.getAllWithUserIDAndStatus(user.getID(), OrderStatus.CANCELED, (page - 1) * ORDER_PER_PAGE, ORDER_PER_PAGE);
                break;
            }
        }

        String paginationStr = createPagination(tab, page, endPage);

        request.setAttribute("order_list", orderList);
        request.setAttribute("pagination_str", paginationStr);
        request.setAttribute("end_page", endPage);
        
        request.getRequestDispatcher("/view/web/purchase-history.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int ID = Integer.parseInt(request.getParameter("id"));

            Order order = Singleton.orderDAO.get(ID);

            if (order != null) {
                order.setStatus(OrderStatus.CANCELED);
                Singleton.orderDAO.update(order);

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Order canceled successfully");

                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());

                response.setStatus(HttpServletResponse.SC_OK);
            }

        } catch (NumberFormatException ex) {
            System.err.println(ex.getMessage());
        }
    }

    private static int parsePage(HttpServletRequest request, int endPage) {
        try {
            int page = Integer.parseInt(request.getParameter("page"));

            if ((page < 1) || (page > endPage)) {
                page = 1;
            }

            return page;
        } catch (NumberFormatException ex) {
            return 1;
        }
    }

    private static String createPrevBtn(String tab, int page) {
        StringBuilder prevBtn = new StringBuilder("<a href=\"purchase-history?tab=").append(tab);

        prevBtn.append("&page=").append(page - 1);

        prevBtn.append("\">Trước</a>");

        return prevBtn.toString();
    }

    private static String createNextBtn(String tab, int page) {
        StringBuilder nextBtn = new StringBuilder("<a href=\"purchase-history?tab=").append(tab);

        nextBtn.append("&page=").append(page + 1);

        nextBtn.append("\">Sau</a>");

        return nextBtn.toString();
    }

    private static String createSingleIndex(String tab, int page, int index) {
        StringBuilder singleIndex = new StringBuilder("<a class=\"");

        singleIndex.append((page == index) ? "page-current" : "");
        singleIndex.append("\" href=\"");

        singleIndex.append("purchase-history?tab=").append(tab);

        singleIndex.append("&page=").append(index);

        singleIndex.append("\">").append(index).append("</a>");

        return singleIndex.toString();
    }

    private static String createNormalPagination(String tab, int page, int beginPage, int endPage) {
        StringBuilder normalPagination = new StringBuilder();

        for (int i = beginPage; i <= endPage; i++) {
            normalPagination.append(createSingleIndex(tab, page, i));
        }

        return normalPagination.toString();
    }

    private static String createNormalPagination(String tab, int page, int endPage) {
        return createNormalPagination(tab, page, 1, endPage);
    }

    private static String createManyPagination(String tab, int page, int endPage) {
        StringBuilder manyPagination = new StringBuilder();

        if (page <= PAGES_PER_GROUP + MINIMUM_TWO_SIDE) {
            manyPagination.append(createNormalPagination(tab, page, 1, page < 3 ? 3 : page + 1));

            manyPagination.append("<span>...</span>");

            manyPagination.append(createSingleIndex(tab, page, endPage));
        }

        if ((page > PAGES_PER_GROUP + MINIMUM_TWO_SIDE) && (page <= endPage - PAGES_PER_GROUP - MINIMUM_TWO_SIDE)) {
            manyPagination.append(createSingleIndex(tab, page, 1));
            manyPagination.append("<span>...</span>");

            manyPagination.append(createSingleIndex(tab, page, page - 1));
            manyPagination.append(createSingleIndex(tab, page, page));
            manyPagination.append(createSingleIndex(tab, page, page + 1));

            manyPagination.append("<span>...</span>");
            manyPagination.append(createSingleIndex(tab, page, endPage));
        }

        if (page > endPage - PAGES_PER_GROUP - MINIMUM_TWO_SIDE) {
            manyPagination.append(createSingleIndex(tab, page, 1));

            manyPagination.append("<span>...</span>");

            manyPagination.append(createNormalPagination(tab, page, page - 1, endPage));

        }

        return manyPagination.toString();
    }

    private static String createPagination(String tab, int page, int endPage) {
        StringBuilder pagination = new StringBuilder();

        if (page != 1) {
            pagination.append(createPrevBtn(tab, page));
        }

        if (endPage < PAGES_PER_GROUP + (MINIMUM_TWO_SIDE + 1) * 2) {
            pagination.append(createNormalPagination(tab, page, endPage));
        } else {
            pagination.append(createManyPagination(tab, page, endPage));
        }

        if (page != endPage) {
            pagination.append(createNextBtn(tab, page));
        }

        return pagination.toString();
    }
}
