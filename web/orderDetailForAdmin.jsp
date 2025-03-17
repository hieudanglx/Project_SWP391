<%-- 
    Document   : orderDetailForAdmin
    Created on : Mar 15, 2025, 1:26:55 AM
    Author     : Dinh Van Do - CE182224
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết đơn hàng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            
            .container {
                background: #fff;
                padding: 25px;
                width: 85%;
                max-width: 900px;
                border-radius: 12px;
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
                margin: 30px 0;
            }
            
            h2 {
                color: #2c3e50;
                text-align: center;
                margin-bottom: 25px;
                font-size: 28px;
                position: relative;
                padding-bottom: 10px;
            }
            
            h2:after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(to right, #3498db, #2ecc71);
                border-radius: 2px;
            }
            
            .section {
                text-align: left;
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 8px;
                background: #f9f9f9;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                border-left: 5px solid #3498db;
            }
            
            .section h3 {
                color: #3498db;
                margin-top: 0;
                margin-bottom: 15px;
                font-size: 20px;
                display: flex;
                align-items: center;
            }
            
            .section h3:before {
                font-family: "Font Awesome 5 Free";
                font-weight: 900;
                margin-right: 10px;
                font-size: 18px;
            }
            
            .section:nth-child(2) h3:before {
                content: "\f007"; /* user icon */
                color: #3498db;
            }
            
            .section:nth-child(3) h3:before {
                content: "\f2bb"; /* id card icon */
                color: #9b59b6;
            }
            
            .section p {
                margin: 8px 0;
                line-height: 1.6;
            }
            
            .section p strong {
                display: inline-block;
                width: 150px;
                color: #555;
            }
            
            .order-status {
                font-size: 18px;
                font-weight: bold;
                padding: 8px 15px;
                border-radius: 30px;
                display: inline-block;
            }
            
            .pending {
                background-color: #fff3cd;
                color: #856404;
            }
            
            .shipping {
                background-color: #cce5ff;
                color: #004085;
            }
            
            .canceled {
                background-color: #f8d7da;
                color: #721c24;
            }
            
            .success {
                background-color: #d4edda;
                color: #155724;
            }
            
            .total-price {
                font-size: 22px;
                font-weight: bold;
                color: #e74c3c;
                margin-top: 15px;
                text-align: right;
                padding: 10px 15px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                display: inline-flex;
                align-items: center;
            }
            
            .total-price:before {
                font-family: "Font Awesome 5 Free";
                content: "\f3d1"; /* money bill icon */
                margin-right: 10px;
                font-weight: 900;
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                border-radius: 8px;
            }
            
            th, td {
                padding: 12px 15px;
                text-align: left;
            }
            
            th {
                background: linear-gradient(to right, #3498db, #2980b9);
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 14px;
                letter-spacing: 0.5px;
            }
            
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            
            tr:hover {
                background-color: #f5f5f5;
            }
            
            .order-info {
                text-align: center;
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                margin-top: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                border-left: 5px solid #e74c3c;
            }
            
            .order-info h3 {
                color: #e74c3c;
                margin-top: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .order-info h3:before {
                font-family: "Font Awesome 5 Free";
                content: "\f05a"; /* info icon */
                margin-right: 10px;
                font-weight: 900;
            }
            
            @media (max-width: 768px) {
                .container {
                    width: 95%;
                    padding: 15px;
                }
                
                .section {
                    padding: 15px;
                }
                
                .section p strong {
                    display: block;
                    margin-bottom: 5px;
                }
                
                table {
                    display: block;
                    overflow-x: auto;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Chi tiết đơn hàng</h2>

            <!-- Thông tin khách hàng -->
            <div class="section">
                <h3>Thông tin khách hàng</h3>
                <p><strong>Khách hàng:</strong> ${orderDetails[0].fullNameCustomer}</p>
                <p><strong>Địa chỉ giao hàng:</strong> ${orderDetails[0].address}</p>
                <p><strong>Số điện thoại:</strong> ${orderDetails[0].phoneNumber}</p>
                <p><strong>Ngày đặt hàng:</strong> ${orderDetails[0].date}</p>
            </div>

            <!-- Nhân viên xử lý -->
            <div class="section">
                <h3>Nhân viên xử lý</h3>
                <p><strong>Tên nhân viên:</strong> 
                    <c:choose>
                        <c:when test="${empty orderDetails[0].fullNameStaff}">
                            Admin
                        </c:when>
                        <c:otherwise>
                            ${orderDetails[0].fullNameStaff}
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <!-- Bảng danh sách sản phẩm -->
            <table>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Màu sắc</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                </tr>
                <c:forEach var="orderDetail" items="${orderDetails}">
                    <tr>
                        <td>${orderDetail.productName}</td>
                        <td>
                            <span style="
                                display: inline-block;
                                width: 12px;
                                height: 12px;
                                border-radius: 50%;
                                background-color: ${orderDetail.color};
                                margin-right: 5px;
                                vertical-align: middle;
                                border: 1px solid #ddd;
                            "></span>
                            ${orderDetail.color}
                        </td>
                        <td>${orderDetail.price}</td>
                        <td>${orderDetail.quantity}</td>
                    </tr>
                </c:forEach>
            </table>

            <!-- Thông tin đơn hàng -->
            <div class="section order-info">
                <h3>Thông tin đơn hàng</h3>
                <p><strong>Trạng thái:</strong> 
                    <span class="order-status
                          <c:choose>
                              <c:when test='${orderDetails[0].status == "Chờ xử lý"}'>pending</c:when>
                              <c:when test='${orderDetails[0].status == "Giao Hàng"}'>shipping</c:when>
                              <c:when test='${orderDetails[0].status == "Đã Hủy"}'>canceled</c:when>
                              <c:when test='${orderDetails[0].status == "Thành công"}'>success</c:when>
                          </c:choose>">
                        <c:choose>
                            <c:when test='${orderDetails[0].status == "Chờ xử lý"}'><i class="fas fa-clock"></i> </c:when>
                            <c:when test='${orderDetails[0].status == "Giao Hàng"}'><i class="fas fa-shipping-fast"></i> </c:when>
                            <c:when test='${orderDetails[0].status == "Đã Hủy"}'><i class="fas fa-times-circle"></i> </c:when>
                            <c:when test='${orderDetails[0].status == "Thành công"}'><i class="fas fa-check-circle"></i> </c:when>
                        </c:choose>
                        ${orderDetails[0].status}
                    </span>
                </p>
                <p class="total-price">Tổng tiền: ${orderDetails[0].total} VNĐ</p>
            </div>
        </div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    </body>
</html>