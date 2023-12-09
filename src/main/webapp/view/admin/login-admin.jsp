<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/admin/loginAdmin.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Đăng nhập Admin</title>
    </head>
    <body>
        <div class="wrapper">

            <div class="container main">     
                <div class="row">
                    <div class="col-md-6 side-image">
                    </div>
                    <div class="col-md-6 right">
                        <div class="input-box">
                            <header>Đăng nhập Admin</header>
                            <form id="login-form" action="<%=request.getContextPath()%>/admin/login" method="post">
                                <div class="input-field">
                                    <input name="username" type="text" class="input" id="username" required value="${username}">
                                    <label for="username">User Name</label>
                                </div>
                                <div class="input-field eye">
                                    <input name="password" type="password" class="input" id="password" required>
                                    <label for="password">Mật khẩu</label>
                                    <i class="show-password-toggle fas fa-eye-slash" data-toggle="password"></i>
                                </div>

                                <div class="input-field" id="submit-form">
                                    <input type="submit" class="submit" value="Đăng nhập">
                                    <div id="error-message" class="text-danger mt-3">${errorMsg}</div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/loginAdmin.js"></script>
    </body>
</html>
