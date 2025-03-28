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
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary: #4361ee;
                --primary-light: #3f37c9;
                --secondary: #3a0ca3;
                --accent: #f72585;
                --light: #f8f9fa;
                --dark: #212529;
                --gray: #6c757d;
                --light-gray: #e9ecef;
                --success: #4cc9f0;
                --warning: #f8961e;
                --danger: #ef233c;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: #f5f7fb;
                color: var(--dark);
                line-height: 1.6;
            }

            /* Content Area */
            .content {
                margin-left: 280px;
                padding: 30px;
                transition: all 0.3s;
                min-height: 100vh;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: white;
                padding: 20px 25px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                margin-bottom: 30px;
            }

            .header h4 {
                margin: 0;
/*                color: var(--primary);*/
                font-weight: 700;
                font-size: 1.5rem;
            }

            .header-actions {
                display: flex;
                gap: 15px;
            }

            /* Filter Section */
            .filter-section {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                margin-bottom: 30px;
            }

            .filter-title {
                font-weight: 600;
                margin-bottom: 15px;
/*                color: var(--primary);*/
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .filter-title i {
                font-size: 1.2rem;
            }

            .filter-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
            }

            .btn-filter {
                background-color: white;
                color: var(--primary);
                border: 1px solid var(--primary);
                padding: 8px 15px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-filter:hover, .btn-filter.active {
                background-color: var(--primary);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
            }

            .btn-export {
                background-color: var(--success);
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-export:hover {
                background-color: #3aa8d4;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(76, 201, 240, 0.2);
            }

            /* Table Container */
            .table-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 6px 18px rgba(0,0,0,0.05);
                padding: 25px;
                overflow: hidden;
            }

            .table-title {
                font-weight: 700;
/*                color: var(--primary);*/
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .table-title i {
                font-size: 1.2rem;
            }

            .table {
                margin-bottom: 0;
                border-collapse: separate;
                border-spacing: 0;
            }

            .table thead {
                background: linear-gradient(90deg, var(--primary) 0%, var(--primary-light) 100%);
                color: white;
                position: sticky;
                top: 0;
            }

            .table thead th {
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: none;
                padding: 15px;
                font-size: 0.85rem;
            }

            .table tbody tr {
                transition: all 0.2s;
            }

            .table tbody tr:hover {
                background-color: rgba(67, 97, 238, 0.05);
                transform: translateX(2px);
            }

            .table tbody td {
                padding: 12px 15px;
                vertical-align: middle;
                border-top: 1px solid var(--light-gray);
            }

            .badge-month {
                background-color: #e3f2fd;
                color: #1976d2;
                padding: 5px 10px;
                border-radius: 50px;
                font-weight: 500;
            }

            .badge-quarter {
                background-color: #e8f5e9;
                color: #2e7d32;
                padding: 5px 10px;
                border-radius: 50px;
                font-weight: 500;
            }

            .badge-year {
                background-color: #f3e5f5;
                color: #7b1fa2;
                padding: 5px 10px;
                border-radius: 50px;
                font-weight: 500;
            }

            .revenue-amount {
                font-weight: 700;
                color: var(--primary);
            }

            .no-data {
                text-align: center;
                padding: 40px;
                color: var(--gray);
            }

            .no-data i {
                font-size: 3rem;
                color: var(--light-gray);
                margin-bottom: 15px;
            }

            .no-data h5 {
                font-weight: 600;
                margin-bottom: 10px;
            }

            .no-data p {
                color: var(--gray);
            }

            /* Responsive */
            @media (max-width: 992px) {
                .sidebar {
                    width: 0;
                    overflow: hidden;
                }
                .content {
                    margin-left: 0;
                }
            }

            @media (max-width: 768px) {
                .filter-buttons {
                    flex-direction: column;
                }
                .header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">
            <div class="header">
                <h4><i class="fas fa-chart-line"></i> Revenue Dashboard</h4>
                <div class="header-actions">
                    <div class="dropdown">
                        <button class="btn btn-export dropdown-toggle" type="button" id="exportDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-file-export"></i> Export Data
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="exportDropdown">
                            <li><a class="dropdown-item" href="ExportRevenue?filter=month"><i class="fas fa-file-excel"></i> Monthly Revenue</a></li>
                            <li><a class="dropdown-item" href="ExportRevenue?filter=quarter"><i class="fas fa-file-excel"></i> Quarterly Revenue</a></li>
                            <li><a class="dropdown-item" href="ExportRevenue?filter=year"><i class="fas fa-file-excel"></i> Annual Revenue</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="ExportRevenue?filter=all"><i class="fas fa-file-excel"></i> All Orders</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <h5 class="filter-title"><i class="fas fa-filter"></i> Filter Revenue Data</h5>
                <div class="filter-buttons">
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="month" class="btn btn-primary <%= "month".equals(request.getParameter("filter")) ? "active" : "" %>">
                            <i class="fas fa-calendar-week"></i> By Month
                        </button>
                    </form>
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="quarter" class="btn btn-primary <%= "quarter".equals(request.getParameter("filter")) ? "active" : "" %>">
                            <i class="fas fa-chart-pie"></i> By Quarter
                        </button>
                    </form>
                    <form method="GET" action="RevenueByMonth" style="display:inline;">
                        <button type="submit" name="filter" value="year" class="btn btn-primary <%= "year".equals(request.getParameter("filter")) ? "active" : "" %>">
                            <i class="fas fa-calendar-alt"></i> By Year
                        </button>
                    </form>
                </div>
            </div>

            <!-- Table Section -->
            <div class="table-container">
                <%
                    List<Order_list> revenueList = (List<Order_list>) request.getAttribute("revenuelist");
                    String filter = request.getParameter("filter");

                    if (revenueList != null && !revenueList.isEmpty()) {
                %>
                <h5 class="table-title">
                    <i class="fas fa-table"></i> 
                    <% 
                        if ("month".equals(filter)) { 
                            out.print("Monthly Revenue Summary"); 
                        } else if ("quarter".equals(filter)) { 
                            out.print("Quarterly Revenue Summary"); 
                        } else if ("year".equals(filter)) { 
                            out.print("Annual Revenue Summary"); 
                        } else { 
                            out.print("Revenue Data"); 
                        } 
                    %>
                </h5>
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
                                <td><strong><%= revenue.getYear() %></strong></td>
                                <% if ("month".equals(filter)) { %>
                                <td><span class="badge-month"><%= revenue.getPeriod() %></span></td>
                                    <% } else if ("quarter".equals(filter)) { %>
                                <td><span class="badge-quarter">Q<%= revenue.getPeriod() %></span></td>
                                <% } %>
                                <td class="revenue-amount"><%= String.format("%,.0f VND", revenue.getRevenue()) %></td>
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
                <h5 class="table-title"><i class="fas fa-receipt"></i> Order Details</h5>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Date Booked</th>
                                <th>Total Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Order_list order : orders) {
                            %>
                            <tr>
                                <td><strong>#<%= order.getOrderID() %></strong></td>
                                <td><%= order.getDate() %></td>
                                <td class="revenue-amount"><%= String.format("%,.0f VND", order.getTotal()) %></td>
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
                <div class="no-data">
                    <i class="fas fa-database"></i>
                    <h5>No Data Available</h5>
                    <p>Select a filter option to view revenue data</p>
                </div>
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

            // Add active class to current nav item
            document.addEventListener('DOMContentLoaded', function () {
                const currentPage = window.location.pathname.split('/').pop();
                const navLinks = document.querySelectorAll('.sidebar a');

                navLinks.forEach(link => {
                    if (link.getAttribute('href') === currentPage) {
                        link.classList.add('active');
                    }
                });
            });
        </script>
    </body>
</html>