<%-- 
    Document   : Filter
    Created on : Feb 24, 2025, 3:29:40 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Filter</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .filter-container {
                width: 300px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                background: #f9f9f9;
            }
            .filter-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .filter-section {
                margin-bottom: 15px;
            }
            .filter-section label {
                display: block;
                margin-bottom: 5px;
            }
            .filter-section select, .filter-section input {
                width: 100%;
                padding: 8px;
                margin-bottom: 5px;
            }
            .filter-buttons {
                display: flex;
                justify-content: space-between;
            }
            .filter-buttons button {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn-clear {
                background-color: #ff4d4d;
                color: white;
            }
            .btn-apply {
                background-color: #4CAF50;
                color: white;
            }
            .price-options button {
                margin: 5px;
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background: #e0e0e0;
                cursor: pointer;
            }
            .price-options button:hover {
                background: #d6d6d6;
            }
            .slider-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-top: 10px;
            }
            .slider-container input[type="number"] {
                width: 45%;
                padding: 8px;
            }
        </style>
    </head>
    <body>
        <form class="filter-container" action="FilterGCController" method="POST">
            <div class="filter-title">Filter Products</div>

            <div class="filter-section">
                <label for="price-range">Price Range</label>
                <div class="price-options">
                    <button onclick="setPrice(0, 2000000)">Dưới 2 triệu</button>
                    <button onclick="setPrice(2000000, 4000000)">Từ 2 - 4 triệu</button>
                    <button onclick="setPrice(4000000, 7000000)">Từ 4 - 7 triệu</button>
                    <button onclick="setPrice(7000000, 13000000)">Từ 7 - 13 triệu</button>
                    <button onclick="setPrice(13000000, 20000000)">Từ 13 - 20 triệu</button>
                    <button onclick="setPrice(20000000, 100000000)">Trên 20 triệu</button>
                </div>
                <div class="slider-container">
                    <input type="number" id="min-price" placeholder="Min Price" step="100000"min="0">
                    <input type="number" id="max-price" placeholder="Max Price" step="100000" min="0">
                </div>
            </div>

            <div class="filter-section">
                <label for="brand">Brand</label>
                <select id="brand" name="brand">
                    <option value="">All Brands</option>
                    <c:forEach items="${brand}" var="v">
                        <option value="${v}">${v}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="filter-section">
                <label for="ram">RAM</label>
                <select id="ram" name="ram">
                    <option value="">All RAM</option>
                    <option value="6gb">6 GB</option>
                    <option value="8gb">8 GB</option>
                    <option value="12gb">12 GB</option>
                    <option value="16gb">16 GB</option>
                </select>
            </div>

            <div class="filter-section">
                <label for="rom">Storage (ROM)</label>
                <select id="rom" name="rom">
                    <option value="">All Storage</option>
                    <option value="64gb">64 GB</option>
                    <option value="128gb">128 GB</option>
                    <option value="256gb">256 GB</option>
                    <option value="512gb">512 GB</option>
                    <option value="1tb">1 TB</option>
                    <option value="2tb">2 TB</option>
                </select>
            </div>

            <div class="filter-section">
                <label for="refresh-rate">Refresh Rate</label>
                <select id="refresh-rate" name="refresh-rate">
                    <option value="">All Rates</option>
                    <option value="60hz">60 Hz</option>
                    <option value="90hz">90 Hz</option>
                    <option value="120hz">120 Hz</option>
                    <option value="144hz">144 Hz</option>
                </select>
            </div>

            <div class="filter-buttons">
                <button type="button" class="btn-clear" onclick="clearFilters()">Clear</button>
                <button type="button" class="btn-apply" onclick="applyFilters()">Apply</button>
            </div>

        </form>
        <script>
            function setPrice(min, max) {
                document.getElementById('min-price').value = min;
                document.getElementById('max-price').value = max;
            }
            function clearFilters() {
                document.getElementById('brand').value = '';
                document.getElementById('min-price').value = '';
                document.getElementById('max-price').value = '';
                document.getElementById('ram').value = '';
                document.getElementById('rom').value = '';
                document.getElementById('refresh-rate').value = '';
            }

            function applyFilters() {
                const brand = document.getElementById('brand').value;
                const minPrice = parseInt(document.getElementById('min-price').value) || 0;
                const maxPrice = parseInt(document.getElementById('max-price').value) || 0;
                const ram = document.getElementById('ram').value;
                const rom = document.getElementById('rom').value;
                const refreshRate = document.getElementById('refresh-rate').value;

                if (minPrice > maxPrice && maxPrice !== 0) {
                    alert('Min price cannot be greater than max price!');
                    return;
                }

            }
        </script>
    </body>
</html>
