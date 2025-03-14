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
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
            }

            /* Sidebar */
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
                padding: 12px 20px;
                font-weight: bold;
                transition: all 0.3s;
            }
            .sidebar a:hover {
                background: #495057;
                padding-left: 25px;
            }

            /* Main Content */
            .content {
                margin-left: 250px;
                width: calc(100% - 250px);
                padding: 20px;
            }

            /* Navbar */
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

            /* Table */
            .table-responsive {
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.05);
            }
            .table th, .table td {
                text-align: center;
                vertical-align: middle;
            }
            .table img {
                border-radius: 50%;
            }

            /* Buttons */
            .btn-action {
                padding: 5px 10px;
                border-radius: 5px;
            }
        </style>
    </head>

    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-user-tie"></i> Manage Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customers</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="feedback"><i class="fas fa-comment-dots"></i> Manage Feedback</a>
        </div>

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
                    <a href="ManagerProfile.jsp" class="profile-link">Admin</a>
                    <a href="javascript:void(0);" class="logout-link text-danger fw-bold" onclick="logout()">Logout</a>
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
