<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Registration</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
        <div class="card p-5 shadow-lg" style="width: 600px;">
            <h3 class="text-center mb-4">Staff Registration</h3>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <c:if test="${not empty errorMessage}">
                <p class="alert alert-danger">${errorMessage}</p>
            </c:if>

            <form action="CreateAccountStaff" method="POST">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName}" required>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="${username}" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                </div>
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${phoneNumber}" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address" value="${address}" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" value="${password}" required>
                </div>
                <div class="mb-3">
                    <label for="cccd" class="form-label">CCCD:</label>
                    <input type="text" class="form-control" id="cccd" name="cccd" value="${staff.cccd}" required>
                </div>
                <div class="mb-3">
                    <label for="status" class="form-label">Status:</label>
                    <select class="form-select" id="status" name="status">
                        <option value="0" ${status == 0 ? 'selected' : ''}>Active</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between mt-3">
                    <button type="submit" class="btn btn-success flex-grow-1 me-2">Register Staff</button>
                    <a href="ListAccountStaff" class="btn btn-secondary flex-grow-1">Back to List</a>
                </div>
            </form>
        </div>
    </body>
</html>