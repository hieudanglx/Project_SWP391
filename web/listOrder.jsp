<%-- 
    Document   : listOrder
    Created on : Mar 11, 2025, 3:49:24 PM
    Author     : Dinh Van Do - CE182224
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - List Orders</title>
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
                <h4>Admin Dashboard - List Orders</h4>
                <div>
                    <a href="ManagerProfile.jsp" class="profile-link">Admin</a>
                    <a href="javascript:void(0);" class="logout-link" onclick="logout()">Logout</a>
                </div>
            </nav>            
            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="filterStatusDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    Lọc theo trạng thái
                </button>
                <ul class="dropdown-menu" aria-labelledby="filterStatusDropdown">
                    <li><a class="dropdown-item" href="filterStatus">Tất cả</a></li>
                    <li><a class="dropdown-item" href="filterStatus?status=Chờ xử lý">Chờ xử lý</a></li>
                    <li><a class="dropdown-item" href="filterStatus?status=Giao Hàng">Giao Hàng</a></li>
                    <li><a class="dropdown-item" href="filterStatus?status=Đã Hủy">Đã Hủy</a></li>
                    <li><a class="dropdown-item" href="filterStatus?status=Thành công">Thành công</a></li>
                </ul>
            </div>

            <!-- Orders Table -->
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>OrderID</th>
                            <th>CustomerID</th>
                            <th>StaffID</th>
                            <th>Address</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>PhoneNumber</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through the list of orders -->
                        <c:forEach items="${list}" var="order">
                            <tr>
                                <td>${order.orderID}</td>
                                <td>${order.customerID}</td>
                                <td>${order.staffID}</td>
                                <td>${order.address}</td>
                                <td>${order.date}</td>
                                <td>${order.status}</td>
                                <td>${order.phoneNumber}</td>
                                <td><fmt:formatNumber value="${order.total}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ</td>
                                <td>
                                    <a href="orderDetailForAdmin?orderID=${order.orderID}" class="btn btn-warning btn-sm">Detail</a>
                                    <c:if test="${order.status == 'Chờ xử lý'}">
                                        <a href="changeStatus?orderID=${order.orderID}&status=Giao Hàng" class="btn btn-success btn-sm">Xác nhận đơn hàng</a>
                                    </c:if>


                                    <c:if test="${order.status == 'Giao Hàng'}">
                                        <a href="changeStatus?orderID=${order.orderID}&status=Đã Hủy" class="btn btn-danger btn-sm">Hủy đơn hàng</a>
                                    </c:if>
                                </td>
                            </tr>
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