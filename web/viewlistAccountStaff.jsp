<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - List Staff</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 12px 20px;
                font-weight: bold;
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
            .table-responsive {
                background: white;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.05);
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff">Manage Staff</a>
            <a href="listAccountCustomer">Manage Customer</a>
            <a href="listProductsForAdmin">Manage Products</a>
            <a href="feedback">Manage Feedback</a>
        </div>
        <div class="content">
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
                    <a href="ManagerProfile.jsp" class="profile-link">Admin</a>
                    <a href="javascript:void(0);" class="logout-link" onclick="logout()">Logout</a>
                </div>
            </div>
            <div class="d-flex justify-content-end mb-3">
                <a href="Create_account_staff.jsp" class="btn btn-primary">Create Staff</a>
            </div>
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
