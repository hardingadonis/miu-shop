<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/profile.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Thông tin chung</title>
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
                                <a href="profile" class="nav-link text-muted option option-selected">Thông tin chung</a>
                                <a href="delivery-address" class="nav-link text-muted option">Địa chỉ giao hàng</a>
                                <a href="purchase-history?tab=all" class="nav-link text-muted option">Lịch sử mua hàng</a>
                                <a href="change-password" class="nav-link text-muted option">Đổi mật khẩu</a>
                            </li>
                        </ul>
                    </div>

                    <div class="col-lg-9 col-sm-12">
                        <div class="container-fluid p-3 border border-dark">
                            <h6 class="m-3 text-center display-6">Thông tin chung</h6>

                            <form id="profile-form" action="profile" method="post" enctype="multipart/form-data" class="px-5">
                                <div class="mb-3">
                                    <label for="full-name" class="form-label">Họ và tên</label>
                                    <input name="full-name" class="form-control" type="text" id="full-name" value="${sessionScope.user.fullName}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input name="email" type="text" class="form-control" id="email" value="${sessionScope.user.email}" disabled required>
                                </div>

                                <div class="mb-3">
                                    <label for="birth-year" class="form-label">Năm sinh</label>
                                    <input name="birth-year" class="form-control" type="text" id="birth-year" value="${sessionScope.user.birthYear}" required>
                                </div>

                                <div class="mb-3 input-field-gender">
                                    <label class="form-label me-3">Giới Tính</label>
                                    <div class="justify-content-around d-flex">
                                        <div class="form-check mx-3">
                                            <input class="form-check-input" type="radio" name="gender" id="male" value="male" ${gender eq 'male' ? 'checked' : ''}>
                                            <label class="form-check-label" for="male">Nam</label>
                                        </div>
                                        <div class="form-check mx-3">
                                            <input class="form-check-input" type="radio" name="gender" id="female" value="female" ${gender eq 'female' ? 'checked' : ''}>
                                            <label class="form-check-label" for="female">Nữ</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="formImageFile" class="form-label">Chọn ảnh avatar mới</label>
                                    <input name="avatar-image" class="form-control" type="file" id="formImageFile" accept="image/*">
                                </div>

                                <div class="my-3 text-center">
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
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/profileHandler.js"></script>
    </body>

</html>
