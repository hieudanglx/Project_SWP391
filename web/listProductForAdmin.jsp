<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            .table-responsive {
                background-color: white;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
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
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4>Admin Dashboard - List Products</h4>
                <div>
                    <a href="ManagerProfile.jsp" class="profile-link">${sessionScope.Username}</a>
                    <a href="javascript:void(0);" class="logout-link" onclick="logout()">Logout</a>
                </div>
            </nav>            
            <!-- Button to Create Product -->
            <div class="d-flex justify-content-end mb-3">
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        Create Product
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <li><a class="dropdown-item" href="createProduct.jsp?category=2">Phone </a></li>
                        <li><a class="dropdown-item" href="createTablet.jsp?category=3">Tablet </a></li>
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
                                           class="btn btn-danger btn-sm">Xóa</a>
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
