<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                background-color: #f8f9fa;
            }

            /* Sidebar */
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
                font-size: 16px;
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
                padding: 20px;
            }

            /* Navbar */
            .navbar-custom {
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
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

            /* Table */
            .table-responsive {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            .table thead {
                background-color: #343a40;
                color: white;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }

            /* Buttons */
            .btn-primary {
                background-color: #0d6efd;
                border-color: #0d6efd;
                padding: 8px 16px;
                font-weight: 600;
            }
            .btn-primary:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            .btn-warning {
                background-color: #ffc107;
                border-color: #ffc107;
                padding: 8px 16px;
                font-weight: 600;
            }
            .btn-warning:hover {
                background-color: #e0a800;
                border-color: #d39e00;
            }
            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
                padding: 8px 16px;
                font-weight: 600;
            }
            .btn-danger:hover {
                background-color: #bb2d3b;
                border-color: #b02a37;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center mb-4">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-user-tie"></i> Manage Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-comment-dots"></i> Manage Feedback</a>
            <a href="Revenue"><i class="fas fa-chart-line"></i> Manage Revenue</a>
            <a href="ListInventory"><i class="fas fa-warehouse"></i> Manage Inventory</a>
        </div>

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4>Admin Dashboard - List Products</h4>
                <div class="profile">
                    <a href="ManagerProfile.jsp" class="profile-link">${sessionScope.Username}</a>
                    <a href="javascript:void(0);" class="btn btn-danger" onclick="logout()">Logout</a>
                </div>
            </nav>

            <!-- Button to Create Product -->
            <div class="d-flex justify-content-end mb-3">
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        Create Product
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <li><a class="dropdown-item" href="createProduct.jsp?category=2">Phone</a></li>
                        <li><a class="dropdown-item" href="createTablet.jsp?category=3">Tablet</a></li>
                        <li><a class="dropdown-item" href="createLaptop.jsp?category=1">Laptop</a></li>
                    </ul>
                </div>
            </div>

            <!-- Products Table -->
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
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
                                    <td>${p.productID}</td>
                                    <td>${p.productName}</td>
                                    <td>${p.price}</td>
                                    <td>${p.quantitySell}</td>
                                    <td>${p.quantityProduct}</td>
                                    <td>
                                        <a href="productDetailForAF?productID=${p.productID}" class="btn btn-warning btn-sm">Detail</a>
                                        <a href="deleteProduct?productID=${p.productID}" 
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');"
                                           class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
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
