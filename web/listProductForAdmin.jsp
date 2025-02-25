<%-- 
    Document   : HomeDashBoard
    Created on : Feb 24, 2025, 8:13:02 PM
    Author     : Dang Khac Hieu_CE180465
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - List Products</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .sidebar {
                height: 100vh;
                width: 250px;
                background-color: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
            }
            .sidebar a {
                padding: 10px 15px;
                text-decoration: none;
                font-size: 18px;
                color: white;
                display: block;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .content {
                margin-left: 250px;
                padding: 20px;
            }
            .navbar {
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center">Dashboard</h4>
            <a href="#"><i class="fas fa-home"></i> Home</a>
            <a href="/ListAccountStaff"><i class="fas fa-chart-bar"></i> Manager Account Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Account Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="#"><i class="fas fa-cog"></i> Settings</a>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container-fluid">
                    <h4>Admin Dashboard - List Products</h4>
                    <div class="ms-auto">
                        <span class="me-3">Admin</span>
                        <img src="https://via.placeholder.com/40" class="rounded-circle" alt="User">
                    </div>
                </div>
            </nav>

            <!-- Button to Create Product (Aligned Right) -->
            <div class="d-flex justify-content-end mb-3">
                <a href="createProduct.jsp">
                    <button class="btn btn-primary">Create Product</button>
                </a>
            </div>

            <!-- Products Table -->
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>ImportPrice</th>
                        <th>Total Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Iterate through the list of products -->
                    <c:forEach items="${list}" var="p">
                        <c:if test="${p.isDelete == 0}">
                            <tr>
                                <td>${p.productID}</td>
                                <td>${p.productName}</td>
                                <td>${p.price}</td>
                                <td>${p.importPrice}</td>
                                <td>${p.quantityProduct}</td>
                                <td>
                                    <a href="updateProduct?productID=${p.productID}">
                                        <button class="btn btn-warning">Cập nhật</button>
                                    </a>
                                    <a href="deleteProduct?productID=${p.productID}" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                        <button class="btn btn-danger">Xóa</button>
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
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
