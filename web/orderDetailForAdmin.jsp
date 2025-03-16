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
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }
            .container {
                background: #fff;
                padding: 20px;
                width: 80%;
                max-width: 900px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            h2 {
                color: #333;
            }
            .section {
                text-align: left;
                margin-bottom: 15px;
                padding: 15px;
                border-radius: 5px;
                background: #f9f9f9;
            }
            .order-status {
                font-size: 18px;
                font-weight: bold;
                padding: 10px;
                border-radius: 5px;
            }
            .pending {
                color: #ff9800;
            } /* Chờ xử lý - Màu cam */
            .shipping {
                color: #2196F3;
            } /* Giao Hàng - Màu xanh dương */
            .canceled {
                color: #f44336;
            } /* Đã Hủy - Màu đỏ */
            .success {
                color: #4CAF50;
            } /* Thành công - Màu xanh lá */
            .total-price {
                font-size: 20px;
                font-weight: bold;
                color: #d32f2f;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background: #2196F3;
                color: white;
            }

            .order-info {
                text-align: center;
                background: #ffeeba; /* Màu nền nhẹ */
                padding: 20px;
                border-radius: 8px;
                margin-top: 20px;
                font-size: 18px;
                font-weight: bold;
            }

            .total-price {
                font-size: 22px;
                font-weight: bold;
                color: #d32f2f;
                margin-top: 10px;
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
                        <td>${orderDetail.color}</td>
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
                        ${orderDetails[0].status}
                    </span>
                </p>
                <p class="total-price">Tổng tiền: ${orderDetails[0].total} VNĐ</p>
            </div>

        </div>
    </body>
</html>
