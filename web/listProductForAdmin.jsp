<%-- 
    Document   : listProduct
    Created on : Feb 22, 2025
    Author     : Tran Phong Hai - CE180803
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - List Products</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>


        <!-- Button to Create Product (Aligned Right) -->
<div class="d-flex justify-content-end mb-3">
    <a href="createProduct.jsp">
        <button class="btn btn-primary">Create Product</button>
    </a>
</div>

<!-- Products Table -->
<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>ImportPrice</th>
            <th>Total Quantity</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <!-- Iterate through the list of products -->
        <c:forEach items="${list}" var="p">
            <tr>
                <td>${p.productID}</td>
                <td>${p.productName}</td>
                <td>${p.price}</td>
                <td>${p.importPrice}</td>
                <td>${p.quantityProduct}</td>
                <td>
                    <a href="updateProduct.jsp?productID=${p.productID}">
                        <button class="btn btn-warning">Cập nhật</button>
                    </a>
                    <a href="deleteProduct?productID=${p.productID}" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                        <button class="btn btn-danger">Xóa</button>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    </div>

    <!-- Bootstrap JS and dependencies -->

</body>
</html>
