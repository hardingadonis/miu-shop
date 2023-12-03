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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/common/common.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/web/cart.css" />

        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png">

        <title>Miu Shop | Giỏ hàng</title>
    </head>

    <body>
        <%@include file="common/_header.jsp" %>

        <section class="py-5 my-5">
            <div class="container">
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
                                    <th scope="col" class="col-3 text-center">Sản phẩm</th>
                                    <th scope="col" class="col-2 text-center">Đơn giá</th>
                                    <th scope="col" class="col-2 text-center">Số lượng</th>
                                    <th scope="col" class="col-2 text-center">Thành tiền</th>
                                    <th scope="col" class="col-2 text-center">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        JSONObject data = (JSONObject) new JSONParser().parse((String) request.getAttribute("cart_data_str"));

                                        int index = 1;
                                        long totalPrice = 0;
                                        for (Object keyStr : data.keySet()) {
                                            Object valueStr = data.get(keyStr);
                                            int value = Integer.parseInt(valueStr.toString());
                                            int key = Integer.parseInt(keyStr.toString());

                                            Product product = Singleton.productDAO.get(key);
                                            totalPrice += product.getPrice() * value;
                                %>
                                <tr id="product-<%=product.getID()%>">
                                    <td scope="row" class="align-middle text-center"><%=index++%></td>
                                    <td class="align-middle">
                                        <a href="product?id=<%=product.getID()%>" class="d-flex align-items-center product" data-bs-placement="top" title="<%=product.getName()%>">
                                            <img src="<%=request.getContextPath()%>/<%=product.getThumbnail()%>" class="img-fluid me-3" style="width: 100px;">

                                            <p class="product-name lead"><%=product.getName()%></p>
                                        </a>
                                    </td>
                                    <td class="price align-middle text-center" id="product-price-<%=product.getID()%>"><%=product.getPrice()%></td>
                                    <td class="align-middle text-center">
                                        <div class="d-flex align-items-center justify-content-center">
                                            <button class="btn btn-sm btn-outline-dark" onclick="decreaseQuantity(<%=product.getID()%>)">-</button>
                                            <span class="mx-2" id="product-amount-<%=product.getID()%>" max="<%=product.getAmount()%>"><%=value%></span>
                                            <button class="btn btn-sm btn-outline-dark" onclick="increaseQuantity(<%=product.getID()%>)">+</button>
                                        </div>
                                    </td>
                                    <td class="price align-middle text-center" id="product-total-price-<%=product.getID()%>"><%=product.getPrice() * value%></td>
                                    <td class="align-middle text-center">
                                        <button class="btn btn-sm btn-outline-danger" onclick="removeProduct(<%=product.getID()%>)">Xóa</button>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>

                        <div class="d-flex justify-content-end align-items-center m-5">
                            <h6 class="display-6 mx-3">Tổng tiền:</h6>
                            <h6 class="display-6 price" id="total-price"><%=totalPrice%></h6>
                        </div>
                        <%
                            } catch (ParseException ex) {
                                System.err.println(ex.getMessage());
                            }
                        %>

                        <div class="d-flex justify-content-end m-5">
                            <a href="home" class="btn btn-outline-dark mx-3">Tiếp tục mua hàng</a>
                            <a href="checkout" class="btn btn-outline-dark">Thanh toán</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <%@include file="common/_footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/common/commonHandler.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/web/cartHandler.js"></script>
    </body>

</html>