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
        <title>Dashboard</title>
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
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
            <a href="listProductsForAdmin"><i class="fas fa-box"></i>Manage Products</a>
            <a href="#"><i class="fas fa-cog"></i> Manager feedback</a>


        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container-fluid">
                    <h4>Welcome to Dashboard Admin</h4>

                    <!-- Thêm lớp mx-auto để căn giữa thanh search -->
                    <div class="mx-auto">
                        <div class="d-flex">
                            <input type="text" class="form-control me-2" placeholder="Search">
                            <button class="btn btn-primary">Search</button>
                        </div>
                    </div>

                    <div class="ms-auto">
                        <a href="ManagerProfile.jsp" class="text-decoration-none text-dark me-3 fw-bold"> ${sessionScope.fullname}</a>
                        <a href="javascript:void(0);" class="text-lg-startr fw-bold" onclick="logout()">Logout</a>
                    </div>
                </div>
            </nav>

            <!-- Dashboard Cards -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Total Users</h5>
                        <p class="fs-4">1,250</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Total Sales</h5>
                        <p class="fs-4">$12,500</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Products Sold</h5>
                        <p class="fs-4">3,420</p>
                    </div>
                </div>
            </div>

    </body>
    <script>
        function logout() {
            fetch('/LogOutStaffAndAdminController', {method: 'POST'})  // Gọi model
                    .then(response => {
                        if (response.ok) {
                            window.location.href = '/LoginOfDashboard.jsp';  // Chuyển về trang login
                        } else {
                            alert('Logout Fail!.');
                        }
                    })
                    .catch(error => console.error('logout Error:', error));
        }
    </script>
</html>


