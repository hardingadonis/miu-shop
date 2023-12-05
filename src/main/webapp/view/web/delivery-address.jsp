<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/delivery-address.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Địa chỉ giao hàng</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5 my-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-sm-12 text-center">
                        <img src="./${sessionScope.user.avatarPath}" alt="Avatar" class="img-thumbnail rounded">
                        <h3 class="my-4">${sessionScope.user.fullName}</h3>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a href="profile" class="nav-link text-muted option">Thông tin chung</a>
                                <a href="delivery-address" class="nav-link text-muted option option-selected">Địa chỉ giao hàng</a>
                                <a href="purchase-history" class="nav-link text-muted option">Lịch sử mua hàng</a>
                                <a href="change-password" class="nav-link text-muted  option">Đổi mật khẩu</a>
                            </li>
                        </ul>
                    </div>

                    <div class="col-lg-9 col-sm-12">
                        <div class="container-fluid p-3 border border-dark">
                            <h6 class="m-3 text-center display-6">Địa chỉ giao hàng</h6>

                            <div class="px-5">
                                <c:if test="${sessionScope.user.address.size() > 0}">
                                    <table class="table py-3">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="col-10 text-center">Địa chỉ</th>
                                                <th scope="col" class="col-2 text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="address" items="${sessionScope.user.address}" varStatus="loop">
                                                <tr>
                                                    <td class="text-center">${address}</td>
                                                    <td class="text-center">
                                                        <form action="delivery-address" method="post">
                                                            <input type="hidden" name="index" value="${loop.index}">
                                                            <button class="btn btn-outline-danger">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>

                                <c:if test="${sessionScope.user.address.size() < 5}">
                                    <div class="text-center py-3">
                                        <a href="add-address" class="btn btn-outline-dark">
                                            <i class="fas fa-plus"></i>
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/deliveryAddressHandler.js"></script>
    </body>

</html>