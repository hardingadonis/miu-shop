<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/search.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Tìm kiếm</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <div class="container position-relative text-center mt-5 mb-5">
            <div class="row">
                <div class="col-lg-3 text-start">
                    <h3>Danh mục sản phẩm</h3>
                    <ul class="nav flex-column">
                        <c:forEach var="category" items="${Singleton.categoryDAO.getAll()}">
                            <li class="nav-item">
                                <a href="search?category_id=${category.ID}" class="nav-link text-muted category ${category_id == category.ID ? "category-slected": ""}">${category.name}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="col-lg-9 justify-content-between">
                    <c:if test="${end_page > 0}">
                        <div class="row">
                            <c:forEach var="item" items="${requestScope.products}">
                                <div class="col-lg-4 col-sm-6 m-0 product" data-bs-placement="top" title="${item.name}">
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
                    </c:if>
                    <c:if test="${end_page == 0}">
                        <h3 class="m-5 p-5">Không tìm thấy kết quả nào</h3>
                    </c:if>
                </div>
            </div>

            <div class="m-5 p-5 pagination">
                <c:if test="${end_page > 1}">
                    ${pagination_str}
                </c:if>
            </div>

        </div>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/searchHandler.js"></script>
    </body>

</html>