<%-- 
    Document   : checkout
    Created on : Mar 17, 2025, 2:34:36 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                height: 100vh;
            }

            .container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 50%;
                margin-top: 20px;
            }

            h2 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                font-weight: bold;
                margin-top: 10px;
            }

            input[type="text"], input[type="tel"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 20px;
            }

            button:hover {
                background-color: #218838;
            }


        </style>
    </head>
    <body>

        <h2>Thông tin thanh toán</h2>
        <div>
            <form action="PaymentController" method="post">
                <label>Họ và tên:</label>
                <input type="text" name="fullname" value="${sessionScope.customer.fullName}" readonly><br>

                <label>Số điện thoại:</label>
                <input type="tel" name="phone" value="${sessionScope.customer.phoneNumber}" readonly><br>

                <label>Địa chỉ giao hàng:</label>
                <input type="text" name="address" value="${sessionScope.selectedAddress}" readonly><br>

                <h3>Sản phẩm trong giỏ hàng</h3>
                <table>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                    </tr>
                    <c:set var="total" value="0"/>
                    <c:forEach var="product" items="${cart}">
                        <tr>
                            <td>${product.productName}</td>
                            <td><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VNĐ</td>
                            <td>${product.quantityProduct}</td>
                            <td><fmt:formatNumber value="${product.price * product.quantityProduct}" type="number" groupingUsed="true"/> VNĐ</td>
                        </tr>
                        <c:set var="total" value="${total + (product.price * product.quantityProduct)}"/>
                    </c:forEach>
                </table>
                <h3>Tổng cộng: <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VNĐ</h3>

                <h3>Chọn phương thức thanh toán</h3>
                <input type="radio" name="paymentMethod" value="COD" checked> Thanh toán khi nhận hàng (COD)<br>
                <input type="radio" name="paymentMethod" value="VNPAY"> Thanh toán qua VNPAY<br>

                <button type="submit">Xác nhận thanh toán</button>
            </form>
        </div>
    </body>
</body>
</html>
