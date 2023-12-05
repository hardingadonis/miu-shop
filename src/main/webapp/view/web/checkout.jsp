<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Thanh toán</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <div class="container">
            <div class="py-5 my-5">
                <div class="container">
                    <h6 class="display-6 mb-4 d-flex justify-content-center">
                        Thanh toán giỏ hàng
                    </h6>
                </div>

                <div class="px-5 m-5 border border-dark">
                    <form action="checkout" method="post" class="px-5">
                        <div class="mt-5">
                            <div class="d-flex justify-content-start align-items-center mx-5 my-3">
                                <h6 class="display-6 me-3">Tổng tiền:</h6>
                                <h6 class="display-6 price" id="total-price">${total_price}</h6>
                            </div>

                            <div class="justify-content-start align-items-center mx-5 my-3">
                                <label for="address" class="form-label">Địa chỉ giao hàng</label>
                                <select id="address" name="address" class="form-select" required>
                                    <c:forEach var="address" items="${sessionScope.user.address}">
                                        <option value="${address}">${address}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="justify-content-start align-items-center mx-5 my-3">
                                <label for="payment" class="form-label">Phương thức thanh toán</label>
                                <select id="payment" name="payment" class="form-select" required>
                                    <option value="cod">Thanh toán khi nhận hàng</option>
                                    <option value="vnpay">Thanh toán bằng VNPAY</option>
                                </select>
                            </div>

                            <div class="my-4 text-center">
                                <button type="submit" class="btn btn-outline-dark">Xác Nhận</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%@include file="common/_footer.jsp" %>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>
            <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
            <script src="<%=request.getContextPath()%>/assets/js/web/checkoutHandler.js"></script>
    </body>

</html>