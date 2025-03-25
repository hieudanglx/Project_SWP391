<%-- 
    Document   : HomeDashBoard_Staff
    Created on : Mar 24, 2025, 8:13:02 PM
    Author     : Enhanced Design Concept
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển quản lý</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4a4e69;
            --secondary-color: #9a8c98;
            --accent-color: #22223b;
            --background-color: #f2e9e4;
            --text-color: #22223b;
            --success-color: #2a9d8f;
            --warning-color: #e9c46a;
            --danger-color: #f4a261;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
            color: white;
            padding: 20px;
            transition: all 0.3s ease;
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            z-index: 1000;
        }

        .main-content {
            flex-grow: 1;
            margin-left: 280px;
            padding: 30px;
            background-color: var(--background-color);
            transition: margin-left 0.3s ease;
        }

        .dashboard-header {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            display: flex;
            align-items: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: rotate(45deg);
            transition: all 0.3s ease;
            opacity: 0;
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-icon {
            background: rgba(72, 72, 110, 0.1);
            color: var(--accent-color);
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 1.8rem;
        }

        .stat-content {
            flex-grow: 1;
        }

        .stat-label {
            font-size: 0.85rem;
            color: var(--secondary-color);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--accent-color);
        }

        .category-selector {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        .dashboard-table {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: white;
            border-bottom: 1px solid var(--background-color);
        }

        .table-responsive {
            max-height: 450px;
            overflow-y: auto;
        }

        .table thead {
            position: sticky;
            top: 0;
            background: var(--accent-color);
            color: white;
            z-index: 10;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(72, 72, 110, 0.05);
        }

        .btn-custom {
            background-color: var(--accent-color);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 0;
                padding: 0;
                overflow: hidden;
            }

            .main-content {
                margin-left: 0;
                padding: 15px;
            }

            .quick-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
     <%@include file="sidebar.jsp" %>
    <div class="dashboard-wrapper">
       
        
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="h3 mb-2">Dashboard</h1>
                <p class="text-muted">Business Operations Overview</p>
            </div>

            <!-- Thống kê nhanh -->
            <div class="quick-stats">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-truck"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-label">Orders in Delivery</div>
                        <div class="stat-value">${TotalOrderDelivery != null ? TotalOrderDelivery : "0"}</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-label">Successful Orders</div>
                        <div class="stat-value">${totalOrderSuccessful != null ? totalOrderSuccessful : "25"}</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-label">Total Products</div>
                        <div class="stat-value">${totalProducts != null ? totalProducts : "184"}</div>
                    </div>
                </div>
            </div>

             <!-- Product Category Selector -->
            <div class="category-selector">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Select Product Category</h5>
                    <span class="badge" style="background-color: var(--success-color);">Top Selling</span>
                </div>
                <form action="Top_selling" method="get">
                    <div class="row align-items-center">
                        <div class="col-md-4">
                            <select id="categorySelect" name="categoryId" class="form-select" onchange="this.form.submit()">
                                <option value="1" ${selectedCategory == 1 ? "selected" : ""}>Mobile Phones</option>
                                <option value="2" ${selectedCategory == 2 ? "selected" : ""}>Laptops</option>
                                <option value="3" ${selectedCategory == 3 ? "selected" : ""}>Tablets</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Top Selling Products Table -->
            <div class="dashboard-table mb-4">
                <div class="table-header">
                    <h6 class="mb-0">Top Selling Products</h6>
                    <span class="badge" style="background-color: var(--danger-color);">Hot</span>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Product Name</th>
                                <th>Color</th>
                                <th>Memory</th>
                                <th>Price</th>
                                <th>Sold</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td class="text-center">${product.productID}</td>
                                    <td>${product.productName}</td>
                                    <td>${product.color}</td>
                                    <td>${product.rom}</td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${product.price}" pattern="#,### VND"/>
                                    </td>
                                    <td class="text-center">${product.quantitySell}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

             <!-- Recent Orders -->
            <div class="dashboard-table">
                <div class="table-header">
                    <h6 class="mb-0">Recent Orders</h6>
                    <button class="btn btn-sm btn-custom">View All</button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Customer Name</th>
                                <th>Order Date</th>
                                <th>Address</th>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${recentOrder}">
                                <tr>
                                    <td>${order.fullname}</td>
                                    <td>${order.date}</td>
                                    <td>${order.address}</td>
                                    <td>${order.productName}</td>
                                    <td>
                                        <fmt:formatNumber value="${order.price}" pattern="#,### VND"/>
                                    </td>
                                    <td>
                                        <span class="badge 
                                            ${order.status == 'Đang giao' ? 'bg-warning text-dark' : 
                                              order.status == 'Hoàn thành' ? 'bg-success' : 
                                              order.status == 'Đã xác nhận' ? 'bg-primary' : 'bg-secondary'}">
                                            ${order.status}
                                        </span>
                                    </td>
                                    <td>${order.quantity}</td>
                                    <td>
                                        <fmt:formatNumber value="${order.total}" pattern="#,### VND"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>