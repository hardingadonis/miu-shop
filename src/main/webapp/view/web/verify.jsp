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

        <title>Miu Shop | Xác thực</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="container">
            <div class="py-5 my-5">
                <div class="container my-5">
                    <h6 class="display-6 mb-4 d-flex justify-content-center">
                        Xác thực tài khoản
                    </h6>
                    <br>
                    <div class="text-center">
                        ${msg}
                    </div>
                    <br>
                    <c:if test="${success == true}">
                        <div class="d-flex justify-content-center">
                            <a href="home" class="btn btn-outline-dark">Bắt đầu mua sắm</a>
                        </div>
                    </c:if>
                    <br>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
    </body>

</html>