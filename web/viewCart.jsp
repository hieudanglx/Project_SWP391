<%-- 
    Document   : viewCart
    Created on : Feb 24, 2025, 5:56:12 PM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <style>
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                font-family: Arial, sans-serif;
            }

            .cart-section {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 30px;
            }

            .cart-items {
                border: 1px solid #eee;
                border-radius: 8px;
                padding: 20px;
            }

            .cart-item {
                display: flex;
                gap: 20px;
                padding: 15px;
                border-bottom: 1px solid #eee;
            }

            .item-image {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 4px;
            }

            .item-info {
                flex-grow: 1;
            }

            .item-price {
                color: #e91e63;
                font-weight: bold;
            }

            .remove-btn {
                color: #ff4444;
                cursor: pointer;
                background: none;
                border: none;
                padding: 5px;
            }

            .summary-section {
                background: #f5f5f5;
                padding: 20px;
                border-radius: 8px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .payment-method {
                margin: 15px 0;
                padding: 10px;
                background: white;
                border-radius: 4px;
            }

            .checkout-btn {
                width: 100%;
                padding: 12px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <h1>Giỏ hàng của bạn</h1>

            <div class="cart-section">
                <!-- Phần danh sách sản phẩm -->
                <div class="cart-items">
                    <c:forEach items="${list}" var="item">
                        <div class="cart-item">
                            <img src="${item.imageURL}" alt="${item.productName}" class="item-image">
                            <div class="item-info">
                                <h3>${item.productName}</h3>
                                <p>Màu: ${item.color}</p>
                                <p class="item-price">${item.price}đ</p>
                            </div>
                            <button class="remove-btn">Xóa</button>
                        </div>
                    </c:forEach>
                </div>

                <!-- Phần thanh toán -->
                <div class="summary-section">
                    <h3>Tổng cộng (${list.size()} sản phẩm)</h3>

                    <!-- Thông tin giao hàng -->
                    <div class="form-group">
                        <label>Họ tên</label>
                        <input type="text" required>
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ nhận hàng</label>
                        <input type="text" placeholder="Tìm thành phố" required>
                    </div>

                    <div class="form-group">
                        <input type="text" placeholder="Quận/Huyện" required>
                    </div>

                    <!-- Hình thức thanh toán -->
                    <div class="payment-method">
                        <h4>Hình thức thanh toán</h4>
                        <div class="form-group">
                            <input type="radio" name="payment" id="bank" required>
                            <label for="bank">Chuyển khoản ngân hàng</label>
                        </div>
                        <div class="form-group">
                            <input type="radio" name="payment" id="cod">
                            <label for="cod">Thanh toán khi nhận hàng (COD)</label>
                        </div>
                    </div>

                    <button class="checkout-btn">Đặt hàng</button>
                </div>
            </div>
        </div>
    </body>
</html>
