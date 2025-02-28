<%-- 
    Document   : ViewProductDetails
    Created on : Feb 24, 2025, 11:01:10 PM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${product.productName}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Custom container width */
            .container {
                max-width: 1200px !important;
                margin: 0 auto;
                padding: 20px;
            }

            .product-header {
                border-bottom: 3px solid #0d6efd;
                padding-bottom: 1rem;
            }

            /* Image styling */
            .product-main-image {
                width: 50%;
                height: auto;
                margin: 20px auto;
                display: block;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .specs-table td {
                padding: 1rem;
                border-bottom: 1px solid #dee2e6;
            }

            .color-swatch {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 2px solid #dee2e6;
                cursor: pointer;
                transition: all 0.2s;
            }

            .color-swatch.selected {
                border-color: #0d6efd;
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.25);
            }

            .storage-option {
                min-width: 90px;
            }
            tr td {
                text-align: left;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container py-5">
            <div class="row g-4">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <div class="product-header mb-4">
                        <h1 class="display-4 fw-bold">${product.productName}</h1>
                    </div>

                    <!-- Product Image -->
                    <img src="${product.imageURL}" 
                         alt="${product.productName}" 
                         class="product-main-image rounded-3">

                    <!-- Tabs -->
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <button class="nav-link active" id="specs-tab" data-bs-toggle="tab" 
                                    data-bs-target="#specs" type="button" role="tab">Thông số kỹ thuật</button>
                            <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" 
                                    data-bs-target="#reviews" type="button" role="tab">Đánh giá (128)</button>
                        </div>
                    </nav>

                    <!-- Tab Content -->
                    <div class="tab-content mt-4">
                        <!-- Specifications -->
                        <div class="tab-pane fade show active" id="specs" role="tabpanel">
                            <table class="table specs-table">
                                <tr>
                                    <td>Hệ điều hành</td>
                                    <td>${product.operatingSystemName} ${product.operatingSystemVersion}</td>
                                </tr>
                                <tr>
                                    <td>Chip xử lý (CPU)</td>
                                    <td>${product.chipType} ${product.chipName}</td>
                                </tr>
                                <tr>
                                    <td>Chip đồ họa (GPU)</td>
                                    <td>${product.gpuType} ${product.gpuName}</td>
                                </tr>
                                <tr>
                                    <td>RAM</td>
                                    <td>${product.ram}</td>
                                </tr>
                                <c:if test="${product.categoryID==1}">
                                    <tr>
                                        <td>Loại RAM</td>
                                        <td>${product.ramType}</td>
                                    </tr>                                    
                                    <tr>
                                        <td>Hỗ trợ RAM tối đa</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.supportsUpgradingRAM == '1'}">
                                                    Có hỗ trợ nâng cấp
                                                </c:when>
                                                <c:when test="${product.supportsUpgradingRAM == '0'}">
                                                    Không hỗ trợ nâng cấp
                                                </c:when>
                                                <c:otherwise>
                                                    Unified (Hàng không công bố)
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td>Bộ nhớ trong</td>
                                    <td>${product.rom}</td>
                                </tr>
                                <c:if test="${product.categoryID==1}">
                                    <tr>
                                        <td>Hỗ trợ ROM tối đa</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.supportsUpgradingROM == '1'}">
                                                    Có hỗ trợ nâng cấp
                                                </c:when>
                                                <c:when test="${product.supportsUpgradingROM == '0'}">
                                                    Không hỗ trợ nâng cấp
                                                </c:when>
                                                <c:otherwise>
                                                    Unified (Hàng không công bố)
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${product.categoryID !=1}">
                                    <tr>
                                        <td>Camera trước</td>
                                        <td>${product.cameraFront}</td>
                                    </tr>
                                    <tr>
                                        <td>Camera sau</td>
                                        <td>${product.cameraBehind}</td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td>Màn hình</td>
                                    <td>${product.screenSize}</td>
                                </tr>
                                <tr>
                                    <td>Độ phân giải</td>
                                    <td>${product.screenResolution}</td>
                                </tr>
                                <tr>
                                    <td>Tần số quét</td>
                                    <td>${product.refreshRate}</td>
                                </tr>
                            </table>
                        </div>

                        <!-- Reviews -->
                        <div class="tab-pane fade" id="reviews" role="tabpanel">
                            <div class="d-flex align-items-center mb-4">
                                <h4 class="me-3">4.9</h4>
                                <div class="text-warning fs-5">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                </div>
                            </div>

                            <!-- Review Items -->
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h5 class="card-title">Nguyễn Đức Bình</h5>
                                        <div class="text-warning">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                    <p class="card-text">Điện thoại chạy mượt, pin trâu cả ngày</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <div class="card shadow-sm sticky-top" style="top: 100px;">
                        <div class="card-body">
                            <!-- Storage Options -->
                            <div class="mb-4">
                                <h5 class="mb-3">Bộ nhớ</h5>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:forEach items="${list}" var="p">
                                        <button type="button" 
                                                class="btn btn-outline-dark storage-option ${p.rom == selectedRom ? 'active' : ''}">
                                            ${p.rom}
                                        </button>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Color Options -->
                            <div class="mb-4">
                                <h5 class="mb-3">Màu sắc</h5>
                                <div class="d-flex flex-wrap gap-3">
                                    <c:forEach items="${list}" var="p">
                                        <div class="text-center">
                                            <div class="color-swatch ${p.color == selectedColor ? 'selected' : ''}" 
                                                 style="background-color: ${fn:toLowerCase(p.color)}">
                                            </div>
                                            <div class="mt-2 small">${p.color}</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Price -->
                            <div class="mb-4">
                                <h3 class="text-danger fw-bold">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" />
                                </h3>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-grid gap-2">
                                <button class="btn btn-lg btn-dark py-3">
                                    <i class="fas fa-cart-plus me-2"></i>
                                    Thêm vào giỏ hàng
                                </button>
                                <button class="btn btn-lg btn-primary py-3">
                                    <i class="fas fa-bolt me-2"></i>
                                    Mua ngay
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Xử lý chọn màu sắc
            document.querySelectorAll('.color-swatch').forEach(swatch => {
                swatch.addEventListener('click', function () {
                    document.querySelectorAll('.color-swatch').forEach(s => s.classList.remove('selected'));
                    this.classList.add('selected');
                });
            });

            // Xử lý chọn bộ nhớ
            document.querySelectorAll('.storage-option').forEach(option => {
                option.addEventListener('click', function () {
                    document.querySelectorAll('.storage-option').forEach(o => o.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        </script>
    </body>
</html>