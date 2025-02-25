<%-- 
    Document   : manageAccountCustomer
    Created on : Feb 25, 2025, 1:44:44 AM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Account Customer</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                display: flex;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px 20px;
            }
            .sidebar a:hover {
                background: #495057;
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
            }
        </style>
    </head>
    <body>
        
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center">Dashboard</h4>
            <a href="HomeDashBoard_Admin.jsp">Home</a>
            <a href="ListAccountStaff">Manager Account Staff</a>
            <a href="listAccountCustomer">Manage Account Customer</a>
            <a href="listProductsForAdmin">Manage Products</a>
            <a href="settings.jsp">Settings</a>
            <a href="logout.jsp" class="btn btn-danger w-100 mt-3">Logout</a>
        </div>
        
        <!-- Main Content -->
        <div class="content">
            
            <!-- Navbar -->
            <div class="navbar-custom d-flex justify-content-between align-items-center">
                <h3>Welcome to Dashboard</h3>
                <div class="d-flex">
                    <input type="text" class="form-control me-2" placeholder="Search">
                    <button class="btn btn-primary">Search</button>
                </div>
                
            </div>
            
            <!-- Staff List -->
            <div class="container mt-4">
                <h2 class="text-center">Staff Account List</h2>

                <!-- Button to Create New Staff -->
                <div class="d-flex justify-content-end mb-3">
                    <a href="createStaff.jsp">
                        <button class="btn btn-primary">Create Staff</button>
                    </a>
                </div>

            <table class="table table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th>Status</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="customer">
                        <tr>
                            <td>${customer.customerID}</td>
                            <td>${customer.username}</td>
                            <td>${customer.email}</td>
                            <td>${customer.address}</td>
                            <td>${customer.phoneNumber}</td>
                            <td>${customer.status == 0 ? "Active" : "Inactive"}</td>
                            <td>
                                <c:if test="${not empty customer.imgCustomer}">
                                    <img src="${customer.imgCustomer}" alt="Customer Image" style="width: 50px; height: auto;">
                                </c:if>
                                <c:if test="${empty customer.imgCustomer}">
                                    <span>No Image</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="editCustomer?id=${customer.customerID}" class="btn btn-warning btn-sm">Block/UnBlock</a>
                                <a href="DeletCustomerAccount?customerID=${customer.customerID}" onclick="return confirm('Are you sure you want to delete this customer member?');"
                                   class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>


    </body>
</html>
