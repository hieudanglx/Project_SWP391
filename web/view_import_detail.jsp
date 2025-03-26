<%-- 
    Document   : view_import_detail
    Created on : Mar 16, 2025, 2:17:16 PM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Import Details</title>
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
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <div class="navbar-custom">
                <h3>📦 Import Details</h3>
            </div>

            <!-- Table -->
            <div class="table-container">
                <table class="table table-bordered table-hover text-center">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Brand</th>
                            <th>Import Price (VND)</th>
                            <th>Import Quantity</th>
                            <th>Import Date</th>
                            <th>Supplier</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty importHistory}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted">📭 No import data available.</td>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            
            
            async function getRevenue() {
                try {
                    let response = await fetch("RevenueTotal");
                    let data = await response.json();
                    console.log("Total revenue:", data.totalSales);
                    document.getElementById("totalRevenue").innerText = data.totalSales + " VND";
                } catch (error) {
                    console.error("Error getting revenue:", error);
                }
            }
            document.addEventListener("DOMContentLoaded", getRevenue);
        </script>
    </body>
</html>