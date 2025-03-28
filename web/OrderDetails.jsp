<<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">

        <style>
            .OrderDetails{
            body {
                background: linear-gradient(to right, #f8f9fa, #e9ecef);
                font-family: 'Arial', sans-serif;
            }
            .container {
                max-width: 850px;
                margin: 30px auto;
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            }
            .logo-container {
                text-align: center;
                margin-bottom: 15px;
            }
            .logo-container img {
                max-width: 150px;
                height: auto;
            }
            .order-container h4 {
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 15px;
                color: #333;
            }
            .status-badge {
                display: inline-block;
                padding: 8px 12px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: bold;
            }
            .status-success { background-color: #28a745 !important; color: white !important; }
            .status-cancelled { background-color: #dc3545 !important; color: white !important; }
            .status-pending { background-color: #ffc107 !important; color: black !important; }

            .info-box {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-top: 15px;
                border-left: 5px solid #007bff;
            }
            .info-box h5 {
                font-size: 18px;
                font-weight: bold;
                color: #333;
                margin-bottom: 8px;
            }
            .product-item {
                display: flex;
                align-items: center;
                padding: 10px;
                background: #ffffff;
                border-radius: 10px;
                transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
                margin-bottom: 10px;
                border: 1px solid #ddd;
            }
            .product-item:hover {
                transform: scale(1.02);
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.15);
            }
            .product-item img {
                width: 90px;
                height: 90px;
                object-fit: cover;
                border-radius: 8px;
            }
            .product-info {
                flex-grow: 1;
                margin-left: 15px;
            }
            .product-info h6 {
                font-size: 16px;
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
            }
            .product-info p {
                font-size: 14px;
                color: #555;
                margin: 0;
            }
            .price-column {
                min-width: 120px;
                text-align: right;
                font-weight: bold;
                color: #d9534f;
                font-size: 16px;
            }
            .text-end strong {
                font-size: 20px;
                color: #d9534f;
            }
            .btn-warning {
                background: linear-gradient(to right, #f6c23e, #f39c12);
                border: none;
                font-weight: bold;
                padding: 12px 18px;
                border-radius: 6px;
                text-transform: uppercase;
                transition: all 0.3s ease-in-out;
                box-shadow: 2px 3px 8px rgba(0, 0, 0, 0.2);
            }
            .btn-warning:hover {
                background: linear-gradient(to right, #f39c12, #e67e22);
                transform: translateY(-2px);
                box-shadow: 3px 5px 12px rgba(0, 0, 0, 0.3);
            }
            }
        </style>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="OrderDetails container">
            <!-- LOGO SHOP -->
            
            <div class="order-container">

                <h4>Chi tiết đơn hàng #${orderDetails[0].orderID} - 
                    <c:choose>
                        <c:when test="${orderDetails[0].status eq 'Thành Công'}">
                            <span class="status-badge status-success">${orderDetails[0].status}</span>
                        </c:when>
                        <c:when test="${orderDetails[0].status eq 'Đã Hủy'}">
                            <span class="status-badge status-cancelled">${orderDetails[0].status}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-pending">${orderDetails[0].status}</span>
                        </c:otherwise>
                    </c:choose>
                </h4>
                <p>Đặt lúc: <strong>${orderDetails[0].date}</strong></p>

                <div class="info-box">
                    <h5>THÔNG TIN NHẬN HÀNG</h5>
                    <p><strong>Người nhận:</strong> ${orderDetails[0].customerName} - ${orderDetails[0].phoneNumber}</p>
                    <p><strong>Địa chỉ:</strong> ${orderDetails[0].address}</p>
                </div>

                <div class="info-box">
                    <h5>THÔNG TIN SẢN PHẨM</h5>

                    <!-- Header sản phẩm -->
                    <div class="d-flex justify-content-between fw-bold p-2 bg-light">
                        <div style="flex: 2;">Sản phẩm</div>
                        <div class="price-column">Giá</div>
                    </div>

                    <c:forEach items="${orderDetails}" var="item">
                        <div class="product-item">
                            <img src="${item.imageURL}" alt="Product Image">
                            <div class="product-info">
                                <h6>${item.productName}</h6>
                                <p>Số lượng: <strong>${item.quantity}</strong></p>
                            </div>  
                            <div class="price-column">
                               <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ
                            </div>               
                        </div>
                    </c:forEach>
                </div>

                <!-- Tổng tiền -->
                <div class="d-flex justify-content-between mt-3 p-2 bg-light fw-bold">
                    <div style="flex: 2; text-align: right;">Tổng tiền:</div>
                    <div class="price-column">
                        <fmt:formatNumber value="${orderDetails[0].total *1}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ
                    </div>
                </div>

               

            </div>
        </div>
<%@include file="footer.jsp" %>
    </body>
</html>