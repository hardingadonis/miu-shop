<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/home.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Trang chủ</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <div id="carousel_home" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000"
             data-bs-wrap="true">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="<%=request.getContextPath()%>/assets/images/banners/384db07758f20287b1a53cdeaf079b207cd4ca4adc64fc8330aae19b6cb4754c.jpg" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="<%=request.getContextPath()%>/assets/images/banners/6367b4f9a204df6f7f4ca3dd36c7b6fce1f51101e8bc9f59356a19301d84f625.jpg" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="<%=request.getContextPath()%>/assets/images/banners/08311df62a11bc7250b5f76d679a5831da62b7ef050f0b9ffbea60abc0369806.jpg" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="<%=request.getContextPath()%>/assets/images/banners/296dc69cb2e3bc78ec76fb1f4a84a1dbb8ffd92300d6d3746a32272e38f7e8e7.jpg" class="d-block w-100">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carousel_home" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carousel_home" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <div class="container position-relative text-center">
            <h2 class="display-6 py-5">
                Sản phẩm nổi bật
            </h2>

            <div class="my-5">
                <div class="row">
                    <c:forEach var="item" items="${Singleton.productDAO.getRandom(4)}">
                        <div class="col-lg-3 col-sm-6 m-0 product">
                            <div class="card m-4 product-detail">
                                <a href="product?id=${item.ID}">
                                    <img src="<%=request.getContextPath()%>/${item.thumbnail}" class="card-img-top">
                                </a>
                                <div class="card-body">
                                    <p class="card-text font-weight-bold">
                                        <a href="product?id=${item.ID}">${item.name}</a>
                                    </p>
                                    <span class="text-muted price">${item.price}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <a href="#" class="btn btn-outline-dark my-5">Tất cả sản phẩm</a>
        </div>
    </div>

    <%@include file="common/_footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/homeHandler.js"></script>
</body>

</html>