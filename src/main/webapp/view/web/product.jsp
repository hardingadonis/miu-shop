<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="io.hardingadonis.miu.services.Singleton" %>
<%@page import="io.hardingadonis.miu.model.Category"%>
<%@page import="io.hardingadonis.miu.model.Product"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightslider/1.1.6/css/lightslider.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/product.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>${requestScope.product.name}</title>
    </head>
    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5">
            <div class="container">
                <div class="row gx-5">

                    <aside class="col-lg-6 pt-5">
                        <div class="vrmedia-gallery">
                            <ul class="ecommerce-gallery">
                                <c:forEach var="image" items="${requestScope.product.images}">
                                    <li data-fancybox="gallery" data-src="<%=request.getContextPath()%>/${image}" data-thumb="<%=request.getContextPath()%>/${image}" data-src="<%=request.getContextPath()%>/${image}">
                                        <img src="<%=request.getContextPath()%>/${image}">
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </aside>

                    <main class="col-lg-6 pt-5">
                        <div class="ps-lg-3">
                            <h4 class="title text-dark">
                                ${requestScope.product.name}
                            </h4>
                            <div id="product-id" hidden>${requestScope.product.ID}</div>
                            <span class="text-dark">
                                <%
                                    int categoryID = ((Product) request.getAttribute("product")).getCategoryID();
                                    Category category = Singleton.categoryDAO.get(categoryID);
                                %>
                                <a href="search?category_id=<%=categoryID%>"><%=category.getName()%></a>
                            </span>

                            <div class="my-2">
                                <span class="h5 price">${requestScope.product.price}</span>
                                <span class="text-muted"> / Sản phẩm</span>
                            </div>

                            <br/>

                            <div class="row">
                                <dt class="col-5">Xuất xứ:</dt>
                                <dd class="col-7">${requestScope.product.origin}</dd>

                                <dt class="col-5">Hạn sử dụng:</dt>
                                <dd class="col-7">${requestScope.product.expiryDate}</dd>

                                <dt class="col-5">Trọng lượng / Dung tích:</dt>
                                <dd class="col-7">${requestScope.product.weight}</dd>

                                <dt class="col-5">Cách bảo quản:</dt>
                                <dd class="col-7">${requestScope.product.preservation}</dd>

                                <dt class="col-5">Số lượng còn lại:</dt>
                                <dd class="col-7">${requestScope.product.amount} Sản phẩm</dd>
                            </div>

                            <hr/>

                            <div class="mt-5">
                                <h6 class="mb-3">Số lượng</h6>
                                <div id="max-amount" hidden>${requestScope.product.amount}</div>
                                <div class="row">
                                    <div class="col-4">
                                        <div class="input-group mb-3 d-flex justify-content-center">
                                            <button class="btn btn-white border px-3" onclick="decreaseQuantity()" type="button" id="button-addon1" data-mdb-ripple-color="dark">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                            <input type="text" class="form-control text-center" id="quantity" value="1" pattern="[0-9]*" inputmode="numeric">
                                            <button class="btn btn-white border px-3" onclick="increaseQuantity()" type="button" id="button-addon2" data-mdb-ripple-color="dark">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-8">
                                        <button class="btn btn-dark" onclick="addToCart()" ${requestScope.product.amount > 0 ? '' : 'disabled'}> <i class="me-1 fa fa-shopping-basket"> </i>Thêm vào giỏ hàng</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
        </section>

        <div class="container position-relative text-center">
            <h2 class="display-6 py-5 text-center">
                Có thể bạn sẽ thích
            </h2>

            <div class="my-5">
                <div class="row">
                    <c:forEach var="item" items="${Singleton.productDAO.getRandom(4)}">
                        <div class="col-lg-3 col-sm-6 m-0 product" data-bs-placement="top" title="${item.name}">
                            <div class="card m-4 product-detail">
                                <a href="product?id=${item.ID}">
                                    <img src="<%=request.getContextPath()%>/${item.thumbnail}" class="card-img-top">
                                </a>
                                <div class="card-body">
                                    <p class="card-text font-weight-bold">
                                        <a href="product?id=${item.ID}" class="product-name">${item.name}</a>
                                    </p>
                                    <span class="text-muted price">${item.price}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/lightslider/1.1.6/js/lightslider.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/productHandler.js"></script>
    </body>
</html>
