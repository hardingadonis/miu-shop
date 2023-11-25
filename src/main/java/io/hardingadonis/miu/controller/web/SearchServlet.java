package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "search", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    private static final int PRODUCTS_PER_PAGE = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String searchName = parseName(request);
        int categoryID = parseCategoryID(request);
        int endPage = (int) Math.ceil(Singleton.productDAO.countBySerach(searchName, categoryID) / (double) PRODUCTS_PER_PAGE);
        int page = parsePage(request, endPage);

        List<Product> products = Singleton.productDAO.getBySearch(searchName, categoryID, (page - 1) * PRODUCTS_PER_PAGE, PRODUCTS_PER_PAGE);

        request.setAttribute("search_name", searchName);
        request.setAttribute("category_id", categoryID);
        request.setAttribute("current_page", page);
        request.setAttribute("end_page", endPage);
        request.setAttribute("products", products);

        request.getRequestDispatcher("/view/web/search.jsp").forward(request, response);
    }

    private static String parseName(HttpServletRequest request) {
        String searchName = request.getParameter("search-name");

        if ((searchName != null) && (searchName.isEmpty())) {
            searchName = null;
        }

        return searchName;
    }

    private static int parseCategoryID(HttpServletRequest request) {
        try {
            int category_id = Integer.parseInt(request.getParameter("category_id"));

            if ((category_id < 0) || (category_id > Singleton.categoryDAO.count())) {
                category_id = 0;
            }

            return category_id;
        } catch (NumberFormatException ex) {
            return 0;
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
}
