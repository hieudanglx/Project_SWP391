<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Account Customer</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
            .table img {
                border-radius: 50%;
            }

            /* Buttons */
            .btn-action {
                padding: 5px 10px;
                border-radius: 5px;
            }
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
            .btn-success {
                background-color: #198754;
                border-color: #198754;
                padding: 8px 16px;
                font-weight: 600;
            }
            .btn-success:hover {
                background-color: #157347;
                border-color: #146c43;
            }
            .badge {
                padding: 8px 12px;
                border-radius: 5px;
            }
            .bg-success {
                background-color: #198754 !important;
            }
            .bg-danger {
                background-color: #dc3545 !important;
            }
        </style>
    </head>

    <body>
         <jsp:include page="sidebar.jsp" />
        <!-- Sidebar -->
<!--        <div class="sidebar">
            <h4 class="text-center mb-4">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-chart-bar"></i> Manager Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-comment-dots"></i> Manage Feedback</a>
            <a href="Revenue"><i class="fas fa-chart-line"></i> Manage Revenue</a>
            <a href="ListInventory"><i class="fas fa-warehouse"></i> Manage Inventory</a>
        </div>-->

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <div class="navbar-custom">
                <h3>Manage Customer Accounts</h3>
                <div class="search-container">
                    <form action="SearchAccountCustomer" method="POST" class="d-flex">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="Search username">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>

                <div>
                    <a href="ManagerProfile.jsp" class="btn btn-outline-secondary me-2">Admin</a>
                    <a href="javascript:void(0);" class="btn btn-danger" onclick="logout()">Logout</a>
                </div>
            </div>

            <!-- Hiển thị thông báo bằng SweetAlert2 -->
            <% String message = (String) session.getAttribute("message"); %>
            <% if (message != null) { %>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        title: "Thông báo!",
                        text: "<%= message %>",
                        icon: "warning",
                        confirmButtonText: "OK"
                    });
                });
            </script>
            <% session.removeAttribute("message"); %>
            <% } %>

            <!-- Table -->
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Fullname</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>BirthDay</th>
                            <th>Status</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="customer">
                            <c:if test="${customer.customerID != 0}">
                            <tr>
                                <td>${customer.customerID}</td>
                                <td>${customer.username}</td>
                                <td>${customer.fullName}</td>
                                <td>${customer.email}</td>
                                <td>${customer.address}</td>                               
                                <td>${customer.phoneNumber}</td>
                                <td>${customer.sex}</td>
                                <td>${customer.dob}</td>
                                <td>
                                    <span class="badge ${customer.status == 0 ? 'bg-success' : 'bg-danger'}">
                                        ${customer.status == 0 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty customer.imgCustomer}">
                                            <img src="${customer.imgCustomer}" alt="Customer Image" style="width: 50px; height: 50px;">
                                        </c:when>
                                        <c:otherwise>
                                            <span>No Image</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>              
                                    <div class="d-flex align-items-center justify-content-center">
                                        <form action="UpdateStatusCustomer" method="POST" class="me-2">
                                            <input type="hidden" name="customerID" value="${customer.customerID}">
                                            <input type="hidden" name="status" value="${customer.status}">
                                            <button type="submit" class="btn btn-${customer.status == 0 ? 'danger' : 'success'} btn-sm">
                                                ${customer.status == 0 ? 'Block' : 'Unblock'}
                                            </button>
                                        </form>
                                        <a href="DeletCustomerAccount?customerID=${customer.customerID}" class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này không?')">
                                            Delete
                                        </a>
                                    </div>
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
                            if (response.ok)
                                window.location.href = '/LoginOfDashboard.jsp';
                            else
                                alert('Logout Failed!');
                        });
            }
        </script>

    </body>
</html>
