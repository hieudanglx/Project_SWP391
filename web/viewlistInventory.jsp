<%-- 
    Document   : viewlistInventory
    Created on : Mar 9, 2025, 6:37:09 PM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="importList" scope="request" type="java.util.List<model.Inventory>" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inventory List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                display: flex;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: #343a40;
                color: white;
                padding: 15px;
                position: fixed;
            }
            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                padding: 10px;
                margin: 5px 0;
            }
            .sidebar a:hover {
                background: #495057;
            }
            .content {
                margin-left: 260px;
                padding: 20px;
                width: 100%;
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
            .search-container {
                display: flex;
                justify-content: center;
                flex-grow: 1;
            }
            .search-container input {
                width: 300px;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-users"></i> Manager Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-user"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-box"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-cog"></i> Manager Feedback</a>
            <a href="Revenue"><i class="fas fa-cog"></i> Manager Revenue</a>
            <a href="ListInventory"><i class="fas fa-cog"></i> Manager Inventory</a>
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
                    <a href="ManagerProfile.jsp" class="profile-link">Admin</a>
                    <a href="javascript:void(0);" class="logout-link text-danger fw-bold" onclick="logout()">Logout</a>
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
            <table class="table table-bordered table-hover text-center mt-3">
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
                                <td colspan="10">No inventory data available.</td>
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
                                        <a href="ImportInventory?productID=${inventory.productID}" class="btn btn-warning btn-sm">
                                            Import Product
                                        </a>
                                        <a href="ImportHistory?productID=${inventory.productID}" class="btn btn-primary btn-sm">Xem chi tiết</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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
