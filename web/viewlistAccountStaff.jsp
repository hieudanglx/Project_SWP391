<%-- 
    Document   : listStaff
    Created on : Feb 23, 2025
    Author     : Hiếu
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - List Staff</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%-- Kiểm tra danh sách staff --%>
        <div class="container mt-4">
            <h2 class="text-center">Staff Account List</h2>

            <!-- Button to Create New Staff (Aligned Right) -->
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
                    <!-- Iterate through the list of staff -->
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
