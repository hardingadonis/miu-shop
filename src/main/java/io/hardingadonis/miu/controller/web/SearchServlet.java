package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    private static final int PRODUCTS_PER_PAGE = 3;
    private static final int PAGES_PER_GROUP = 3;
    private static final int MINIMUM_TWO_SIDE = 1;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String searchName = parseName(request);
        int categoryID = parseCategoryID(request);
        int endPage = (int) Math.ceil(Singleton.productDAO.countBySerach(searchName, categoryID) / (double) PRODUCTS_PER_PAGE);
        int currentPage = parsePage(request, endPage);

        List<Product> products = Singleton.productDAO.getBySearch(searchName, categoryID, (currentPage - 1) * PRODUCTS_PER_PAGE, PRODUCTS_PER_PAGE);
        String paginationStr = createPagination(searchName, categoryID, currentPage, endPage);

        request.setAttribute("products", products);
        request.setAttribute("end_page", endPage);
        request.setAttribute("pagination_str", paginationStr);

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

    private static String createPrevBtn(String searchName, int categoryID, int currentPage) {
        StringBuilder prevBtn = new StringBuilder("<a href=\"");

        if (currentPage > 1) {
            prevBtn.append("search?page=").append(currentPage - 1);

            if (categoryID > 0) {
                prevBtn.append("&category_id=").append(categoryID);
            }
            if (searchName != null) {
                prevBtn.append("&search-name=").append(searchName);
            }
        } else {
            prevBtn.append("#");
        }

        prevBtn.append("\">Trước</a>");

        return prevBtn.toString();
    }

    private static String createNextBtn(String searchName, int categoryID, int currentPage, int endPage) {
        StringBuilder nextBtn = new StringBuilder("<a href=\"");

        if (currentPage < endPage) {
            nextBtn.append("search?page=").append(currentPage + 1);
            if (categoryID > 0) {
                nextBtn.append("&category_id=").append(categoryID);
            }
            if (searchName != null) {
                nextBtn.append("&search-name=").append(searchName);
            }
        } else {
            nextBtn.append("#");
        }

        nextBtn.append("\">Sau</a>");

        return nextBtn.toString();
    }

    private static String createSingleIndex(String searchName, int categoryID, int currentPage, int index) {
        StringBuilder singleIndex = new StringBuilder("<a class=\"");

        singleIndex.append((currentPage == index) ? "page-current" : "");
        singleIndex.append("\" href=\"");

        singleIndex.append("search?page=").append(index);

        if (categoryID > 0) {
            singleIndex.append("&category_id=").append(categoryID);
        }

        if (searchName != null) {
            singleIndex.append("&search-name=").append(searchName);
        }

        singleIndex.append("\">").append(index).append("</a>");

        return singleIndex.toString();
    }

    private static String createNormalPagination(String searchName, int categoryID, int currentPage, int beginPage, int endPage) {
        StringBuilder normalPagination = new StringBuilder();

        for (int i = beginPage; i <= endPage; i++) {
            normalPagination.append(createSingleIndex(searchName, categoryID, currentPage, i));
        }

        return normalPagination.toString();
    }

    private static String createNormalPagination(String searchName, int categoryID, int currentPage, int endPage) {
        return createNormalPagination(searchName, categoryID, currentPage, 1, endPage);
    }

    private static String createManyPagination(String searchName, int categoryID, int currentPage, int endPage) {
        StringBuilder manyPagination = new StringBuilder();

        if (currentPage <= PAGES_PER_GROUP + MINIMUM_TWO_SIDE) {
            manyPagination.append(createNormalPagination(searchName, categoryID, currentPage, currentPage < 3 ? 3 : currentPage + 1));

            manyPagination.append("<span>...</span>");

            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, endPage));
        }

        if ((currentPage > PAGES_PER_GROUP + MINIMUM_TWO_SIDE) && (currentPage <= endPage - PAGES_PER_GROUP - MINIMUM_TWO_SIDE)) {
            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, 1));
            manyPagination.append("<span>...</span>");

            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, currentPage - 1));
            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, currentPage));
            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, currentPage + 1));

            manyPagination.append("<span>...</span>");
            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, endPage));
        }

        if (currentPage > endPage - PAGES_PER_GROUP - MINIMUM_TWO_SIDE) {
            manyPagination.append(createSingleIndex(searchName, categoryID, currentPage, 1));

            manyPagination.append("<span>...</span>");

            manyPagination.append(createNormalPagination(searchName, categoryID, currentPage, currentPage, endPage));

        }

        return manyPagination.toString();
    }

    private static String createPagination(String searchName, int categoryID, int currentPage, int endPage) {
        StringBuilder pagination = new StringBuilder();

        if (currentPage != 1) {
            pagination.append(createPrevBtn(searchName, categoryID, currentPage));
        }

        if (endPage < PAGES_PER_GROUP + (MINIMUM_TWO_SIDE + 1) * 2) {
            pagination.append(createNormalPagination(searchName, categoryID, currentPage, endPage));
        } else {
            pagination.append(createManyPagination(searchName, categoryID, currentPage, endPage));
        }

        if (currentPage != endPage) {
            pagination.append(createNextBtn(searchName, categoryID, currentPage, endPage));
        }

        return pagination.toString();
    }
}
