<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/purchase-history-detail.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Chi tiết đơn hàng</title>
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
                                <a href="delivery-address" class="nav-link text-muted option">Địa chỉ giao hàng</a>
                                <a href="purchase-history?tab=all" class="nav-link text-muted option option-selected">Lịch sử mua hàng</a>
                                <a href="change-password" class="nav-link text-muted  option">Đổi mật khẩu</a>
                            </li>
                        </ul>
                    </div>

                    <div class="col-lg-9 col-sm-12">
                        <div class="container-fluid p-3 border border-dark">
                            <h6 class="m-3 text-center display-6">Chi tiết đơn hàng</h6>

                            <div class="p-5">
                                <div class="row">
                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">Thanh toán:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${order.payment.toString() eq 'cod'}">
                                                            Thanh toán khi nhận hàng
                                                        </c:when>
                                                        <c:when test="${order.payment.toString() eq 'vnpay'}">
                                                            Thanh toán bằng VNPAY
                                                        </c:when>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">Trạng thái:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${order.status.toString() eq 'processing'}">
                                                            Đang xử lý
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'shipping'}">
                                                            Đang vận chuyển
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'done'}">
                                                            Hoàn thành
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'canceled'}">
                                                            Đã hủy
                                                        </c:when>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">Ngày đặt hàng:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p>${create_at_str}</p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4 col-sm-12">
                                                <p class="fw-bold">Tổng tiền:</p>
                                            </div>
                                            <div class="col-lg-8 col-sm-12">
                                                <p class="price">${order.totalPrice}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2 col-sm-12">
                                            <p class="fw-bold">Địa chỉ:</p>
                                        </div>
                                        <div class="col-lg-10 col-sm-12">
                                            <p>${order.address}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-lg-12 col-sm-12">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th scope="col" class="col-1 text-center">#</th>
                                                    <th scope="col" class="col-5 text-center">Sản phẩm</th>
                                                    <th scope="col" class="col-2 text-center">Đơn giá</th>
                                                    <th scope="col" class="col-2 text-center">Số lượng</th>
                                                    <th scope="col" class="col-2 text-center">Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="entry" items="${order_data}" varStatus="loop">
                                                    <tr>
                                                        <td class="align-middle text-center">${loop.index + 1}</td>
                                                        <td class="align-middle text-center">
                                                            <div class="product product-name">
                                                                <a href="product?id=${entry.key.ID}">
                                                                    ${entry.key.name}
                                                                </a></div>
                                                        </td>
                                                        <td class="align-middle text-center price">${entry.key.price}</td>
                                                        <td class="align-middle text-center">${entry.value}</td>
                                                        <td class="align-middle text-center price">${entry.key.price * entry.value}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <c:if test="${order.status.toString() eq 'processing'}">
                                    <div class="row mt-4">
                                        <div class="col-lg-12 col-sm-12">
                                            <div class="d-flex justify-content-center">
                                                <button type="button" class="btn btn-danger" onclick="handleDeletePurchaseHistory(${order.ID})"><i class="fas fa-ban"></i> Hủy đơn hàng</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/purchaseHistoryHandler.js"></script>
    </body>
</html>