<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="io.hardingadonis.miu.services.Singleton"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link href="<%=request.getContextPath()%>/assets/css/admin/addNewProduct.css" rel="stylesheet" />

        <title>ADD NEW PRODUCT</title>
    </head>
    <body>
        <div class="container">
            <h1 class="title">ADD NEW PRODUCT</h1>
            <form id="productForm" action="<%=request.getContextPath()%>/admin/new-product" method="post">
                <!-- Product Information -->
                <div class="form-group">
                    <label for="productName">Name:</label>
                    <input type="text" id="productName" name="productName" required>
                </div>
                <div class="form-group">
                    <label for="productBrand">Brand:</label>
                    <input type="text" id="productBrand" name="productBrand" required>
                </div>
                <div class="form-group">
                    <label for="productCategoryID">Category:</label>
                    <select class="form-select" type="text" id="productCategoryID" name="productCategoryID" required>
                        <c:forEach var="category" items="${Singleton.categoryDAO.getAll()}">
                            <option value="${category.ID}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="productOrigin">Origin:</label>
                    <input type="text" id="productOrigin" name="productOrigin" required>
                </div>
                <div class="form-group">
                    <label for="productExpiry">Expiry Date:</label>
                    <input type="date" id="productExpiry" name="productExpiry" required>
                </div>
                <div class="form-group">
                    <label for="productWeight">Weight:</label>
                    <input type="text" id="productWeight" name="productWeight" required>
                </div>
                <div class="form-group">
                    <label for="productPreservation">Preservation:</label>
                    <input type="text" id="productPreservation" name="productPreservation" required>
                </div>
                <div class="form-group">
                    <label for="productPrice">Price:</label>
                    <input type="number" id="productPrice" name="productPrice" required>
                </div>
                <div class="form-group">
                    <label for="productAmount">Amount:</label>
                    <input type="number" id="productAmount" name="productAmount" required>
                </div>

                <!-- Thumbnail Upload -->
                <div class="form-group">
                    <label for="thumbnail">Thumbnail</label>
                    <input type="file" id="thumbnail" name="thumbnail" accept="image/*">
                    <div class="upload-icon" onclick="openFileUpload('thumbnail')">&#128260;</div>
                </div>

                <!-- Images Upload -->
                <div class="form-group">
                    <label for="images">Images</label>
                    <input type="file" id="images" name="images" accept="image/*" multiple>
                    <div class="upload-icon" onclick="openFileUpload('images')">&#128260;</div>
                </div>

                <!-- Submit Button -->
                <div class="form-group">
                    <button type="submit">Submit</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script src="<%=request.getContextPath()%>/assets/js/admin/add-new-product.js"></script>


    </body>
</html>
