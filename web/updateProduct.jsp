<%-- 
    Document   : editProduct
    Created on : Feb 24, 2025
    Author     : Dinh Van Do - CE182224
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>

        <pre>${requestScope.product}</pre>

        <div class="container mt-5">
            <h1 class="text-center">Edit Product</h1>
            <form action="updateProduct" method="POST" class="needs-validation" novalidate>

                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty requestScope.error}">
                    <div class="alert alert-danger">${requestScope.error}</div>
                </c:if>

                <!-- Product ID (readonly) -->
                <div class="mb-3">
                    <label for="productID" class="form-label">Product ID</label>
                    <input type="text" class="form-control" id="productID" name="productID" value="${requestScope.product.productID}" readonly />
                </div>

                <!-- Product Name -->
                <div class="mb-3">
                    <label for="productName" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" value="${requestScope.product.productName}" required />
                </div>

                <!-- Price -->
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="number" class="form-control" id="price" name="price" value="${requestScope.product.price}" required />
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label for="category" class="form-label">Category</label>
                    <select class="form-control" id="category" name="category" required>
                        <option value="1">1(Laptop)</option>
                        <option value="2">2(DienThoai)</option>
                        <option value="3">3(Tablet)</option>
                    </select>
                </div>


                <!-- Brand -->
                <div class="mb-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" value="${requestScope.product.brand}" required />
                </div>

                <!-- Camera -->
                <div class="mb-3">
                    <label for="camera" class="form-label">Camera</label>
                    <input type="text" class="form-control" id="camera" name="camera" value="${requestScope.product.camera}" required />
                </div>

                <!-- RAM -->
                <div class="mb-3">
                    <label for="ram" class="form-label">RAM</label>
                    <input type="text" class="form-control" id="ram" name="ram" value="${requestScope.product.ram}" required />
                </div>

                <!-- ROM -->
                <div class="mb-3">
                    <label for="rom" class="form-label">ROM</label>
                    <input type="text" class="form-control" id="rom" name="rom" value="${requestScope.product.rom}" required />
                </div>

                <!-- Color -->
                <div class="mb-3">
                    <label for="color" class="form-label">Color</label>
                    <input type="text" class="form-control" id="color" name="color" value="${requestScope.product.color}" required />
                </div>

                <!-- Operating System -->
                <div class="mb-3">
                    <label for="operatingSystem" class="form-label">Operating System</label>
                    <input type="text" class="form-control" id="operatingSystem" name="operatingSystem" value="${requestScope.product.operatingSystem}" required />
                </div>

                <!-- Size -->
                <div class="mb-3">
                    <label for="size" class="form-label">Size</label>
                    <input type="text" class="form-control" id="size" name="size" value="${requestScope.product.size}" required />
                </div>

                <!-- Refresh Rate -->
                <div class="mb-3">
                    <label for="refreshRate" class="form-label">Refresh Rate</label>
                    <input type="text" class="form-control" id="refreshRate" name="refreshRate" value="${requestScope.product.refreshRate}" required />
                </div>

                <!-- Chip -->
                <div class="mb-3">
                    <label for="chip" class="form-label">Chip</label>
                    <input type="text" class="form-control" id="chip" name="chip" value="${requestScope.product.chip}" required />
                </div>

                <!-- GPU -->
                <div class="mb-3">
                    <label for="gpu" class="form-label">GPU</label>
                    <input type="text" class="form-control" id="gpu" name="gpu" value="${requestScope.product.gpu}" required />
                </div>

                <!-- Quantity Sold -->
                <div class="mb-3">
                    <label for="quantitySell" class="form-label">Quantity Sold</label>
                    <input type="number" class="form-control" id="quantitySell" name="quantitySell" value="${requestScope.product.quantitySell}" required />
                </div>

                <!-- Quantity Available -->
                <div class="mb-3">
                    <label for="quantityProduct" class="form-label">Quantity Available</label>
                    <input type="number" class="form-control" id="quantityProduct" name="quantityProduct" value="${requestScope.product.quantityProduct}" required />
                </div>

                <!-- Image URL -->
                <div class="mb-3">
                    <label for="imageURL" class="form-label">Image URL</label>
                    <input type="text" class="form-control" id="imageURL" name="imageURL" value="${requestScope.product.imageURL}" required />
                </div>

                <div class="d-flex justify-content-start">
                    <button type="submit" class="btn btn-primary me-2">Save</button>
                    <a href="listProductsForAdmin" class="btn btn-secondary">Back to List</a>
                </div>
            </form>
        </div>
        <script>
            (function () {
                'use strict';
                window.addEventListener('load', function () {
                    var forms = document.getElementsByClassName('needs-validation');
                    Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
    </body>
</html>
