<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/change-password.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Đổi mật khẩu</title>
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
                                <a href="purchase-history?tab=all" class="nav-link text-muted option">Lịch sử mua hàng</a>
                                <a href="change-password" class="nav-link text-muted  option option-selected">Đổi mật khẩu</a>
                            </li>
                        </ul>
                    </div>

                    <div class="col-lg-9 col-sm-12">
                        <div class="container-fluid p-3 border border-dark">
                            <h6 class="m-3 text-center display-6">Thay đổi mật khẩu</h6>

                            <form id="change-password-form" action="change-password" method="post" class="px-5">
                                <div class="mb-3">
                                    <label for="current-password" class="form-label">Mật khẩu hiện tại</label>
                                    <input name="current-password" class="form-control" type="password" id="current-password" required>
                                    <i class="toggle-password fa fa-fw fa-eye-slash"></i>
                                </div>

                                <div class="mb-3">
                                    <label for="new-password" class="form-label">Mật khẩu mới</label>
                                    <input name="new-password" type="password" class="form-control" id="new-password" required>
                                    <i class="toggle-password fa fa-fw fa-eye-slash"></i>
                                </div>

                                <div class="mb-3">
                                    <label for="confirm-new-password" class="form-label">Xác nhận mật khẩu mới</label>
                                    <input name="confirm-new-password" class="form-control" type="password" id="confirm-new-password" required>
                                    <i class="toggle-password fa fa-fw fa-eye-slash"></i>
                                </div>

                                <div class="my-3 text-center">
                                    <div id="error-message" class="text-danger my-3">${error_msg}</div>
                                    <button type="submit" class="btn btn-outline-dark">Xác Nhận</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/changePasswordHandler.js"></script>
    </body>

</html>
