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
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
                transition: background-color 0.3s;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 12px 20px;
                font-weight: bold;
                transition: background 0.3s;
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
            .profile-link {
                font-weight: bold;
                color: #343a40;
                text-decoration: none;
                margin-right: 15px;
            }
            .profile-link:hover {
                color: #007bff;
            }
            .logout-link {
                color: red;
                font-weight: bold;
                cursor: pointer;
            }
            .table-responsive {
                background: white;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.05);
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
            <a href="#"><i class="fas fa-cog"></i> Manager feedback</a>
        </div>

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <div class="navbar-custom">
                <h3>Manage Customer Accounts</h3>
                <div class="search-container">
                    <input type="text" class="form-control w-50 me-2" placeholder="Search">
                    <button class="btn btn-primary">Search</button>
                </div>
                <div>
                    <a href="ManagerProfile.jsp" class="profile-link">Admin</a>
                    <a href="javascript:void(0);" class="logout-link" onclick="logout()">Logout</a>
                </div>
            </div>

            <!-- Customer List -->


            <div class="table-responsive">
                <table class="table table-striped table-center">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Phone</th>
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
                                <td>
                                    <span class="badge ${customer.status == 0 ? 'bg-success' : 'bg-danger'}">
                                        ${customer.status == 0 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty customer.imgCustomer}">
                                            <img src="${customer.imgCustomer}" alt="Customer Image" class="rounded" style="width: 50px; height: 50px;">
                                        </c:when>
                                        <c:otherwise>
                                            <span>No Image</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="editCustomer?id=${customer.customerID}" class="btn btn-warning btn-sm">
                                        ${customer.status == 0 ? 'Block' : 'Unblock'}
                                    </a>
                                    <a href="DeletCustomerAccount?customerID=${customer.customerID}" 
                                       onclick="return confirm('Are you sure you want to delete this customer member?');"
                                       class="btn btn-danger btn-sm">Delete</a>
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
                                alert('Logout Failed!');
                            }
                        })
                        .catch(error => console.error('Logout Error:', error));
            }
        </script>

    </body>
</html>
