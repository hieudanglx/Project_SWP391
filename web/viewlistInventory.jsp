<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="importList" scope="request" type="java.util.List<model.Inventory>" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inventory List</title>

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
            .search-container {
                display: flex;
                justify-content: center;
                flex-grow: 1;
            }
            .search-container input {
                width: 300px;
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
            <div class="navbar-custom">
                <h3>Manage Inventory</h3>
                <div class="search-container">
                    <form action="SearchInventory" method="GET" class="d-flex">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="Search product">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>
                <div>
                    <a href="ManagerProfile.jsp" class="btn btn-outline-secondary me-2">Admin</a>
                    <a href="javascript:void(0);" class="btn btn-danger" onclick="logout()">Logout</a>
                </div>
            </div>

            <!-- Filter Buttons -->
            <div class="filter-buttons mb-3">
                <form method="GET" action="ListInventory" style="display:inline;">
                    <button type="submit" name="filter" value="laptop" class="btn btn-primary">Laptop</button>
                </form>
                <form method="GET" action="ListInventory" style="display:inline;">
                    <button type="submit" name="filter" value="SmartPhone" class="btn btn-primary">SmartPhone</button>
                </form>
                <form method="GET" action="ListInventory" style="display:inline;">
                    <button type="submit" name="filter" value="Tablet" class="btn btn-primary">Tablet</button>
                </form>
            </div>

            <!-- Inventory Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Import Date</th>
                            <th>Sale Price</th>
                            <th>Import Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty importList}">
                                <tr>
                                    <td colspan="6">No inventory data available.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="inventory" items="${importList}">
                                    <tr>
                                        <td>${inventory.productID}</td>
                                        <td>${inventory.productName}</td>
                                        <td>${inventory.DATE}</td>
                                        <td>${inventory.price}</td>
                                        <td>${inventory.quantityProduct}</td>
                                        <td>
                                            <a href="importInventory?productID=${inventory.productID}" class="btn btn-warning btn-sm">
                                                Import Product
                                            </a>
                                            <a href="importHistory?productID=${inventory.productID}" class="btn btn-primary btn-sm">View Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Logout Script -->
        <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', {method: 'POST'})
                        .then(response => {
                            if (response.ok)
                                window.location.href = '/LoginOfDashboard.jsp';
                            else
                                alert('Logout Failed!');
                        });
            }
        </script>
    </body>
</html>
