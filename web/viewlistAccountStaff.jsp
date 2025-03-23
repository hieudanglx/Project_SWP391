<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - List Staff</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
            }
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
            .content {
                margin-left: 250px;
                padding: 20px;
            }
            .navbar-custom {
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
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
            .alert-warning {
                background-color: #fff3cd;
                border-color: #ffeeba;
                color: #856404;
                padding: 10px;
                border-radius: 5px;
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
            <a href="/ListAccountStaff"><i class="fas fa-user-tie"></i> Manage Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-comments"></i> Manage Feedback</a>
            <a href="Revenue"><i class="fas fa-chart-line"></i> Manage Revenue</a>
            <a href="ListInventory"><i class="fas fa-warehouse"></i> Manage Inventory</a>
        </div>-->

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <div class="navbar-custom">
                <h3>Staff Account List</h3>
                <form action="SearchAccountStaff" method="get" class="d-flex">
                    <input type="text" name="fullname" placeholder="Search by Full Name" class="form-control me-2">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
                <% String message = (String) session.getAttribute("message"); %>
                <% if (message != null) { %>
                <div id="alert-box" class="alert alert-warning text-center">
                    <strong>Thông báo:</strong> <%= message %>
                </div>
                <% session.removeAttribute("message"); %>
                <% } %>
                <div>
                    <a href="ManagerProfile.jsp" class="btn btn-outline-secondary me-2">Admin</a>
                    <a href="javascript:void(0);" class="btn btn-danger" onclick="logout()">Logout</a>
                </div>
            </div>

            <!-- Create Staff Button -->
            <div class="d-flex justify-content-end mb-3">
                <a href="Create_account_staff.jsp" class="btn btn-primary">Create Staff</a>
            </div>

            <!-- Staff Table -->
            <div class="table-responsive">
                <table class="table table-striped text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>CCCD</th>
                            <th>Gender</th>
                            <th>BirthDay</th>
                            <th>Address</th>
                            <th>Province/City</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="s">
                            <c:if test="${s.username ne 'admin'}">
                                <tr>
                                    <td>${s.staffID}</td>
                                    <td>${s.fullName}</td>
                                    <td>${s.username}</td>
                                    <td>${s.cccd}</td>
                                    <td>${s.sex}</td>
                                    <td>${s.dob}</td>
                                    <td>${s.address}</td>
                                    <td>${s.province_city}</td>
                                    <td>${s.email}</td>
                                    <td>${s.phoneNumber}</td>          
                                    <td>${s.status == 0 ? "Active" : "Inactive"}</td>
                                    <td>
                                        <a href="EditAccountStaff_ForAdmin?staffID=${s.staffID}" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="DeleteAccount_Staff?staffID=${s.staffID}"
                                           onclick="return confirm('Are you sure you want to delete this staff member?');"
                                           class="btn btn-danger btn-sm">Delete</a>
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
