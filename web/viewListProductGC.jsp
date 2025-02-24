<%-- 
    Document   : viewListProductGC
    Created on : Feb 24, 2025, 2:46:46 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>view List Product</title>
        <style>
            .brand-container {
                display: flex;
                justify-content: center;
                gap: 10px;
                padding: 10px;
            }
            .brand-button {
                border: 1px solid #ccc;
                padding: 5px 10px;
                border-radius: 20px;
                cursor: pointer;
                background: #f1f1f1;
            }
            .product-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 20px;
                padding: 20px;
            }
            .product-card {
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 10px;
                text-align: center;
                background: #f9f9f9;
            }
            .product-card img {
                width: 100%;
                height: 150px;
                object-fit: cover;
                border-radius: 10px;
            }
            .product-name {
                font-size: 18px;
                font-weight: bold;
                margin: 10px 0;
            }
            .product-price {
                color: #e91e63;
                font-size: 16px;
            }
            .filter-container {
                position: absolute;
                top: 50px;
                left: 20px;
                width: 300px;
                background: white;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 10px;
                display: none;
                z-index: 1000;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
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
        <div class="brand-container">
            <button class="brand-button" onclick="toggleFilter()">Lọc</button>
            <c:forEach items="${brand}" var="b">
                <div  class="brand-button">${b}</div>
            </c:forEach>
        </div>
        <div class="product-container">
            <c:forEach items="${list}" var="p">
                <div class="product-card">
                    <a href="ViewProductDetailsController?id=${p.productID}">
                        <img src="${p.imageURL}" alt="${p.productName}">
                    </a>
                    <div class="product-name">${p.productName}</div>
                    <div class="product-price">${p.price}vnđ</div>
                </div>
            </c:forEach>
        </div>
        <div id="filter" class="filter-container">
            <form id="filterForm" action="FilterGCController?CategotyID=${CategotyID}" method="POST">
                <div class="filter-title">Filter Products</div>
                <div class="filter-section">
                    <label for="price-range">Price Range</label>
                    <div class="price-options">
                        <button type="button" onclick="setPrice(0, 2000000)">Dưới 2 triệu</button>
                        <button type="button" onclick="setPrice(2000000, 4000000)">Từ 2 - 4 triệu</button>
                        <button type="button" onclick="setPrice(4000000, 7000000)">Từ 4 - 7 triệu</button>
                        <button type="button" onclick="setPrice(7000000, 13000000)">Từ 7 - 13 triệu</button>
                        <button type="button" onclick="setPrice(13000000, 20000000)">Từ 13 - 20 triệu</button>
                        <button type="button" onclick="setPrice(20000000, 100000000)">Trên 20 triệu</button>
                    </div>
                    <div class="slider-container">
                        <input type="number" id="minPrice" name="minPrice" placeholder="Min Price" step="100000" min="0">
                        <input type="number" id="maxPrice" name="maxPrice" placeholder="Max Price" step="100000" min="0">
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
                    <label for="refresh_rate">Refresh Rate</label>
                    <select id="refresh_rate" name="refreshRate">
                        <option value="">All Rates</option>
                        <option value="60hz">60 Hz</option>
                        <option value="90hz">90 Hz</option>
                        <option value="120hz">120 Hz</option>
                        <option value="144hz">144 Hz</option>
                    </select>
                </div>
                <c:if test="${CategoryID}==1">
                    <div class="filter-section">
                        <label for="size">Screen size</label>
                        <select id="size" name="size">
                            <option value="">All size</option>
                            <option value="13">13"</option>
                            <option value="14">14"</option>
                            <option value="15.6">15.6"</option>
                            <option value="16">16"</option>
                        </select>
                    </div>
                </c:if>
                <c:if test="${CategoryID}==1">
                    <div class="filter-section">
                        <label for="Chip">Chip</label>
                        <select id="Chip" name="Chip">
                            <option value="">All Chip</option>
                            <option value="Intel Core">Intel Core</option>
                            <option value="Apple">Apple</option>
                        </select>
                    </div>
                </c:if>
                <c:if test="${CategoryID}==1">
                    <div class="filter-section">
                        <label for="GPU">GPU</label>
                        <select id="GPU" name="GPU">
                            <option value="">All GPU</option>
                            <option value="Card tích hợp">Card tích hợp</option>
                            <option value="NVIDIA GeForce">NVIDIA GeForce</option>
                        </select>
                    </div>
                </c:if>
                <div class="filter-buttons">
                    <button type="button" class="btn-clear" onclick="clearFilters()">Clear</button>
                    <button type="button" class="btn-apply" onclick="applyFilters()">Apply</button>
                </div>
            </form>
        </div>
        
        <script>
            function toggleFilter() {
                const filter = document.getElementById('filter');
                filter.style.display = filter.style.display === 'none' ? 'block' : 'none';
            }
            function applyFilters() {
                const minPrice = parseInt(document.getElementById('minPrice').value) || 0;
                const maxPrice = parseInt(document.getElementById('maxPrice').value) || 0;
                if (minPrice > maxPrice && maxPrice !== 0) {
                    alert('Min price cannot be greater than max price!');
                    return;
                }
                document.getElementById('filterForm').submit();
            }

            function clearFilters() {
                document.getElementById('brand').value = '';
                document.getElementById('minPrice').value = '';
                document.getElementById('maxPrice').value = '';
                document.getElementById('ram').value = '';
                document.getElementById('rom').value = '';
                document.getElementById('refresh-rate').value = '';
            }

            function setPrice(min, max) {
                document.getElementById('minPrice').value = min;
                document.getElementById('maxPrice').value = max;
            }
        </script>
    </body>
</html>