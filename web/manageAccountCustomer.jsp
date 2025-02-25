<%-- 
    Document   : manageAccountCustomer
    Created on : Feb 25, 2025, 1:44:44 AM
    Author     : Tran Phong Hai - CE180803
--%>

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
</head>
<body>
    <div class="container mt-4">
    <h2 class="text-center">Manage Account Customer</h2>

    <!-- Form tìm kiếm -->
    <!-- Form tìm kiếm Account Customer theo username -->
<form action="SearchAccountCustomer" method="Post" class="mb-4">
    <div class="input-group">
        <input type="text" name="username" class="form-control" placeholder="Nhập username..." >
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
    </div>
</form>

<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Address</th>
            <th>Phone Number</th>
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
                <td>${customer.status == 0 ? "Active" : "Inactive"}</td>
                <td>
                    <c:if test="${not empty customer.imgCustomer}">
                        <img src="${customer.imgCustomer}" alt="Customer Image" style="width: 50px; height: auto;">
                    </c:if>
                    <c:if test="${empty customer.imgCustomer}">
                        <span>No Image</span>
                    </c:if>
                </td>
                <td>
                    <a href="editCustomer?id=${customer.customerID}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="DeletCustomerAccount?customerID=${customer.customerID}" onclick="return confirm('Are you sure you want to delete this customer member?');"
                    class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>


</body>
</html>
