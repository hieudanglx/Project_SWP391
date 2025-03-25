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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
            }
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
                margin-left: 250px;
                padding: 20px;
            }
            .navbar {
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .chart-container {
                width: 100%;
                height: 300px;
                margin-top: 20px;
            }
            .table-container {
                margin-top: 20px;
                padding: 20px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            .table thead {
                background-color: #343a40;
                color: white;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>
        <%@include file="sidebar.jsp" %>
        <!-- Sidebar -->
        <!--        <div class="sidebar">
                    <h4 class="text-center mb-4">
                        <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
                    </h4>
                    <a href="/ListAccountStaff"><i class="fas fa-user-tie"></i> Manage Staff</a>
                    <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
                    <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
                    <a href="listOrderAdmin"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
                    <a href="feedback"><i class="fas fa-comments"></i> Manage Feedback</a>
                    <a href="Revenue"><i class="fas fa-chart-line"></i> Manage Revenue</a>
                    <a href="ListInventory"><i class="fas fa-warehouse"></i> Manage Inventory</a>
                </div>-->

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <h4 class="mb-0">Welcome to Dashboard Admin</h4>
                    <div class="ms-auto d-flex align-items-center">
                        <a href="ManagerProfile.jsp" class="text-decoration-none text-dark me-3 fw-bold">${sessionScope.fullname}</a>
                        <a href="javascript:void(0);" class="btn btn-danger" onclick="logout()">Logout</a>
                    </div>
                </div>
            </nav>

            <!-- Dashboard Cards -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card p-3 bg-primary text-white">
                        <h5>Total Users</h5>
                        <p class="fs-4">1,250</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3 bg-success text-white">
                        <h5>Total Sales</h5>
                        <%
      // Get totalSales from request
      Object totalSalesObj = request.getAttribute("totalSales");
      double totalSales = 0.0;

      if (totalSalesObj != null) {
          totalSales = (double) totalSalesObj; // Safe casting
      }

      // Format the number properly
      java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
      String formattedTotalSales = formatter.format(totalSales);
                        %>

                        <p class="fs-4"><b><%= formattedTotalSales %> VND</b></p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3 bg-warning text-white">
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
                        <div class="d-flex justify-content-between align-items-center">
                            <h5>Revenue Statistics</h5>

                            <!-- Dropdown chọn năm -->
                            <select id="yearSelect" class="form-select w-25 me-2">
                                <!-- Danh sách năm sẽ được JS tạo tự động -->
                            </select>

                            <!-- Dropdown chọn kiểu lọc -->
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

            async function fetchRevenueData(type, year) {
                try {
                    const response = await fetch(`RevenueData?filter=${type}&year=${year}`);
                    if (!response.ok) {
                        console.error(`Error fetching data: ${response.status} ${response.statusText}`);
                        return {};
                    }
                    const data = await response.json();

                    const result = {};
                    data.forEach(item => {
                        const label = type === "year" ? item.year : item.period;
                        result[label] = item.revenue;
                    });

                    return result;
                } catch (error) {
                    console.error("Error in fetchRevenueData:", error);
                    return {};
                }
            }

            async function renderChart(type = "month") {
                const year = document.getElementById("yearSelect").value;
                const revenueData = await fetchRevenueData(type, year);
                const labels = Object.keys(revenueData);
                const values = Object.values(revenueData);

                // Xóa biểu đồ cũ nếu có
                const existingChart = Chart.getChart("revenueChart");
                if (existingChart) {
                    existingChart.destroy();
                }

                // Tạo biểu đồ mới
                const ctx = document.getElementById("revenueChart").getContext("2d");
                new Chart(ctx, {
                    type: "line",
                    data: {
                        labels: labels,
                        datasets: [{
                                label: `Revenue ${year} (VND)`,
                                data: values,
                                borderColor: "#0d6efd",
                                borderWidth: 2,
                                fill: false,
                                tension: 0.1
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
                                        return new Intl.NumberFormat('vi-VN', {
                                            style: 'currency',
                                            currency: 'VND',
                                            maximumFractionDigits: 0
                                        }).format(value);
                                    }
                                }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return new Intl.NumberFormat('vi-VN', {
                                            style: 'currency',
                                            currency: 'VND',
                                            maximumFractionDigits: 0
                                        }).format(context.raw);
                                    }
                                }
                            }
                        }
                    }
                });
            }
            async function populateYearSelect() {
                const yearSelect = document.getElementById("yearSelect");

                try {
                    const response = await fetch("RevenueData?getYears=true");
                    if (!response.ok)
                        throw new Error("Lỗi khi lấy danh sách năm");

                    const years = await response.json();
                    console.log("Danh sách năm từ API:", years); // Debug

                    yearSelect.innerHTML = ""; // Xóa danh sách cũ

                    if (years.length === 0) {
                        console.warn("Không có năm nào trong database.");
                        return;
                    }

                    years.forEach(year => {
                        const option = document.createElement("option");
                        option.value = year;
                        option.textContent = year;
                        yearSelect.appendChild(option);
                    });

                    yearSelect.value = years[0]; // Chọn năm mới nhất
                    console.log("Năm mặc định được chọn:", years[0]); // Debug

                } catch (error) {
                    console.error("Không thể lấy danh sách năm, sử dụng dữ liệu mặc định.", error);

                    const currentYear = new Date().getFullYear();
                    for (let year = 2019; year <= currentYear; year++) {
                        const option = document.createElement("option");
                        option.value = year;
                        option.textContent = year;
                        yearSelect.appendChild(option);
                    }

                    yearSelect.value = currentYear;
                    console.log("Dữ liệu mặc định được dùng:", currentYear); // Debug
                }
            }


// Initialize default chart (monthly)
            document.addEventListener("DOMContentLoaded", async function () {
                await populateYearSelect();
                renderChart("month");

                document.getElementById("chartMode").addEventListener("change", function () {
                    renderChart(this.value);
                });

                document.getElementById("yearSelect").addEventListener("change", function () {
                    renderChart(document.getElementById("chartMode").value);
                });
            });
        </script>
    </body>
</html>
