<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Product Detail</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
            
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --accent-color: #4895ef;
                --success-color: #4cc9f0;
                --warning-color: #f72585;
                --danger-color: #e63946;
                --light-color: #f8f9fa;
                --dark-color: #212529;
                --text-color: #2d3748;
                --text-muted: #64748b;
                --border-radius: 10px;
                --box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }
            
            body {
                display: flex;
                font-family: 'Poppins', sans-serif;
                background-color: #f0f2f5;
                color: var(--text-color);
            }
            
            /* Keeping the original sidebar styles */
            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
                transition: background-color 0.3s;
            }
            .sidebar a {
                padding: 10px 15px;
                text-decoration: none;
                font-size: 18px;
                color: white;
                display: block;
                transition: background-color 0.3s ease;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            
            .content {
                margin-left: 250px;
                width: calc(100% - 250px);
                padding: 25px;
            }
            
            /* Enhanced navbar */
            .navbar-custom {
                background: linear-gradient(135deg, white, #f8f9fa);
                box-shadow: var(--box-shadow);
                padding: 15px 25px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 25px;
                border-radius: var(--border-radius);
                border-left: 4px solid var(--primary-color);
            }
            
            .navbar-custom h4 {
                margin: 0;
                color: var(--primary-color);
                font-weight: 600;
                letter-spacing: 0.5px;
            }
            
            .profile {
                display: flex;
                align-items: center;
            }
            
            .profile a {
                margin-left: 15px;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s ease;
                padding: 8px 16px;
                border-radius: 30px;
                display: flex;
                align-items: center;
            }
            
            .profile-link {
                background-color: rgba(67, 97, 238, 0.1);
                color: var(--primary-color);
            }
            
            .logout-link {
                background-color: rgba(231, 84, 128, 0.1);
                color: var(--warning-color) !important;
            }
            
            .profile a:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            
            /* Card styles for all cards */
            .card {
                border: none;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                overflow: hidden;
            }
            
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
            
            /* Product detail container */
            .product-detail {
                background-color: white;
                padding: 0;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 30px;
                overflow: hidden;
            }
            
            .product-detail-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 20px 30px;
                position: relative;
            }
            
            .product-detail-header h2 {
                margin: 0;
                font-weight: 700;
                letter-spacing: 0.5px;
            }
            
            .product-detail-body {
                padding: 30px;
            }
            
            .product-image-container {
                position: relative;
                overflow: hidden;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
            }
            
            .product-image-container img {
                width: 100%;
                transition: transform 0.5s ease;
                border-radius: var(--border-radius);
            }
            
            .product-image-container:hover img {
                transform: scale(1.05);
            }
            
            .product-image-container::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to bottom, rgba(0,0,0,0) 70%, rgba(0,0,0,0.1));
                pointer-events: none;
            }
            
            .product-summary {
                background: linear-gradient(135deg, #ffffff, #f8f9fa);
                border-radius: var(--border-radius);
                padding: 20px;
                height: 100%;
            }
            
            .product-title {
                color: var(--primary-color);
                font-weight: 600;
                font-size: 1.5rem;
                margin-bottom: 10px;
            }
            
            .product-price {
                color: var(--success-color);
                font-weight: 700;
                font-size: 1.3rem;
                margin-bottom: 20px;
            }
            
            /* Specifications */
            .specs-container {
                margin-top: 30px;
            }
            
            .specs-title {
                position: relative;
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e2e8f0;
            }
            
            .specs-title::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 50px;
                height: 2px;
                background-color: var(--primary-color);
            }
            
            /* Enhanced table */
            .table-container {
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--box-shadow);
            }
            
            .table {
                margin-bottom: 0;
            }
            
            .table th, .table td {
                padding: 15px 20px;
                border: none;
                border-bottom: 1px solid #e2e8f0;
            }
            
            .table th {
                background-color: rgba(67, 97, 238, 0.05);
                color: var(--text-color);
                font-weight: 600;
                width: 35%;
            }
            
            .table tr:last-child th,
            .table tr:last-child td {
                border-bottom: none;
            }
            
            /* Alternating row colors */
            .table tbody tr:nth-of-type(odd) {
                background-color: rgba(67, 97, 238, 0.02);
            }
            
            .table tbody tr:hover {
                background-color: rgba(67, 97, 238, 0.05);
            }
            
            /* Badges */
            .badge {
                padding: 5px 10px;
                font-weight: 500;
                border-radius: 20px;
            }
            
            .badge.bg-info {
                background-color: rgba(67, 97, 238, 0.1) !important;
                color: var(--primary-color);
            }
            
            .badge.bg-success {
                background-color: rgba(76, 201, 240, 0.1) !important;
                color: var(--success-color);
            }
            
            .badge.bg-secondary {
                background-color: rgba(100, 116, 139, 0.1) !important;
                color: var(--text-muted);
            }
            
            .badge.bg-danger {
                background-color: rgba(231, 84, 128, 0.1) !important;
                color: var(--warning-color);
            }
            
            /* Action buttons */
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
            }
            
            .btn {
                padding: 10px 25px;
                font-weight: 500;
                border-radius: 30px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                border: none;
            }
            
            .btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }
            
            .btn:active {
                transform: translateY(-1px);
            }
            
            .btn-warning {
                background: linear-gradient(135deg, #4cc9f0, #4895ef);
                color: white;
            }
            
            .btn-danger {
                background: linear-gradient(135deg, #f72585, #e63946);
                color: white;
            }
            
            .btn-secondary {
                background: linear-gradient(135deg, #64748b, #475569);
                color: white;
            }
            
            /* Error message */
            .error-message {
                color: var(--warning-color);
                text-align: center;
                margin-bottom: 20px;
                padding: 15px;
                background-color: rgba(231, 84, 128, 0.1);
                border-radius: var(--border-radius);
                border-left: 4px solid var(--warning-color);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }
            
            /* Animation for page load */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            .content {
                animation: fadeIn 0.5s ease-out;
            }
            
            .product-info-item {
                display: flex;
                margin-bottom: 10px;
            }
            
            .product-info-label {
                font-weight: 600;
                color: var(--text-color);
                margin-right: 10px;
                flex: 0 0 40%;
            }
            
            .product-info-value {
                color: var(--text-muted);
                flex: 1;
            }
            
            /* Maintain category display logic */
            .category-1, .category-23 {
                display: none;
            }
        </style>
        <script>
            function toggleFields() {
                var category = "${product.categoryID}";

                // Nếu category = 1 (Laptop) -> Ẩn Camera, Hiện RAM Type & Upgrading
                if (category == "1") {
                    document.querySelectorAll('.category-1').forEach(el => el.style.display = "block");
                    document.querySelectorAll('.category-23').forEach(el => el.style.display = "none");
                }
                // Nếu category = 2 hoặc 3 (Dien Thoai/Tablet) -> Ẩn RAM Type & Upgrading, Hiện Camera
                else {
                    document.querySelectorAll('.category-1').forEach(el => el.style.display = "none");
                    document.querySelectorAll('.category-23').forEach(el => el.style.display = "block");
                }
            }

            // Gọi hàm khi trang tải xong để áp dụng ngay
            document.addEventListener("DOMContentLoaded", function () {
                toggleFields(); // Gọi khi trang tải xong
            });
        </script>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4><i class="fas fa-tag me-2"></i>Admin Dashboard - Product Detail</h4>

            </nav>

            <div class="product-detail">
                <div class="product-detail-header">
                    <h2 class="text-center"><i class="fas fa-box-open me-2"></i>Product Detail</h2>
                </div>
                
                <div class="product-detail-body">
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>
                    
                    <div class="row mb-4 g-4">
                        <div class="col-md-4">
                            <div class="product-image-container">
                                <img src="${product.imageURL}" alt="Product Image" class="img-fluid">
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="product-summary h-100">
                                <div class="product-title">${product.productName}</div>
                                <div class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ</div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="product-info-item">
                                            <div class="product-info-label">Product ID:</div>
                                            <div class="product-info-value">${product.productID}</div>
                                        </div>
                                        <div class="product-info-item">
                                            <div class="product-info-label">Brand:</div>
                                            <div class="product-info-value">${product.brand}</div>
                                        </div>
                                        <div class="product-info-item">
                                            <div class="product-info-label">Category:</div>
                                            <div class="product-info-value">
                                                <span class="badge bg-info">
                                                    <c:choose>
                                                        <c:when test="${product.categoryID == 1}">Laptop</c:when>
                                                        <c:when test="${product.categoryID == 2}">Dien Thoai</c:when>
                                                        <c:when test="${product.categoryID == 3}">Tablet</c:when>
                                                    </c:choose>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="product-info-item">
                                            <div class="product-info-label">Available:</div>
                                            <div class="product-info-value">
                                                <span class="badge bg-success">${product.quantityProduct} units</span>
                                            </div>
                                        </div>
                                        <div class="product-info-item">
                                            <div class="product-info-label">Sold:</div>
                                            <div class="product-info-value">
                                                <span class="badge bg-secondary">${product.quantitySell} units</span>
                                            </div>
                                        </div>
                                        <div class="product-info-item">
                                            <div class="product-info-label">Color:</div>
                                            <div class="product-info-value">${product.color}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="specs-container">
                        <h4 class="specs-title">Technical Specifications</h4>
                        
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="table-container">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th>Operating System</th>
                                                <td>${product.operatingSystemName} ${product.operatingSystemVersion}</td>
                                            </tr>
                                            <tr>
                                                <th>Screen Size</th>
                                                <td>${product.screenSize}</td>
                                            </tr>
                                            <tr>
                                                <th>Screen Resolution</th>
                                                <td>${product.screenResolution}</td>
                                            </tr>
                                            <tr>
                                                <th>Refresh Rate</th>
                                                <td>${product.refreshRate}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="table-container">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th>Chip Type</th>
                                                <td>${product.chipType}</td>
                                            </tr>
                                            <tr>
                                                <th>Chip Name</th>
                                                <td>${product.chipName}</td>
                                            </tr>
                                            <tr>
                                                <th>GPU Type</th>
                                                <td>${product.gpuType}</td>
                                            </tr>
                                            <tr>
                                                <th>GPU Name</th>
                                                <td>${product.gpuName}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row g-4 mt-2">
                            <div class="col-md-6">
                                <div class="table-container">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th>RAM</th>
                                                <td>${product.ram}</td>
                                            </tr>
                                            <tr>
                                                <th>ROM</th>
                                                <td>${product.rom}</td>
                                            </tr>
                                            
                                            <c:if test="${product.categoryID == 1}">
                                                <tr class="category-1">
                                                    <th>RAM Type</th>
                                                    <td>${product.ramType}</td>
                                                </tr>
                                                <tr class="category-1">
                                                    <th>Upgradable RAM</th>
                                                    <td>
                                                        <span class="badge ${product.supportsUpgradingRAM == '1' ? 'bg-success' : 'bg-danger'}">
                                                            ${product.supportsUpgradingRAM == '1' ? 'Yes' : 'No'}
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr class="category-1">
                                                    <th>Upgradable ROM</th>
                                                    <td>
                                                        <span class="badge ${product.supportsUpgradingROM == '1' ? 'bg-success' : 'bg-danger'}">
                                                            ${product.supportsUpgradingROM == '1' ? 'Yes' : 'No'}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="table-container category-23">
                                    <table class="table">
                                        <tbody>
                                            <c:if test="${product.categoryID == 2 || product.categoryID == 3}">
                                                <tr>
                                                    <th>Front Camera</th>
                                                    <td>${product.cameraFront}</td>
                                                </tr>
                                                <tr>
                                                    <th>Rear Camera</th>
                                                    <td>${product.cameraBehind}</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="updateProduct?productID=${product.productID}" class="btn btn-warning">
                            <i class="fas fa-edit"></i>
                            <span>Update</span>
                        </a>
<!--                        <a href="deleteProduct?productID=${product.productID}" 
                           onclick="return confirm('Are you sure you want to delete this product?');"
                           class="btn btn-danger">
                            <i class="fas fa-trash-alt"></i>
                            <span>Delete</span>
                        </a>-->
<!--                        <a href="listProductsForAdmin" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            <span>Back to List</span>
                        </a>-->
                    </div>
                </div>
            </div>
        </div>

      
    </body>
</html>