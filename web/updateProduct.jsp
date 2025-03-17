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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --light-bg: #f8f9fa;
                --border-radius: 8px;
                --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            body {
                background-color: #f5f7fa;
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .card {
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                border: none;
            }

            .card-header {
                background-color: var(--primary-color);
                color: white;
                border-radius: var(--border-radius) var(--border-radius) 0 0 !important;
                padding: 15px 20px;
            }

            .form-container {
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 30px;
                margin-bottom: 30px;
            }

            .section-title {
                color: var(--primary-color);
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid var(--primary-color);
            }

            .form-label {
                font-weight: 600;
                color: #495057;
            }

            .form-control {
                border-radius: var(--border-radius);
                padding: 10px 15px;
                border: 1px solid #ced4da;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
            }

            input[readonly] {
                background-color: #f8f9fa !important;
                color: #6c757d;
                border: 1px solid #e9ecef;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 10px 20px;
                border-radius: var(--border-radius);
                transition: all 0.3s;
            }

            .btn-primary:hover {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
                padding: 10px 20px;
                border-radius: var(--border-radius);
            }

            .alert {
                border-radius: var(--border-radius);
                padding: 15px 20px;
            }

            .form-row {
                margin-bottom: 20px;
            }

            /* Icon styling */
            .input-icon-group {
                position: relative;
            }

            .input-icon {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
            }

            .icon-input {
                padding-left: 40px;
            }

            /* Section styling */
            .form-section {
                background-color: white;
                border-radius: var(--border-radius);
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: var(--box-shadow);
            }

            .category-badge {
                display: inline-block;
                padding: 5px 10px;
                background-color: var(--primary-color);
                color: white;
                border-radius: 20px;
                font-size: 14px;
                margin-left: 10px;
            }

            /* Validation styles */
            .invalid-feedback {
                font-size: 85%;
                font-weight: 500;
            }

            /* Error text color */
            .text-error {
                color: #dc3545;
            }
        </style>

        <script>
            function toggleFields() {
                var category = document.getElementById("category").value;

                // Nếu category = 1 (Laptop) -> Ẩn Camera, Hiện RAM Type & Upgrading
                if (category == "1") {
                    document.querySelectorAll('.category-1').forEach(el => el.style.display = "block");
                    document.querySelectorAll('.category-23').forEach(el => el.style.display = "none");

                    chipName.readOnly = true;
                    gpuName.readOnly = true;
                    chipName.removeAttribute("required");
                    gpuName.removeAttribute("required");
                }
                // Nếu category = 2 hoặc 3 (Dien Thoai/Tablet) -> Ẩn RAM Type & Upgrading, Hiện Camera
                else {
                    document.querySelectorAll('.category-1').forEach(el => el.style.display = "none");
                    document.querySelectorAll('.category-23').forEach(el => el.style.display = "block");

                    chipName.readOnly = false;
                    gpuName.readOnly = false;
                    chipName.setAttribute("required", "required");
                    gpuName.setAttribute("required", "required");
                }
            }

            // Gọi hàm khi trang tải xong để áp dụng ngay
            document.addEventListener("DOMContentLoaded", function () {
                toggleFields(); // Gọi khi trang tải xong

                const priceInput = document.getElementById('price');
                priceInput.addEventListener('input', function (e) {
                    const value = parseInt(e.target.value);
                    if (value < 0)
                        e.target.value = 0;
                    if (value > 1000000000)
                        e.target.value = 1000000000;
                });

                // Xử lý giá trị cho trường Quantity Available
                const quantityAvailableInput = document.getElementById('quantityProduct');
                quantityAvailableInput.addEventListener('input', function (e) {
                    const value = parseInt(e.target.value);
                    if (value < 0)
                        e.target.value = 0;
                    if (value > 1000000)
                        e.target.value = 1000000; // Giới hạn tối đa 1.000.000
                });

                // Xử lý giá trị cho trường Quantity Sold
                const quantitySoldInput = document.getElementById('quantitySell');
                quantitySoldInput.addEventListener('input', function (e) {
                    const value = parseInt(e.target.value);
                    if (value < 0)
                        e.target.value = 0;
                    if (value > 1000000)
                        e.target.value = 1000000; // Giới hạn tối đa 1.000.000   
                });

                // Xử lý giá trị cho trường Image URL
                const imageUrlInput = document.getElementById('imageURL');
                imageUrlInput.addEventListener('input', function (e) {
                    const url = e.target.value;
                    // Regex đơn giản để kiểm tra URL hình ảnh
                    const urlPattern = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\.(jpg|jpeg|png|gif|bmp|webp)$/i;
                    const isValidUrl = urlPattern.test(url);

                    if (!isValidUrl) {
                        document.getElementById('imageUrlError').textContent = 'URL hình ảnh không hợp lệ. Ví dụ: https://example.com/image.jpg';
                        document.getElementById('imageUrlError').style.display = 'block';
                        imageUrlInput.classList.add('is-invalid');
                    } else {
                        document.getElementById('imageUrlError').style.display = 'none';
                        imageUrlInput.classList.remove('is-invalid');
                    }
                });

                // Thêm xử lý validate form trước khi submit
                const form = document.querySelector('form');
                form.addEventListener('submit', function (e) {
                    let isValid = true;

                    // Kiểm tra giá trị Price
                    const price = parseInt(priceInput.value);
                    if (price < 0 || price > 1000000000) {
                        const errorMsg = document.getElementById('priceError');
                        errorMsg.textContent = 'Giá phải từ 0 đến 1.000.000.000';
                        errorMsg.style.display = 'block';
                        priceInput.classList.add('is-invalid');
                        isValid = false;
                    }

                    // Kiểm tra giá trị Quantity Available
                    const quantityAvailable = parseInt(quantityAvailableInput.value);
                    if (quantityAvailable < 0 || quantityAvailable > 1000000) {
                        const errorMsg = document.getElementById('quantityAvailableError');
                        errorMsg.textContent = 'Số lượng tồn kho phải từ 0 đến 1.000.000';
                        errorMsg.style.display = 'block';
                        quantityAvailableInput.classList.add('is-invalid');
                        isValid = false;
                    }

                    // Kiểm tra giá trị Quantity Sold
                    const quantitySold = parseInt(quantitySoldInput.value);
                    if (quantitySold < 0 || quantitySold > 1000000) {
                        const errorMsg = document.getElementById('quantitySoldError');
                        errorMsg.textContent = 'Số lượng đã bán phải từ 0 đến 1.000.000';
                        errorMsg.style.display = 'block';
                        quantitySoldInput.classList.add('is-invalid');
                        isValid = false;
                    }

                    // Kiểm tra giá trị Image URL
                    const imageUrl = imageUrlInput.value;
                    const urlPattern = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\.(jpg|jpeg|png|gif|bmp|webp)$/i;
                    const isValidUrl = urlPattern.test(imageUrl);
                    if (!isValidUrl) {
                        const errorMsg = document.getElementById('imageUrlError');
                        errorMsg.textContent = 'URL hình ảnh không hợp lệ. Ví dụ: https://example.com/image.jpg';
                        errorMsg.style.display = 'block';
                        imageUrlInput.classList.add('is-invalid');
                        isValid = false;
                    }

                    // Ngăn form submit nếu có lỗi
                    if (!isValid) {
                        e.preventDefault();
                    }
                });


            });
        </script>
    </head>
    <body>
        <div class="container mt-5 mb-5">
            <div class="card mb-4">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="m-0"><i class="fas fa-edit me-2"></i>Edit Product</h3>
                        <c:choose>
                            <c:when test="${product.categoryID == 1}">
                                <span class="category-badge"><i class="fas fa-laptop me-1"></i>Laptop</span>
                            </c:when>
                            <c:when test="${product.categoryID == 2}">
                                <span class="category-badge"><i class="fas fa-mobile-alt me-1"></i>Điện Thoại</span>
                            </c:when>
                            <c:otherwise>
                                <span class="category-badge"><i class="fas fa-tablet-alt me-1"></i>Tablet</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle me-2"></i>${requestScope.error}
                        </div>
                    </c:if>

                    <form action="updateProduct" method="POST" class="needs-validation" novalidate>
                        <div class="row">
                            <!-- Cột bên trái -->
                            <div class="col-md-6">
                                <div class="form-section">
                                    <h4 class="section-title"><i class="fas fa-info-circle me-2"></i>Basic Information</h4>

                                    <!-- Product ID (readonly) -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="productID" class="form-label">Product ID</label>
                                        <i class="fas fa-hashtag input-icon"></i>
                                        <input type="number" class="form-control icon-input" id="productID" name="productID" value="${product.productID}" readonly />
                                    </div>

                                    <!-- Product Name -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="productName" class="form-label">Product Name</label>
                                        <i class="fas fa-tag input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="productName" name="productName" value="${product.productName}" readonly />
                                    </div>

                                    <!-- Price - Đã sửa để xử lý min/max ở JavaScript thay vì HTML attributes -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="price" class="form-label">Price</label>
                                        <i class="fas fa-dollar-sign input-icon"></i>
                                        <input type="number" class="form-control icon-input" id="price" name="price" value="${product.price}" required />
                                        <div id="priceError" class="invalid-feedback" style="display: none;"></div>
                                        <!--                                        <small class="form-text text-muted">Giá trị từ 0 đến 1.000.000.000</small>-->
                                    </div>

                                    <!-- Category -->
                                    <div class="mb-3">
                                        <label for="category" class="form-label">Category</label>
                                        <select class="form-control" id="category" disabled>
                                            <option value="1" ${product.categoryID == 1 ? 'selected' : ''}>Laptop</option>
                                            <option value="2" ${product.categoryID == 2 ? 'selected' : ''}>Điện Thoại</option>
                                            <option value="3" ${product.categoryID == 3 ? 'selected' : ''}>Tablet</option>
                                        </select>
                                        <!-- Input ẩn để giữ giá trị khi submit form -->
                                        <input type="hidden" name="categoryID" value="${product.categoryID}">
                                    </div>

                                    <!-- Brand -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="brand" class="form-label">Brand</label>
                                        <i class="fas fa-building input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="brand" name="brand" value="${product.brand}" required />
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h4 class="section-title"><i class="fas fa-image me-2"></i>Display & Visual</h4>

                                    <!-- Screen Size -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="screenSize" class="form-label">Screen Size</label>
                                        <i class="fas fa-tv input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="screenSize" name="screenSize" value="${product.screenSize}" required />
                                    </div>

                                    <!-- Refresh Rate -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="refreshRate" class="form-label">Refresh Rate</label>
                                        <i class="fas fa-sync input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="refreshRate" name="refreshRate" value="${product.refreshRate}" required />
                                    </div>

                                    <div class="mb-3 input-icon-group">
                                        <label for="screenResolution" class="form-label">Screen Resolution</label>
                                        <i class="fas fa-expand input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="screenResolution" name="screenResolution" value="${product.screenResolution}" required />
                                    </div>
                                </div>

                                <!-- Camera (Only for Mobile/Tablet) -->
                                <div class="form-section category-23">
                                    <h4 class="section-title"><i class="fas fa-camera me-2"></i>Camera</h4>

                                    <div class="mb-3 input-icon-group">
                                        <label for="cameraFront" class="form-label">Front Camera</label>
                                        <i class="fas fa-camera-retro input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="cameraFront" name="cameraFront" value="${product.cameraFront}" required />
                                    </div>

                                    <div class="mb-3 input-icon-group">
                                        <label for="cameraBehind" class="form-label">Rear Camera</label>
                                        <i class="fas fa-camera input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="cameraBehind" name="cameraBehind" value="${product.cameraBehind}" required />
                                    </div>
                                </div>
                            </div>

                            <!-- Cột bên phải -->
                            <div class="col-md-6">
                                <div class="form-section">
                                    <h4 class="section-title"><i class="fas fa-microchip me-2"></i>Performance</h4>

                                    <!-- RAM -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="ram" class="form-label">RAM</label>
                                        <i class="fas fa-memory input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="ram" name="ram" value="${product.ram}" readonly />
                                    </div>

                                    <!-- RAM Type (Laptop Only) -->
                                    <div class="mb-3 input-icon-group category-1">
                                        <label for="ramType" class="form-label">RAM Type</label>
                                        <i class="fas fa-memory input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="ramType" name="ramType" value="${product.ramType}" required />
                                    </div>

                                    <!-- Supports Upgrading RAM (Laptop Only) -->
                                    <div class="mb-3 category-1">
                                        <label for="supportsUpgradingRAM" class="form-label">Supports Upgrading RAM</label>
                                        <select class="form-control" id="supportsUpgradingRAM" name="supportsUpgradingRAM" required>
                                            <option value="1" ${product.supportsUpgradingRAM == '1' ? 'selected' : ''}>Yes</option>
                                            <option value="0" ${product.supportsUpgradingRAM == '0'||product.supportsUpgradingRAM==null ? 'selected' : ''}>No</option>
                                        </select>
                                    </div>

                                    <!-- ROM -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="rom" class="form-label">ROM</label>
                                        <i class="fas fa-hdd input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="rom" name="rom" value="${product.rom}" readonly />
                                    </div>

                                    <!-- Supports Upgrading ROM (Laptop Only) -->
                                    <div class="mb-3 category-1">
                                        <label for="supportsUpgradingROM" class="form-label">Supports Upgrading ROM</label>
                                        <select class="form-control" id="supportsUpgradingROM" name="supportsUpgradingROM" required>
                                            <option value="1" ${product.supportsUpgradingROM == '1' ? 'selected' : ''}>Yes</option>
                                            <option value="0" ${product.supportsUpgradingROM == '0'||product.supportsUpgradingROM==null ? 'selected' : ''}>No</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h4 class="section-title"><i class="fas fa-cogs me-2"></i>System</h4>

                                    <!-- Chip Type & Name -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="chipType" class="form-label">Chip Type</label>
                                        <i class="fas fa-microchip input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="chipType" name="chipType" value="${product.chipType}" required />
                                    </div>

                                    <div class="mb-3 input-icon-group">
                                        <label for="chipName" class="form-label">Chip Name</label>
                                        <i class="fas fa-microchip input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="chipName" name="chipName" value="${product.chipName}" required />
                                    </div>

                                    <!-- GPU Type & Name -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="gpuType" class="form-label">GPU Type</label>
                                        <i class="fas fa-gamepad input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="gpuType" name="gpuType" value="${product.gpuType}" required />
                                    </div>

                                    <div class="mb-3 input-icon-group">
                                        <label for="gpuName" class="form-label">GPU Name</label>
                                        <i class="fas fa-gamepad input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="gpuName" name="gpuName" value="${product.gpuName}" required />
                                    </div>

                                    <!-- Operating System -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="operatingSystemName" class="form-label">Operating System</label>
                                        <i class="fab fa-windows input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="operatingSystemName" name="operatingSystemName" value="${product.operatingSystemName}" required />
                                    </div>

                                    <div class="mb-3 input-icon-group">
                                        <label for="operatingSystemVersion" class="form-label">Operating System Version</label>
                                        <i class="fas fa-code-branch input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="operatingSystemVersion" name="operatingSystemVersion" value="${product.operatingSystemVersion}" required />
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h4 class="section-title"><i class="fas fa-box me-2"></i>Inventory & Appearance</h4>

                                    <!-- Color -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="color" class="form-label">Color</label>
                                        <i class="fas fa-palette input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="color" name="color" value="${product.color}" readonly />
                                    </div>

                                    <!-- Quantity Available -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="quantityProduct" class="form-label">Quantity Available</label>
                                        <i class="fas fa-warehouse input-icon"></i>
                                        <input type="number" class="form-control icon-input" id="quantityProduct" name="quantityProduct" value="${product.quantityProduct}" required />
                                        <div id="quantityAvailableError" class="invalid-feedback" style="display: none;"></div>
                                        <!--                                        <small class="form-text text-muted">Số lượng tồn kho phải từ 0 đến 1.000.000</small>-->
                                    </div>

                                    <!-- Quantity Sold -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="quantitySell" class="form-label">Quantity Sold</label>
                                        <i class="fas fa-shopping-cart input-icon"></i>
                                        <input type="number" class="form-control icon-input" id="quantitySell" name="quantitySell" value="${product.quantitySell}" required />
                                        <div id="quantitySoldError" class="invalid-feedback" style="display: none;"></div>
                                        <!--                                        <small class="form-text text-muted">Số lượng đã bán phải từ 0 đến 1.000.000</small>-->
                                    </div>

                                    <!-- Image URL -->
                                    <div class="mb-3 input-icon-group">
                                        <label for="imageURL" class="form-label">Image URL</label>
                                        <i class="fas fa-image input-icon"></i>
                                        <input type="text" class="form-control icon-input" id="imageURL" name="imageURL" value="${product.imageURL}" required />
                                        <div id="imageUrlError" class="invalid-feedback" style="display: none;"></div>
<!--                                        <small class="form-text text-muted">Ví dụ: https://example.com/image.jpg</small>-->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-section mt-4">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <button type="submit" class="btn btn-primary me-2">
                                        <i class="fas fa-save me-2"></i>Save Changes
                                    </button>
                                    <a href="listProductsForAdmin" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Back to List
                                    </a>
                                </div>
                                <div>
                                    <a href="#" class="btn btn-outline-danger" onclick="return confirm('Are you sure you want to delete this product?')">
                                        <i class="fas fa-trash-alt me-2"></i>Delete Product
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>