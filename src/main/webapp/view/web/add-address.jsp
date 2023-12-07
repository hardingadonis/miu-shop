<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/add-address.css" />

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
                            <h6 class="m-3 text-center display-6">Thêm địa chỉ giao hàng</h6>

                            <div class="px-5">
                                <div class="py-3">
                                    <form action="add-address" method="post" id="add-address-form">
                                        <div class="row">
                                            <div class="col-4 mb-3">
                                                <select id="city" name="city" class="form-select" required>
                                                    <option value="" selected>Chọn tỉnh thành</option>           
                                                </select>
                                            </div>

                                            <div class="col-4 mb-3">
                                                <select id="district" name="district" class="form-select" required>
                                                    <option value="" selected>Chọn quận huyện</option>
                                                </select>
                                            </div>

                                            <div class="col-4 mb-3">
                                                <select id="ward" name="ward" class="form-select" required>
                                                    <option value="" selected>Chọn phường xã</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="my-3">
                                            <label for="specific" class="form-label">Địa chỉ cụ thể</label>
                                            <input name="specific" type="text" class="form-control" id="specific" placeholder="111 Nguyễn Văn A" required>
                                        </div>

                                        <div class="my-3">
                                            <label for="receiver" class="form-label">Người nhận hàng</label>
                                            <input name="receiver" type="text" class="form-control" id="receiver" placeholder="Nguyễn Văn A" required>
                                        </div>

                                        <div class="my-3">
                                            <label for="phone" class="form-label">Số điện thoại</label>
                                            <input name="phone" type="text" class="form-control" id="phone" placeholder="0388888888" required>
                                        </div>

                                        <div class="my-3 text-center">
                                            <div id="error-message" class="text-danger my-3">${error_msg}</div>
                                            <button type="submit" class="btn btn-outline-dark">Xác nhận</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.2/axios.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/addAddressHandler.js"></script>
    </body>

</html>