<%-- 
    Document   : HomeDashBoard
    Created on : Feb 24, 2025, 8:13:02 PM
    Author     : Dang Khac Hieu_CE180465
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <h4 class="text-center">Dashboard</h4>
        <a href="#"><i class="fas fa-home"></i> Home</a>
        <a href="#"><i class="fas fa-chart-bar"></i> Analytics</a>
        <a href="#"><i class="fas fa-users"></i> Users</a>
        <a href="#"><i class="fas fa-box"></i> Products</a>
        <a href="#"><i class="fas fa-cog"></i> Settings</a>
        <a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
                <h4>Welcome to Dashboard</h4>
                <div class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-primary">Search</button>
                </div>
                <div class="ms-auto">
                    <span class="me-3">Admin</span>
                    <img src="https://via.placeholder.com/40" class="rounded-circle" alt="User">
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

        <!-- Recent Activities -->
        <div class="mt-4">
            <h5>Recent Activities</h5>
            <ul class="list-group">
                <li class="list-group-item">User <b>John</b> purchased <b>iPhone 14</b></li>
                <li class="list-group-item">User <b>Anna</b> registered an account</li>
                <li class="list-group-item">User <b>David</b> left a review on <b>Samsung Galaxy</b></li>
            </ul>
        </div>
    </div>

</body>
</html>

