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

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-color: #3498db;
                --secondary-color: #2ecc71;
                --background-color: #f4f6f9;
                --sidebar-color: #2c3e50;
                --text-color: #333;
                --hover-color: rgba(255,255,255,0.1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
                line-height: 1.6;
            }

            /* Sidebar */
            .sidebar {
                width: 260px;
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                background: var(--sidebar-color);
                color: white;
                transition: all 0.3s;
                z-index: 1000;
                box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            }

            .sidebar-logo {
                padding: 20px;
                text-align: center;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .sidebar a {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                color: rgba(255,255,255,0.7);
                text-decoration: none;
                transition: all 0.3s;
                position: relative;
            }

            .sidebar a i {
                margin-right: 10px;
                width: 25px;
                text-align: center;
            }

            .sidebar a:hover {
                background: var(--hover-color);
                color: white;
            }

            .sidebar a::before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                bottom: 0;
                width: 4px;
                background: transparent;
                transition: background 0.3s;
            }

            .sidebar a:hover::before {
                background: var(--primary-color);
            }

            /* Content Area */
            .content {
                margin-left: 260px;
                padding: 30px;
                transition: all 0.3s;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                margin-bottom: 25px;
            }

            .header h4 {
                margin: 0;
                color: var(--sidebar-color);
                font-weight: 700;
            }

            .filter-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-bottom: 20px;
            }

            .filter-buttons .btn {
                background-color: var(--primary-color);
                color: white;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .filter-buttons .btn:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
            }

            .table-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 6px 15px rgba(0,0,0,0.1);
                padding: 25px;
            }

            .table {
                margin-bottom: 0;
            }

            .table thead {
                background-color: var(--primary-color);
                color: white;
            }

            .table thead th {
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: none;
            }

            .table tbody tr:hover {
                background-color: rgba(52, 152, 219, 0.05);
            }

            .no-data {
                text-align: center;
                color: #888;
                padding: 30px;
                font-style: italic;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 0;
                    overflow: hidden;
                }
                .content {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">
            <div class="header">
                <h4>Manage Revenue</h4>               
            </div>

            <!-- Table -->
            <div class="table-container">
                <div class="filter-buttons">
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="month" class="btn">
                            <i class="fas fa-calendar-alt"></i> Filter by Month
                        </button>
                    </form>
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="quarter" class="btn">
                            <i class="fas fa-chart-pie"></i> Filter by Quarter
                        </button>
                    </form>
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="year" class="btn">
                            <i class="fas fa-calendar"></i> Filter by Year
                        </button>
                    </form>
                </div>
                <div>
                    <%
                        List<Order_list> revenueList = (List<Order_list>) request.getAttribute("revenuelist");
                        String filter = request.getParameter("filter");

                        if (revenueList != null && !revenueList.isEmpty()) {
                    %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Year</th>
                                    <% if ("month".equals(filter)) { %> <th>Month</th> <% } %>
                                    <% if ("quarter".equals(filter)) { %> <th>Quarter</th> <% } %>
                                    <th>Revenue</th>
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
                                    <th>Order ID</th>
                                    <th>Date booked</th>
                                    <th>Total</th>
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
                    <div class="no-data">No data available</div>
                    <%
                            }
                        }
                    %>
                </div>
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