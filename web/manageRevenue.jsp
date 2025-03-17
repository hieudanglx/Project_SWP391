<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Order_list" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Revenue</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
            }

            /* Sidebar */
            .sidebar {
                height: 100vh;
                width: 250px;
                background: linear-gradient(to bottom, #343a40, #212529);
                color: white;
                position: fixed;
                top: 0;
                left: 0;
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

            /* Main Content */
            .content {
                margin-left: 250px;
                padding: 20px;
                padding-top: 80px; /* Thêm khoảng trống để tránh bị header che */
            }

            /* Header */
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
                height: 60px;
                z-index: 1000;
            }
            .header h4 {
                margin: 0;
                font-weight: bold;
                color: #333;
            }

            /* Table Container */
            .table-container {
                margin-top: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }
            .table th {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }
            .table td, .table th {
                vertical-align: middle;
                text-align: center;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }
            .no-data {
                text-align: center;
                color: #888;
                padding: 20px;
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
            <div class="header">
                <h4>Manage Revenue</h4>
                <div class="user-info">
                    <a href="ManagerProfile.jsp">${sessionScope.fullname}</a>
                    <a href="javascript:void(0);" onclick="logout()">Logout</a>
                </div>
            </div>

            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <form method="GET" action="RevenueByMonth" style="display:inline;">
                    <button type="submit" name="filter" value="month" class="btn">Lọc theo Tháng</button>
                </form>
                <form method="GET" action="RevenueByMonth" style="display:inline;">
                    <button type="submit" name="filter" value="quarter" class="btn">Lọc theo Quý</button>
                </form>
                <form method="GET" action="RevenueByMonth" style="display:inline;">
                    <button type="submit" name="filter" value="year" class="btn">Lọc theo Năm</button>
                </form>
            </div>

            <!-- Table -->
            <div class="table-container">
                <%
                    List<Order_list> revenueList = (List<Order_list>) request.getAttribute("revenuelist");
                    String filter = request.getParameter("filter");

                    if (revenueList != null && !revenueList.isEmpty()) {
                %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Năm</th>
                                <% if ("month".equals(filter)) { %> <th>Tháng</th> <% } %>
                                <% if ("quarter".equals(filter)) { %> <th>Quý</th> <% } %>
                                <th>Doanh Thu</th>
                            </tr>
                        </thead>
                        <tbody>
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
                            %>
                        </tbody>
                    </table>
                </div>
                <%
                    } else {
                        List<Order_list> orders = (List<Order_list>) request.getAttribute("orders");
                        if (orders != null && !orders.isEmpty()) {
                %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                            </tr>
                        </thead>
                        <tbody>
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
                            %>
                        </tbody>
                    </table>
                </div>
                <%
                        } else {
                %>
                <div class="no-data">Không có dữ liệu</div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <!-- Logout Script -->
        <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', {method: 'POST'})
                        .then(response => {
                            if (response.ok)
                                window.location.href = '/LoginOfDashboard.jsp';
                            else
                                alert('Logout Failed!');
                        });
            }
        </script>
    </body>
</html>
