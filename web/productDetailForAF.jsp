<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Product Detail</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            body {
                display: flex;
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
                transition: background-color 0.3s;
            }
            .sidebar a {
                padding: 10px 15px;
                text-decoration: none;
                font-size: 18px;
                color: white;
                display: block;
                transition: background-color 0.3s ease;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .content {
                margin-left: 250px;
                width: calc(100% - 250px);
                padding: 20px;
            }
            .navbar-custom {
                background: white;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                padding: 10px 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .profile {
                display: flex;
                align-items: center;
            }
            .profile a {
                margin-right: 10px;
                font-weight: bold;
                color: #343a40;
                text-decoration: none;
            }
            .profile a:hover {
                color: #007bff;
            }
            .product-detail {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }
            .product-detail img {
                max-width: 100%;
                height: auto;
                border-radius: 5px;
            }
            .product-detail h2 {
                margin-bottom: 20px;
            }
            .product-detail .row {
                margin-bottom: 15px;
            }
            .product-detail .row .col-md-4 {
                font-weight: bold;
            }
            .category-1, .category-23 {
                display: none;
            }
        </style>
        <script>
            function toggleFields() {
                var category = "${product.categoryID}";

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
            document.addEventListener("DOMContentLoaded", function () {
                toggleFields(); // Gọi khi trang tải xong
            });
        </script>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        <!-- Sidebar -->
<!--        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-chart-bar"></i> Manager Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-box"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-cog"></i> Manager Feedback</a>
            <a href="Revenue"><i class="fas fa-cog"></i> Manager Revenue</a>
            <a href="ListInventory"><i class="fas fa-cog"></i> Manager Inventory</a>
        </div>-->

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4>Admin Dashboard - Product Detail</h4>

                <div>
                    <a href="ManagerProfile.jsp" class="profile-link">Admin</a>
                    <a href="javascript:void(0);" class="logout-link" onclick="logout()">Logout</a>
                </div>
            </nav>

            <div class="product-detail">
                <h2 class="text-center mb-4">Product Detail</h2>
                <c:if test="${not empty error}">
                    <div style="color: red; text-align: center; margin-bottom: 15px;">
                        ${error}
                    </div>
                </c:if>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tbody>
                            <tr><th>Product ID</th><td>${product.productID}</td></tr>
                            <tr><th>Product Name</th><td>${product.productName}</td></tr>
                            <tr><th>Price</th><td><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ</td></tr>
                            <tr>
                                <th>Category</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.categoryID == 1}">Laptop</c:when>
                                        <c:when test="${product.categoryID == 2}">Dien Thoai</c:when>
                                        <c:when test="${product.categoryID == 3}">Tablet</c:when>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>Brand</th><td>${product.brand}</td></tr>

                            <c:if test="${product.categoryID == 2 || product.categoryID == 3}">
                                <tr><th>Front Camera</th><td>${product.cameraFront}</td></tr>
                                <tr><th>Rear Camera</th><td>${product.cameraBehind}</td></tr>
                                    </c:if>

                            <tr><th>RAM</th><td>${product.ram}</td></tr>

                            <c:if test="${product.categoryID == 1}">
                                <tr><th>RAM Type</th><td>${product.ramType}</td></tr>
                                <tr><th>Supports Upgrading RAM</th><td>${product.supportsUpgradingRAM == '1' ? 'Yes' : 'No'}</td></tr>
                                    </c:if>

                            <tr><th>ROM</th><td>${product.rom}</td></tr>

                            <c:if test="${product.categoryID == 1}">
                                <tr><th>Supports Upgrading ROM</th><td>${product.supportsUpgradingROM == '1' ? 'Yes' : 'No'}</td></tr>
                                    </c:if>

                            <tr><th>Color</th><td>${product.color}</td></tr>
                            <tr><th>Operating System</th><td>${product.operatingSystemName} ${product.operatingSystemVersion}</td></tr>
                            <tr><th>Screen Size</th><td>${product.screenSize}</td></tr>
                            <tr><th>Refresh Rate</th><td>${product.refreshRate}</td></tr>
                            <tr><th>Screen Resolution</th><td>${product.screenResolution}</td></tr>
                            <tr><th>Chip Type</th><td>${product.chipType}</td></tr>
                            <tr><th>Chip Name</th><td>${product.chipName}</td></tr>
                            <tr><th>GPU Type</th><td>${product.gpuType}</td></tr>
                            <tr><th>GPU Name</th><td>${product.gpuName}</td></tr>
                            <tr><th>Quantity Sold</th><td>${product.quantitySell}</td></tr>
                            <tr><th>Quantity Available</th><td>${product.quantityProduct}</td></tr>
                            <tr>
                                <th>Image</th>
                                <td class="text-center">
                                    <img src="${product.imageURL}" alt="Product Image" class="img-fluid rounded" style="max-width: 300px;">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="text-center mt-4">
                    <a href="updateProduct?productID=${product.productID}" class="btn btn-warning">Update</a>
                    <a href="deleteProduct?productID=${product.productID}" 
                       onclick="return confirm('Are you sure you want to delete this product?');"
                       class="btn btn-danger">Delete</a>
                    <a href="listProductsForAdmin" class="btn btn-secondary">Back to List</a>
                </div>
            </div>

        </div>

        <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', {method: 'POST'})
                        .then(response => {
                            if (response.ok) {
                                window.location.href = '/LoginOfDashboard.jsp';
                            } else {
                                alert('Logout Fail!');
                            }
                        })
                        .catch(error => console.error('Logout Error:', error));
            }
        </script>
    </body>
</html>