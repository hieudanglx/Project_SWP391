<%-- 
    Document   : manageRevenue
    Created on : Mar 3, 2025, 2:41:32 PM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Order_list" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
            }
            .sidebar {
                width: 250px;
                background-color: #343a40;
                color: white;
                height: 100vh;
                padding: 20px;
                position: fixed;
            }
            .sidebar a {
                 padding: 10px 15px;
                text-decoration: none;
                font-size: 18px;
                color: white;
                display: block;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .content {
                margin-left: 250px;
                padding: 20px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: white;
                padding: 15px 20px;
                border-bottom: 2px solid #ddd;
                position: fixed;
                top: 0;
                left: 250px;
                width: calc(100% - 250px);
                z-index: 1000;
            }
            .search-bar {
                display: flex;
                align-items: center;
            }
            .search-bar input {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 250px;
                margin-right: 10px;
            }
            .search-bar button {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 8px 12px;
                cursor: pointer;
                border-radius: 5px;
            }
            .user-info a {
                color: red;
                text-decoration: none;
                font-weight: bold;
            }
            .main-content {
                margin-top: 70px;
            }
            .stat-box {
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .filter-buttons {
                margin: 20px 0;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            .no-data {
                text-align: center;
                color: #888;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-chart-bar"></i> Manager Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="feedback"><i class="fas fa-cog"></i> Manager feedback</a>
            <a href="Revenue"><i class="fas fa-cog"></i> Manager Revenue</a>
        </div>
        <div class="content">
            <div class="header">
                <h4>Manage Revenue</h4>
                <div class="user-info">
                    <a href="ManagerProfile.jsp" class="text-decoration-none text-dark me-3 fw-bold">${sessionScope.fullname}</a>
                    <a href="javascript:void(0);" class="text-lg-startr fw-bold" onclick="logout()">Logout</a>
                </div>
            </div>
            <div class="main-content">
                <div class="row">
                    <div class="col-md-4">
                        <div class="stat-box">
                            <h5>Total Users</h5>
                            <p>1,250</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-box">
                            <h5>Total Sales</h5>
                            <p><strong>160.000.000 VND</strong></p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-box">
                            <h5>Products Sold</h5>
                            <p>3,420</p>
                        </div>
                    </div>
                </div>

                <!-- Bộ lọc doanh thu -->
                <div class="filter-buttons">
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="month" class="btn btn-primary">Lọc theo Tháng</button>
                    </form>
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="quarter" class="btn btn-primary">Lọc theo Quý</button>
                    </form>
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="year" class="btn btn-primary">Lọc theo Năm</button>
                    </form>
                </div>

                <table>
                    <%
                        List<Order_list> revenueList = (List<Order_list>) request.getAttribute("revenuelist");
                        String filter = request.getParameter("filter");

                        if (revenueList != null && !revenueList.isEmpty()) {
                    %>
                    <tr>
                        <th>Năm</th>
                        <% if ("month".equals(filter)) { %> <th>Tháng</th> <% } %>
                        <% if ("quarter".equals(filter)) { %> <th>Quý</th> <% } %>
                        <th>Doanh Thu</th>
                    </tr>
                    <%
                            for (Order_list revenue : revenueList) {
                    %>
                    <tr>
                        <td><%= revenue.getYear() %></td>
                        <% if ("month".equals(filter) || "quarter".equals(filter)) { %>
                        <td><%= revenue.getPeriod() %></td>
                        <% } %>
                        <td><%= String.format("%,.2f VND", revenue.getRevenue()) %></td>
                    </tr>
                    <%
                            }
                        } else {
                            List<Order_list> orders = (List<Order_list>) request.getAttribute("orders");
                            if (orders != null && !orders.isEmpty()) {
                    %>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                    </tr>
                    <%
                                for (Order_list order : orders) {
                    %>
                    <tr>
                        <td><%= order.getOrderID() %></td>
                        <td><%= order.getDate() %></td>
                        <td><%= String.format("%,.2f VNĐ", order.getTotal()) %></td>
                    </tr>
                    <%
                                }
                            } else {
                    %>
                    <tr>
                        <td colspan="3" class="no-data">Không có dữ liệu</td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
            </div>
        </div>
    </body>
</html>