<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Giới thiệu</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5 my-5">
            <div class="container">
                <div class="row py-3">
                    <div class="col-lg-6 col-md-12 py-1">
                        <h6 class="display-6 mb-4">
                            Chào mừng bạn đến với Miu Shop
                        </h6>
                        <p>
                            Tại Miu Shop, chúng tôi tự hào cung cấp những sản phẩm chính hãng từ thương hiệu hàng đầu M.O.I.
                        </p>
                        <p>
                            Khám phá bộ sưu tập đa dạng với chất lượng và phong cách đỉnh cao. 
                        </p>
                        <p>
                            Miu Shop luôn cập nhật xu hướng thời trang mới nhất, đáp ứng nhu cầu của khách hàng.
                        </p>
                        <p>
                            Miu Shop luôn mong muốn mang đến cho khách hàng những sản phẩm chất lượng nhất với giá cả hợp lý nhất.
                        </p>
                    </div>
                    <div class="col-lg-6 col-md-12 py-1">
                        <img class="card-img" src="<%=request.getContextPath()%>/assets/images/covers/55a08ee47df7b628ad07def611869c29dfba92dba3c803a5ff70dd88608817ca.avif">
                    </div>
                </div>
                <div class="py-3 text-center justify-content-center position-relative">
                    <h6 class="display-6 mb-4 mt-4">
                        Đội ngũ phát triển Miu Shop
                    </h6>

                    <a href="https://github.com/hardingadonis/miu-shop/graphs/contributors" target="_blank">
                        <img src="https://contrib.rocks/image?repo=hardingadonis/miu-shop" />
                    </a>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>