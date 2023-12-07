package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.dao.impl.mysql.CategoryDAOMySQLImpl;
import io.hardingadonis.miu.model.Category;
import io.hardingadonis.miu.services.Singleton;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CategoryManagement", urlPatterns = {"/categorymanagement"})
@MultipartConfig
public class CategoryManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/admin/category-management.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

    }

}
