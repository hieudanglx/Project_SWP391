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


        <!-- Products Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Category</th>
                    <th>Brand</th>
                    <th>Camera</th>
                    <th>RAM</th>
                    <th>ROM</th>
                    <th>Color</th>
                    <th>OS</th>
                    <th>Size</th>
                    <th>Refresh Rate</th>
                    <th>Chip</th>
                    <th>GPU</th>
                    <th>Quantity Sold</th>
                    <th>Total Quantity</th>
                    <th>Image</th>
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
                        <td>${p.category}</td>
                        <td>${p.brand}</td>
                        <td>${p.camera}</td>
                        <td>${p.ram}</td>
                        <td>${p.rom}</td>
                        <td>${p.color}</td>
                        <td>${p.operatingSystem}</td>
                        <td>${p.size}</td>
                        <td>${p.refreshRate}</td>
                        <td>${p.chip}</td>
                        <td>${p.gpu}</td>
                        <td>${p.quantitySell}</td>
                        <td>${p.quantityProduct}</td>

                        <td>
                            <c:if test="${not empty p.imageURL}">
                                <img src="${p.imageURL}" alt="${p.productName}" style="width: 100px; height: auto;">
                            </c:if>
                            <c:if test="${empty p.imageURL}">
                                <span>No Image</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="updateProduct.jsp?productID=${p.productID}">
                                <button>Cập nhật</button>
                            </a>
                            <a href="deleteProduct?productID=${p.productID}" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                <button style="background-color: red; color: white;">Xóa</button>
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
