<%-- 
    Document   : view_import_detail
    Created on : Mar 16, 2025, 2:17:16 PM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết nhập hàng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: #343a40;
                color: white;
                position: fixed;
                padding: 20px;
            }
            .sidebar h4 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: bold;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px;
                border-radius: 5px;
                transition: 0.3s;
            }
            .sidebar a:hover {
                background: #007bff;
            }
            .sidebar i {
                margin-right: 10px;
            }
            .content {
                margin-left: 270px;
                padding: 20px;
            }
            .table-container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .table th {
                background-color: #007bff !important;
                color: white;
            }
            .search-box {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4>📊 Dashboard</h4>
            <a href="#"><i class="fas fa-users"></i> Manager Staff</a>
            <a href="#"><i class="fas fa-user"></i> Manage Customer</a>
            <a href="#"><i class="fas fa-box"></i> Manage Products</a>
            <a href="#"><i class="fas fa-comments"></i> Manager Feedback</a>
            <a href="#"><i class="fas fa-chart-line"></i> Manager Revenue</a>
            <a href="#"><i class="fas fa-warehouse"></i> Manager Inventory</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <h2 class="text-center">📦 Chi Tiết Nhập Hàng</h2>

            <!-- Search Box -->
            <div class="search-box">
                <input type="text" class="form-control w-25" placeholder="🔍 Tìm kiếm sản phẩm">
            </div>

            <!-- Table -->
            <div class="table-container">
                <table class="table table-bordered table-hover text-center">
                    <thead>
                        <tr>
                            <th>Mã Sản Phẩm</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Thương Hiệu</th>
                            <th>Giá Nhập (VND)</th>
                            <th>Số Lượng Nhập</th>
                            <th>Ngày Nhập</th>
                            <th>Nhà Cung Cấp</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty importHistory}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted">📭 Không có dữ liệu nhập.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="inventory" items="${importHistory}">
                                    <tr>
                                        <td><strong>${inventory.productID}</strong></td>
                                        <td>${inventory.productName}</td>
                                        <td>${inventory.brand}</td>
                                        <td class="text-danger fw-bold">${inventory.import_price}</td>
                                        <td class="text-primary">${inventory.import_quantity}</td>
                                        <td>${inventory.DATE}</td>
                                        <td>${inventory.supplier}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
