<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - List Staff</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            <a href="listProduct.jsp">Manage Products</a>
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

                <!-- Staff Table -->
                <table class="table table-striped text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Username</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="s">
                            <tr>
                                <td>${s.staffID}</td>
                                <td>${s.fullName}</td>
                                <td>${s.email}</td>
                                <td>${s.phoneNumber}</td>
                                <td>${s.address}</td>
                                <td>${s.username}</td>
                                <td>${s.status == 0 ? "Active" : "Inactive"}</td>
                                <td>
                                    <a href="EditAccount_Staff?staffID=${s.staffID}">
                                        <button class="btn btn-warning">Update</button>
                                    </a>
                                    <a href="DeleteAccount_Staff?staffID=${s.staffID}" onclick="return confirm('Are you sure you want to delete this staff member?');">
                                        <button class="btn btn-danger">Delete</button>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>