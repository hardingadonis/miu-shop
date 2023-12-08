package io.hardingadonis.miu.controller.admin;

import io.hardingadonis.miu.model.Product;
import io.hardingadonis.miu.services.Singleton;
import java.io.*;
import java.time.LocalDateTime;
import java.util.Collections;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AddNewProduct", urlPatterns = {"/admin/new-product"})
public class AddNewProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/admin/add-new-product.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String nameProduct = request.getParameter("productName");

        String productBrand = request.getParameter("productBrand");

        int Category_ID = Integer.parseInt(request.getParameter("productCategoryID"));

        String productOrigin = request.getParameter("productOrigin");

        String productExpiry = request.getParameter("productExpiry");

        String productWeight = request.getParameter("productWeight");

        String productPreservation = request.getParameter("productPreservation");

        long productPrice = Long.parseLong(request.getParameter("productPrice"));

        int productAmount = Integer.parseInt(request.getParameter("productAmount"));

        Product product = new Product();

        product.setName(nameProduct);
        product.setBrand(productBrand);
        product.setCategoryID(Category_ID);

        product.setOrigin(productOrigin);
        product.setExpiryDate(productExpiry);
        product.setWeight(productWeight);
        product.setPreservation(productPreservation);
        product.setPrice(productPrice);
        product.setAmount(productAmount);
        product.setThumbnail("");
        product.setImages(Collections.EMPTY_LIST);

        Singleton.productDAO.insert(product);
        response.sendRedirect(request.getContextPath()+ "/admin/product");
    }

}
