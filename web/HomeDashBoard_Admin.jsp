<%-- 
    Document   : HomeDashBoard
    Created on : Feb 24, 2025, 8:13:02 PM
    Author     : Dang Khac Hieu_CE180465
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    if (request.getAttribute("totalSales") == null) {
        response.sendRedirect("RevenueTotal");
        return;
    }
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .sidebar {
                height: 100vh;
                width: 250px;
                background-color: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
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
            .navbar {
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .chart-container {
                width: 70%;
                padding: 20px;
                border-radius: 10px;
                background: white;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-chart-bar"></i> Manager Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="feedback"><i class="fas fa-cog"></i> Manager Feedback</a>
            <a href="Revenue"><i class="fas fa-cog"></i> Manager Revenue</a>
            <a href="ListInventory"><i class="fas fa-cog"></i> Manager Inventory</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container-fluid">
                    <h4>Welcome to Dashboard Admin</h4>
                    <div class="mx-auto">
                        <div class="d-flex">
                            <input type="text" class="form-control me-2" placeholder="Search">
                            <button class="btn btn-primary">Search</button>
                        </div>
                    </div>
                    <div class="ms-auto">
                        <a href="ManagerProfile.jsp" class="text-decoration-none text-dark me-3 fw-bold">${sessionScope.fullname}</a>
                        <a href="javascript:void(0);" class="text-lg-startr fw-bold" onclick="logout()">Logout</a>
                    </div>
                </div>
            </nav>

            <!-- Dashboard Cards -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Total Users</h5>
                        <p class="fs-4">1,250</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Total Sales</h5>
                        <% 
                        Object totalSalesObj = request.getAttribute("totalSales");
                        String totalSalesStr = (totalSalesObj != null) ? totalSalesObj.toString() : "0";
                        %>
                        <p class="fs-4"><b><%= totalSalesStr %> VND</b></p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3">
                        <h5>Products Sold</h5>
                        <p class="fs-4">3,420</p>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="row mt-4">
                <!-- Revenue Chart -->
                <div class="col-md-6">
                    <div class="card p-3">
                        <div class="d-flex justify-content-between">
                            <h5>Revenue Statistics</h5>
                            <select id="chartMode" class="form-select w-25">
                                <option value="month">Month</option>
                                <option value="quarter">Quarter</option>
                                <option value="year">Year</option>
                            </select>
                        </div>
                        <div class="chart-container">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Products Pie Chart -->
                <div class="col-md-6">
                    <div class="card p-3">
                        <h5 class="text-center">Product Sales Distribution</h5>
                        <div class="chart-container">
                            <canvas id="productChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product List -->
            <div class="card mt-4 p-3 table-container">
                <h5>Product List</h5>
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price ($)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>1</td><td>iPhone 14</td><td>Phone</td><td>999</td></tr>
                        <tr><td>2</td><td>MacBook Pro</td><td>Laptop</td><td>1299</td></tr>
                        <tr><td>3</td><td>Galaxy Tab S8</td><td>Tablet</td><td>699</td></tr>
                    </tbody>
                </table>
            </div>
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

    async function fetchRevenueData(type) {
        const response = await fetch(`Revenue?type=${type}`);
        if (!response.ok) {
            console.error("Lỗi khi lấy dữ liệu từ server");
            return {};
        }
        return await response.json();
    }

    async function renderChart(type = "month") {
        const revenueData = await fetchRevenueData(type);
        const labels = Object.keys(revenueData);
        const values = Object.values(revenueData);

        // Xóa biểu đồ cũ nếu có
        const existingChart = Chart.getChart(document.getElementById("revenueChart"));
        if (existingChart) {
            existingChart.destroy();
        }

        // Vẽ biểu đồ mới
        const ctx = document.getElementById("revenueChart").getContext("2d");
        new Chart(ctx, {
            type: "line",
            data: {
                labels: labels,
                datasets: [{
                        label: "Revenue (VND)",
                        data: values,
                        borderColor: "blue",
                        borderWidth: 2,
                        fill: false
                    }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value) {
                                return value.toLocaleString("vi-VN") + " VND";
                            }
                        }
                    }
                }
            }
        });
    }

    // Gọi vẽ biểu đồ mặc định (theo tháng)
    renderChart();

    // Xử lý khi chọn kiểu thống kê 
    document.getElementById("chartMode").addEventListener("change", function () {
        renderChart(this.value);
    });

</script>

</html>
