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
            /* Navbar */
            .navbar-custom {
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            /* Sidebar */
            .sidebar {
                height: 100vh;
                width: 250px;
                background: linear-gradient(to bottom, #343a40, #212529);
                color: white;
                position: fixed;
                padding-top: 20px;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }
            .sidebar a {
                padding: 12px 20px;
                text-decoration: none;
                font-size: 16px;
                color: rgba(255, 255, 255, 0.8);
                display: block;
                transition: all 0.3s;
                border-left: 4px solid transparent;
            }
            .sidebar a:hover {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border-left: 4px solid #0d6efd;
            }
            .sidebar a i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
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
            <h4 class="text-center mb-4">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-user-tie"></i> Manage Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-comment-dots"></i> Manage Feedback</a>
            <a href="Revenue"><i class="fas fa-chart-line"></i> Manage Revenue</a>
            <a href="ListInventory"><i class="fas fa-warehouse"></i> Manage Inventory</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <div class="navbar-custom">
                <h3>📦 Import Details</h3>
<!--                <div class="search-container">
                    <form action="SearchAccountCustomer" method="POST" class="d-flex">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="Search username">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>-->
                <div>
                    <a href="ManagerProfile.jsp" class="btn btn-outline-secondary me-2">Admin</a>
                    <a href="javascript:void(0);" class="btn btn-danger" onclick="logout()">Logout</a>
                </div>
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
      <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', {method: 'POST'})
                        .then(response => {
                            if (response.ok) {
                                window.location.href = '/LoginOfDashboard.jsp';
                            } else {
                                alert('Logout Failed!');
                            }
                        })
                        .catch(error => console.error('Logout Error:', error));
            }
            async function getRevenue() {
                try {
                    let response = await fetch("RevenueTotal"); // Gọi API
                    let data = await response.json(); // Chuyển response về JSON
                    console.log("Tổng doanh thu:", data.totalSales); // Log kết quả

                    // Hiển thị trên HTML
                    document.getElementById("totalRevenue").innerText = data.totalSales + " VND";
                } catch (error) {
                    console.error("Lỗi khi lấy doanh thu:", error);
                }
            }
            document.addEventListener("DOMContentLoaded", getRevenue);

        </script>

</html>
