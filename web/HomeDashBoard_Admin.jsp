<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            :root {
                --primary-color: #4e73df;
                --success-color: #1cc88a;
                --info-color: #36b9cc;
                --warning-color: #f6c23e;
                --danger-color: #e74a3b;
                --secondary-color: #858796;
                --light-color: #f8f9fc;
                --dark-color: #5a5c69;
            }

            body {
                background-color: #f8f9fc;
                font-family: 'Inter', sans-serif;
                color: #333;
            }

            .content {
                margin-left: 250px;
                padding: 20px;
                transition: all 0.3s;
            }

            @media (max-width: 768px) {
                .content {
                    margin-left: 0;
                }
            }

            .navbar {
                background: white !important;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                padding: 1rem 1.5rem;
            }

            .stat-card {
                border-radius: 0.35rem;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
                border-left: 0.25rem solid;
                overflow: hidden;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0.5rem 1.5rem 0 rgba(58, 59, 69, 0.2);
            }

            .stat-card.total-products {
                border-left-color: var(--primary-color);
            }

            .stat-card.total-sales {
                border-left-color: var(--success-color);
            }

            .stat-card.successful-orders {
                border-left-color: var(--warning-color);
            }

            .stat-icon {
                font-size: 1.5rem;
                opacity: 0.8;
            }

            .stat-label {
                font-size: 0.8rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-weight: 600;
                color: var(--secondary-color);
            }

            .stat-value {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--dark-color);
            }

            .card {
                border: none;
                border-radius: 0.35rem;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
                margin-bottom: 1.5rem;
            }

            .card-header {
                background-color: #f8f9fc;
                border-bottom: 1px solid #e3e6f0;
                padding: 1rem 1.35rem;
                font-weight: 600;
                color: var(--dark-color);
            }

            .chart-container {
                padding: 1.25rem;
                height: 100%;
            }

            .table-container {
                padding: 0;
            }

            .table {
                margin-bottom: 0;
            }

            .table thead th {
                border-bottom: 2px solid #e3e6f0;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.7rem;
                letter-spacing: 0.5px;
                color: var(--secondary-color);
                padding: 1rem;
            }

            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-top: 1px solid #e3e6f0;
            }

            .table tbody tr:hover {
                background-color: #f8f9fc;
            }

            .badge-hot {
                background-color: var(--danger-color);
                padding: 0.35rem 0.65rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .form-select {
                border-radius: 0.35rem;
                border: 1px solid #d1d3e2;
                padding: 0.375rem 0.75rem;
                font-size: 0.85rem;
            }

            .form-select:focus {
                border-color: #bac8f3;
                box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
            }

            .chart-controls {
                display: flex;
                gap: 10px;
            }

            @media (max-width: 768px) {
                .chart-controls {
                    flex-direction: column;
                }

                .chart-controls select {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand navbar-light bg-white mb-4 static-top shadow">
                <div class="container-fluid">
                    <h4 class="mb-0 font-weight-bold text-gray-800">Dashboard Overview</h4>                    
                </div>
            </nav>

            <!-- Dashboard Cards -->
            <div class="row">
                <!-- Total Products -->
                <div class="col-xl-4 col-md-6 mb-4">
                    <div class="stat-card total-products card border-left-primary h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="stat-label">Total Products</div>
                                    <div class="stat-value">${totalProducts != null ? totalProducts : "184"}</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-box stat-icon text-primary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Sales -->
                <div class="col-xl-4 col-md-6 mb-4">
                    <div class="stat-card total-sales card border-left-success h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="stat-label">Total Sales</div>
                                    <%
                                        Object totalSalesObj = request.getAttribute("totalSales");
                                        String formattedTotalSales = "0 VND";

                                        if (totalSalesObj != null) {
                                            formattedTotalSales = totalSalesObj.toString(); // Tránh ép kiểu sai
                                        }
                                    %>
                                    <div class="stat-value"><%= formattedTotalSales %> VND</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-dollar-sign stat-icon text-success"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Successful Orders -->
                <div class="col-xl-4 col-md-6 mb-4">
                    <div class="stat-card successful-orders card border-left-warning h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="stat-label">Successful Orders</div>
                                   <div class="stat-value">${totalOrderSuccessful != null ? totalOrderSuccessful : "25"}</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-check-circle stat-icon text-warning"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="row">
                <!-- Revenue Chart -->
                <div class="col-xl-8 col-lg-7">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Revenue Statistics</h6>
                            <div class="chart-controls">
                                <select id="yearSelect" class="form-select">
                                    <!-- Years will be populated by JS -->
                                </select>
                                <select id="chartMode" class="form-select">
                                    <option value="month">Monthly</option>
                                    <option value="quarter">Quarterly</option>
                                    <option value="year">Yearly</option>
                                </select>
                            </div>
                        </div>
                        <div class="chart-container">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Category Selector -->
                <div class="category-selector">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0">Select Product Category</h5>
                        <span class="badge" style="background-color: var(--success-color);">Top Selling</span>
                    </div>
                    <form action="RevenueTotal" method="get">
                        <div class="row align-items-center">
                            <div class="col-md-4">
                                <select id="categorySelect" name="categoryId" class="form-select" onchange="this.form.submit()">
                                    <option value="2" ${selectedCategory == 2 ? "selected" : ""}>Mobile Phones</option>
                                    <option value="1" ${selectedCategory == 1 ? "selected" : ""}>Laptops</option>
                                    <option value="3" ${selectedCategory == 3 ? "selected" : ""}>Tablets</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Top Selling Products Table -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Top Selling Products</h6>
                            <span class="badge badge-hot">Hot</span>
                        </div>
                        <div class="table-container card-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Product Name</th>
                                            <th>Color</th>
                                            <th>Memory</th>
                                            <th class="text-end">Price</th>
                                            <th class="text-center">Sold</th>
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
                    </div>
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

                async function fetchMonthlyRevenueData(year) {
                    try {
                        const response = await fetch(`RevenueData?filter=month&year=${year}`);
                        if (!response.ok) {
                            console.error(`Error fetching data: ${response.status} ${response.statusText}`);
                            return null;
                        }
                        return await response.json();
                    } catch (error) {
                        console.error("Error in fetchMonthlyRevenueData:", error);
                        return null;
                    }
                }

                function formatCurrency(value) {
                    return new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND',
                        maximumFractionDigits: 0
                    }).format(value);
                }

                async function renderMonthlyRevenueChart(year) {
                    const monthNames = [
                        'Jan', 'Feb', 'Mar', 'Apr',
                        'May', 'Jun', 'Jul', 'Aug',
                        'Sep', 'Oct', 'Nov', 'Dec'
                    ];

                    const revenueData = await fetchMonthlyRevenueData(year);

                    if (!revenueData) {
                        console.error("No revenue data available");
                        return;
                    }

                    // Prepare data for chart
                    const labels = monthNames;
                    const revenues = monthNames.map((_month, index) => {
                        const monthData = revenueData.find(item => parseInt(item.period) === (index + 1));
                        return monthData ? monthData.revenue : 0;
                    });

                    const ctx = document.getElementById('revenueChart').getContext('2d');

                    // Destroy existing chart if it exists
                    const existingChart = Chart.getChart('revenueChart');
                    if (existingChart) {
                        existingChart.destroy();
                    }

                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                    label: `Revenue ${year}`,
                                    data: revenues,
                                    backgroundColor: 'rgba(78, 115, 223, 0.7)',
                                    borderColor: 'rgba(78, 115, 223, 1)',
                                    borderWidth: 1,
                                    borderRadius: 4,
                                    hoverBackgroundColor: 'rgba(78, 115, 223, 0.9)'
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: {
                                        color: 'rgba(0, 0, 0, 0.05)'
                                    },
                                    ticks: {
                                        callback: function (value) {
                                            return formatCurrency(value);
                                        }
                                    }
                                },
                                x: {
                                    grid: {
                                        display: false
                                    }
                                }
                            },
                            plugins: {
                                legend: {
                                    display: false
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            return formatCurrency(context.parsed.y);
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
                            throw new Error("Error fetching years");

                        const years = await response.json();
                        yearSelect.innerHTML = "";

                        if (years.length === 0) {
                            console.warn("No years available in database.");
                            return;
                        }

                        years.forEach(year => {
                            const option = document.createElement("option");
                            option.value = year;
                            option.textContent = year;
                            yearSelect.appendChild(option);
                        });

                        yearSelect.value = years[0]; // Select the most recent year
                        renderMonthlyRevenueChart(years[0]);

                    } catch (error) {
                        console.error("Cannot fetch years, using default data.", error);

                        const currentYear = new Date().getFullYear();
                        for (let year = 2019; year <= currentYear; year++) {
                            const option = document.createElement("option");
                            option.value = year;
                            option.textContent = year;
                            yearSelect.appendChild(option);
                        }

                        yearSelect.value = currentYear;
                        renderMonthlyRevenueChart(currentYear);
                    }

                    // Add event listener for year selection
                    yearSelect.addEventListener("change", function () {
                        renderMonthlyRevenueChart(this.value);
                    });
                }

                // Initialize on page load
                document.addEventListener("DOMContentLoaded", populateYearSelect);
            </script>
    </body>
</html>