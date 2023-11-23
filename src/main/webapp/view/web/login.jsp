<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/login.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Đăng nhập</title>
    </head>
    <body>
        <div class="wrapper">


            <%-- Kiểm tra xem có URL parameter registerSuccess hay không --%>
            <c:if test="${param.registerSuccess == 'true'}">
                <style>
                    .main {
                        min-height: 75vh;
                        padding-bottom: 8.5vh;
                    }
                </style>
                
                <div class="alert alert-success mx-auto" role="alert" style="max-width: 500px;">
                    Bạn đã đăng ký thành công. Vui lòng đăng nhập để tiếp tục.
                </div>
            </c:if>


            <div class="container main">     
                <div class="row">
                    <div class="col-md-6 side-image">
                    </div>
                    <div class="col-md-6 right">
                        <div class="input-box">
                            <header>Đăng nhập</header>
                            <form id="login-form" action="login" method="post">
                                <div class="input-field">
                                    <input name="email" type="text" class="input" id="email" required value="${email}">
                                    <label for="email">Email</label>
                                </div>
                                <div class="input-field">
                                    <input name="password" type="password" class="input" id="password" required>
                                    <label for="password">Mật khẩu</label>
                                </div>
                                <div class="input-field" id="submit-form">
                                    <input type="submit" class="submit" value="Đăng nhập">
                                    <div id="error-message" class="text-danger">${errorMsg}</div>
                                </div>
                            </form>
                            <div class="register">
                                <span>Chưa có tài khoản? <a href="register">Đăng ký ngay</a></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/loginHandler.js"></script>
    </body>
</html>
