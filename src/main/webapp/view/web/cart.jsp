<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="io.hardingadonis.miu.model.Product"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/cart.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Giỏ hàng</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5 my-5">
            <div class="container">
                <div class="py-3">
                    <c:if test="${cart_data_str == null}">
                        <div class="container my-5">
                            <h6 class="display-6 mb-4 d-flex justify-content-center">
                                Không có sản phẩm nào
                            </h6>
                            <br>
                            <div class="d-flex justify-content-center">
                                <a href="home" class="btn btn-outline-dark">Tiếp tục mua hàng</a>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${cart_data_str != null}">
                        <div class="container">
                            <h6 class="display-6 d-flex justify-content-center mb-5">
                                Giỏ hàng của bạn
                            </h6>

                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" class="col-1 text-center">#</th>
                                        <th scope="col" class="col-4 text-center">Sản phẩm</th>
                                        <th scope="col" class="col-2 text-center">Đơn giá</th>
                                        <th scope="col" class="col-1 text-center">Số lượng</th>
                                        <th scope="col" class="col-2 text-center">Số tiền</th>
                                        <th scope="col" class="col-2 text-center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try {
                                            JSONObject data = (JSONObject) new JSONParser().parse((String) request.getAttribute("cart_data_str"));

                                            int index = 1;
                                            for (Object keyStr : data.keySet()) {
                                                Object valueStr = data.get(keyStr);
                                                int value = Integer.parseInt(valueStr.toString());
                                                int key = Integer.parseInt(keyStr.toString());

                                                Product product = Singleton.productDAO.get(key);
                                    %>
                                    <tr>
                                        <td scope="row" class="align-middle text-center"><%=index++%></td>
                                        <td class="align-middle">
                                            <a href="product?id=<%=product.getID()%>" class="d-flex align-items-center product" data-bs-placement="top" title="<%=product.getName()%>">
                                                <img src="<%=request.getContextPath()%>/<%=product.getThumbnail()%>" class="img-fluid me-3" style="width: 100px;">

                                                <p class="product-name lead"><%=product.getName()%></p>
                                            </a>
                                        </td>
                                        <td class="price align-middle text-center"><%=product.getPrice()%></td>
                                        <td class="align-middle text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <button class="btn btn-sm btn-outline-dark">-</button>
                                                <span class="mx-2"><%=value%></span>
                                                <button class="btn btn-sm btn-outline-dark">+</button>
                                            </div>
                                        </td>
                                        <td class="price align-middle text-center"><%=product.getPrice() * value%></td>
                                        <td class="align-middle text-center">
                                            <button class="btn btn-sm btn-outline-danger">Xóa</button>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        } catch (ParseException ex) {
                                            System.err.println(ex.getMessage());
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/cartHandler.js"></script>
    </body>

</html>