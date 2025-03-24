<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - List Products</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                overflow-x: hidden;
            }

            /* Sidebar - KEPT EXACTLY AS ORIGINAL */
            .sidebar {
                height: 100vh;
                width: 250px;
                background: linear-gradient(to bottom, #343a40, #212529);
                color: white;
                position: fixed;
                padding-top: 20px;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }
            .sidebar a {
                padding: 12px 20px;
                text-decoration: none;
                color: rgba(255, 255, 255, 0.8);
                display: block;
                transition: all 0.3s;
                border-left: 4px solid transparent;
            }
            .sidebar a:hover {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border-left: 4px solid #0d6efd;
            }
            .sidebar a i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            /* Main Content */
            .content {
                margin-left: 250px;
                padding: 25px;
                transition: all 0.3s ease;
            }

            /* Navbar */
            .navbar-custom {
                background-color: white;
                padding: 15px 25px;
                border-radius: 10px;
                box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
                margin-bottom: 25px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .navbar-custom h4 {
                font-weight: 600;
                color: #2b3035;
                margin: 0;
            }
            
            .profile {
                display: flex;
                align-items: center;
            }
            
            .profile a.profile-link {
                margin-right: 15px;
                font-weight: 600;
                color: #0d6efd;
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 6px;
                transition: all 0.2s;
            }
            
            .profile a.profile-link:hover {
                background-color: rgba(13, 110, 253, 0.1);
            }
            
            .btn-logout {
                padding: 8px 16px;
                border-radius: 6px;
                transition: all 0.2s;
                font-weight: 500;
                box-shadow: 0 2px 5px rgba(220, 53, 69, 0.2);
            }
            
            .btn-logout:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }

            /* Action Button */
            .action-button {
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                box-shadow: 0 2px 8px rgba(13, 110, 253, 0.25);
                transition: all 0.2s;
            }
            
            .action-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(13, 110, 253, 0.3);
            }
            
            .dropdown-menu {
                border: none;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
                border-radius: 8px;
                padding: 10px 0;
            }
            
            .dropdown-item {
                padding: 8px 20px;
                transition: all 0.2s;
            }
            
            .dropdown-item:hover {
                background-color: rgba(13, 110, 253, 0.1);
                color: #0d6efd;
            }

            /* Table */
            .table-container {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            }
            
            .table {
                border-collapse: separate;
                border-spacing: 0;
            }
            
            .table thead th {
                background-color: #343a40;
                color: white;
                font-weight: 500;
                padding: 12px 18px;
                border: none;
            }
            
            .table thead th:first-child {
                border-top-left-radius: 8px;
            }
            
            .table thead th:last-child {
                border-top-right-radius: 8px;
            }
            
            .table tbody td {
                padding: 12px 18px;
                vertical-align: middle;
                border-top: none;
                border-bottom: 1px solid #eaeaea;
            }
            
            .table tbody tr:last-child td {
                border-bottom: none;
            }
            
            .table tbody tr:hover {
                background-color: rgba(240, 242, 245, 0.6);
                transition: background-color 0.2s;
            }
            
            .table-action-btn {
                margin-right: 5px;
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.2s;
            }
            
            .table-action-btn:hover {
                transform: translateY(-2px);
            }
            
            .btn-warning {
                box-shadow: 0 2px 5px rgba(255, 193, 7, 0.2);
            }
            
            .btn-warning:hover {
                box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
            }
            
            .btn-danger, .btn-outline-danger {
                box-shadow: 0 2px 5px rgba(220, 53, 69, 0.2);
            }
            
            .btn-danger:hover, .btn-outline-danger:hover {
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }
            
            /* Price column styling */
            .price-column {
                font-weight: 600;
                color: #0d6efd;
            }
            
            /* Status indicators */
            .stock-status {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
                display: inline-block;
            }
            
            .in-stock {
                background-color: rgba(40, 167, 69, 0.1);
                color: #28a745;
            }
            
            .low-stock {
                background-color: rgba(255, 193, 7, 0.1);
                color: #ffc107;
            }
        </style>
    </head>
    <body>
        
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4><i class="fas fa-box me-2"></i>Admin Dashboard - Product Management</h4>
                <div class="profile">
                    <a href="ManagerProfile.jsp" class="profile-link">
                        <i class="fas fa-user-circle me-1"></i>${sessionScope.Username}
                    </a>
                    <a href="javascript:void(0);" class="btn btn-danger btn-logout" onclick="logout()">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </nav>

            <!-- Button to Create Product -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                
                <div class="dropdown">
                    <button class="btn btn-primary action-button dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-plus me-1"></i>Create Product
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <li><a class="dropdown-item" href="createProduct.jsp?category=2"><i class="fas fa-mobile-alt me-2"></i>Phone</a></li>
                        <li><a class="dropdown-item" href="createTablet.jsp?category=3"><i class="fas fa-tablet-alt me-2"></i>Tablet</a></li>
                        <li><a class="dropdown-item" href="createLaptop.jsp?category=1"><i class="fas fa-laptop me-2"></i>Laptop</a></li>
                    </ul>
                </div>
            </div>

            <!-- Products Table -->
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Color</th>
                            <th>RAM</th>
                            <th>Storage</th>
                            <th>Price</th>
                            <th>Sold</th>
                            <th>Quantity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Duyệt qua danh sách sản phẩm -->
                        <c:forEach items="${list}" var="p">
                            <c:if test="${p.isDelete == 0}">
                                <tr>
                                    <td><span class="badge bg-dark">${p.productID}</span></td>
                                    <td class="fw-medium">${p.productName}</td>
                                    <td>${p.color}</td>
                                    <td>${p.ram} GB</td>
                                    <td>${p.rom} GB</td>
                                    <td class="price-column"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</td>
                                    <td>${p.quantitySell}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.quantityProduct > 10}">
                                                <span class="stock-status in-stock">${p.quantityProduct}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-status low-stock">${p.quantityProduct}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="productDetailForAF?productID=${p.productID}" class="btn btn-warning table-action-btn">
                                            <i class="fas fa-eye me-1"></i>Detail
                                        </a>
                                        <a href="javascript:void(0);" 
                                           class="btn btn-outline-danger table-action-btn"
                                           onclick="confirmDelete(${p.productID}, '${p.productName}')">
                                            <i class="fas fa-trash-alt me-1"></i>Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="deleteConfirmModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Confirm Deletion</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="mb-2">Are you sure you want to delete this product?</p>
                        <div class="alert alert-warning">
                            <div class="d-flex align-items-center mb-2">
                                <i class="fas fa-info-circle me-2 text-warning fs-5"></i>
                                <strong>Product details:</strong>
                            </div>
                            <ul class="list-unstyled ms-4 mb-0">
                                <li><strong>ID:</strong> <span id="deleteProductId"></span></li>
                                <li><strong>Name:</strong> <span id="deleteProductName"></span></li>
                            </ul>
                        </div>
                        <p class="text-danger mb-0"><strong>This action cannot be undone.</strong></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn" onclick="proceedWithDelete()">
                            <i class="fas fa-trash-alt me-1"></i>Delete Product
                        </button>
                    </div>
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
                                alert('Logout Failed!');
                            }
                        })
                        .catch(error => console.error('Logout Error:', error));
            }
            
            let productToDelete = null;

            function confirmDelete(productId, productName) {
                // Store the product ID for the delete action
                productToDelete = productId;
                
                // Update the modal with product details
                document.getElementById('deleteProductId').textContent = productId;
                document.getElementById('deleteProductName').textContent = productName;
                
                // Show the confirmation modal
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                deleteModal.show();
            }
            
            function proceedWithDelete() {
                if (productToDelete) {
                    window.location.href = "deleteProduct?productID=" + productToDelete;
                }
            }
        </script>
    </body>
</html>