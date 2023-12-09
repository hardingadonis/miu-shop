<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/forgot-change-password.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Thiết lập mật khẩu mới</title>
    </head>
    <body>

        <c:if test="${not empty param.code and not empty param.email}">
            <div class="container main">
                <div class="forgot-password-container p-5">
                    <header>Thiết lập mật khẩu mới</header>

                    <div id="email" hidden>${param.email}</div>

                    <form id="change-password-form">
                        <div class="mb-5 mx-5 px-2">
                            <label for="password" class="form-label">Mật khẩu mới</label>
                            <input name="password" type="password" class="form-control" id="password" required>
                            <i class="toggle-password fa fa-fw fa-eye-slash"></i>
                        </div>

                        <div class="mb-5 mx-5 px-2">
                            <label for="comfirm-password" class="form-label">Xác nhận mật khẩu mới</label>
                            <input name="comfirm-password" type="password" class="form-control" id="comfirm-password" required>
                            <i class="toggle-password fa fa-fw fa-eye-slash"></i>
                        </div>

                        <div class="m-2" id="submit-form" style="display: flex; flex-direction: column; position: relative; padding: 0 10px;">
                            <input type="submit" class="submit" value="Xác nhận">
                            <div id="error-message" class="text-danger mt-3">${errorMsg}</div>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/forgotChangePasswordHandler.js"></script>
    </body>
</html>