<%-- 
    Document   : updateProduct
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

        <script>
            function toggleFields() {
                var category = document.getElementById("category").value;

                // Nếu category = 1 (Laptop) -> Ẩn Camera, Hiện RAM Type & Upgrading
                if (category == "1") {
                    document.querySelectorAll('.category-1').forEach(el => el.style.display = "block");
                    document.querySelectorAll('.category-23').forEach(el => el.style.display = "none");
                }
                // Nếu category = 2 hoặc 3 (Dien Thoai/Tablet) -> Ẩn RAM Type & Upgrading, Hiện Camera
                else {
                    document.querySelectorAll('.category-1').forEach(el => el.style.display = "none");
                    document.querySelectorAll('.category-23').forEach(el => el.style.display = "block");
                }
            }

            // Gọi hàm khi trang tải xong để áp dụng ngay
            window.onload = toggleFields;
        </script>

    </head>
    <body>

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
                    <input type="text" class="form-control" id="productID" name="productID" value="${product.productID}" readonly />
                </div>

                <!-- Product Name -->
                <div class="mb-3">
                    <label for="productName" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required />
                </div>

                <!-- Price -->
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="number" class="form-control" id="price" name="price" value="${product.price}" required />
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label for="category" class="form-label">Category</label>
                    <select class="form-control" id="category" name="categoryID" required onchange="toggleFields()">
                        <option value="1" ${product.categoryID == 1 ? 'selected' : ''}>Laptop</option>
                        <option value="2" ${product.categoryID == 2 ? 'selected' : ''}>Dien Thoai</option>
                        <option value="3" ${product.categoryID == 3 ? 'selected' : ''}>Tablet</option>
                    </select>
                </div>

                <!-- Brand -->
                <div class="mb-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" value="${product.brand}" required />
                </div>

                <!-- Camera -->
                <div class="mb-3 category-23">
                    <label for="cameraFront" class="form-label">Front Camera</label>
                    <input type="text" class="form-control" id="cameraFront" name="cameraFront" value="${product.cameraFront}" required />
                </div>

                <div class="mb-3 category-23">
                    <label for="cameraBehind" class="form-label">Behind Camera</label>
                    <input type="text" class="form-control" id="cameraBehind" name="cameraBehind" value="${product.cameraBehind}" required />
                </div>

                <!-- RAM -->
                <div class="mb-3">
                    <label for="ram" class="form-label">RAM</label>
                    <input type="text" class="form-control" id="ram" name="ram" value="${product.ram}" required />
                </div>

                <div class="mb-3 category-1">
                    <label for="ramType" class="form-label">RAM Type</label>
                    <input type="text" class="form-control" id="ramType" name="ramType" value="${product.ramType}" required />
                </div>

                <div class="mb-3 category-1">
                    <label for="supportsUpgradingRAM" class="form-label">Supports Upgrading RAM</label>
                    <select class="form-control" id="supportsUpgradingRAM" name="supportsUpgradingRAM" required>
                        <option value="1" ${product.supportsUpgradingRAM == '1' ? 'selected' : ''}>Yes</option>
                        <option value="0" ${product.supportsUpgradingRAM == '0'||product.supportsUpgradingRAM==null ? 'selected' : ''}>No</option>
                    </select>
                </div>

                <!-- ROM -->
                <div class="mb-3">
                    <label for="rom" class="form-label">ROM</label>
                    <input type="text" class="form-control" id="rom" name="rom" value="${product.rom}" required />
                </div>

                <div class="mb-3 category-1">
                    <label for="supportsUpgradingROM" class="form-label">Supports Upgrading ROM</label>
                    <select class="form-control" id="supportsUpgradingROM" name="supportsUpgradingROM" required>
                        <option value="1" ${product.supportsUpgradingROM == '1' ? 'selected' : ''}>Yes</option>
                        <option value="0" ${product.supportsUpgradingROM == '0'||product.supportsUpgradingROM==null ? 'selected' : ''}>No</option>
                    </select>
                </div>

                <!-- Color -->
                <div class="mb-3">
                    <label for="color" class="form-label">Color</label>
                    <input type="text" class="form-control" id="color" name="color" value="${product.color}" required />
                </div>

                <!-- Operating System -->
                <div class="mb-3">
                    <label for="operatingSystemName" class="form-label">Operating System</label>
                    <input type="text" class="form-control" id="operatingSystemName" name="operatingSystemName" value="${product.operatingSystemName}" required />
                </div>

                <div class="mb-3">
                    <label for="operatingSystemVersion" class="form-label">Operating System Version</label>
                    <input type="text" class="form-control" id="operatingSystemVersion" name="operatingSystemVersion" value="${product.operatingSystemVersion}" required />
                </div>

                <!-- Screen Size -->
                <div class="mb-3">
                    <label for="screenSize" class="form-label">Screen Size</label>
                    <input type="text" class="form-control" id="screenSize" name="screenSize" value="${product.screenSize}" required />
                </div>

                <!-- Refresh Rate -->
                <div class="mb-3">
                    <label for="refreshRate" class="form-label">Refresh Rate</label>
                    <input type="text" class="form-control" id="refreshRate" name="refreshRate" value="${product.refreshRate}" required />
                </div>

                <div class="mb-3">
                    <label for="screenResolution" class="form-label">Screen Resolution</label>
                    <input type="text" class="form-control" id="screenResolution" name="screenResolution" value="${product.screenResolution}" required />
                </div>



                <!-- Chip Type & Name -->
                <div class="mb-3">
                    <label for="chipType" class="form-label">Chip Type</label>
                    <input type="text" class="form-control" id="chipType" name="chipType" value="${product.chipType}" required />
                </div>

                <div class="mb-3">
                    <label for="chipName" class="form-label">Chip Name</label>
                    <input type="text" class="form-control" id="chipName" name="chipName" value="${product.chipName}" required />
                </div>

                <!-- GPU Type & Name -->
                <div class="mb-3">
                    <label for="gpuType" class="form-label">GPU Type</label>
                    <input type="text" class="form-control" id="gpuType" name="gpuType" value="${product.gpuType}" required />
                </div>

                <div class="mb-3">
                    <label for="gpuName" class="form-label">GPU Name</label>
                    <input type="text" class="form-control" id="gpuName" name="gpuName" value="${product.gpuName}" required />
                </div>

                <!-- Quantity Sold & Available -->
                <div class="mb-3">
                    <label for="quantitySell" class="form-label">Quantity Sold</label>
                    <input type="number" class="form-control" id="quantitySell" name="quantitySell" value="${product.quantitySell}" required />
                </div>

                <div class="mb-3">
                    <label for="quantityProduct" class="form-label">Quantity Available</label>
                    <input type="number" class="form-control" id="quantityProduct" name="quantityProduct" value="${product.quantityProduct}" required />
                </div>

                <!-- Image URL -->
                <div class="mb-3">
                    <label for="imageURL" class="form-label">Image URL</label>
                    <input type="text" class="form-control" id="imageURL" name="imageURL" value="${product.imageURL}" required />
                </div>

                <div class="d-flex justify-content-start">
                    <button type="submit" class="btn btn-primary me-2">Save</button>
                    <a href="listProductsForAdmin" class="btn btn-secondary">Back to List</a>
                </div>
            </form>
        </div>

    </body>
</html>
