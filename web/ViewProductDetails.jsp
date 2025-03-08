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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${product.productName}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .details{
                .container {
                    max-width: 1200px !important; /* Thêm !important để override Bootstrap */
                    width: 100% !important;       /* Sử dụng width 100% để responsive */
                    padding: 20px;
                    margin: 0 auto;
                    box-sizing: border-box;       /* Quan trọng: Tính toán kích thước bao gồm padding */
                }

                /* Giữ nguyên các style khác */
                .product-header {
                    border-bottom: 3px solid #0d6efd;
                    padding-bottom: 1rem;
                }

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
                    text-align: left;
                }

                .storage-option {
                    min-width: 90px;
                }

                .color-option {
                    min-width: 90px;
                    position: relative;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container py-5 details">
            <div class="row g-4">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <div class="product-header mb-4">
                        <h1 class="display-4 fw-bold">${product.productName}</h1>
                    </div>

                    <img src="${product.imageURL}" 
                         alt="${product.productName}" 
                         class="product-main-image rounded-3">

                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <button class="nav-link active" id="specs-tab" data-bs-toggle="tab" 
                                    data-bs-target="#specs" type="button" role="tab">Thông số kỹ thuật</button>
                            <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" 
                                    data-bs-target="#reviews" type="button" role="tab">Đánh giá (128)</button>
                        </div>
                    </nav>

                    <div class="tab-content mt-4">
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

                        <div class="tab-pane fade" id="reviews" role="tabpanel">

                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <!-- Storage Options -->
                            <div class="mb-4">
                                <h5 class="mb-3">Bộ nhớ</h5>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:set var="shownROMs" value="" />
                                    <c:forEach items="${list}" var="p">
                                        <c:if test="${not fn:contains(shownROMs, p.rom)}">
                                            <c:set var="shownROMs" value="${shownROMs}${p.rom};" />
                                            <button type="button" 
                                                    class="btn btn-outline-dark storage-option ${p.rom == product.rom ? 'active fw-bold' : ''}"
                                                    onclick="selectOption('rom', '${p.rom}')">
                                                ${p.rom}
                                            </button>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Color Options -->
                            <div class="mb-4">
                                <h5 class="mb-3">Màu sắc</h5>
                                <div class="d-flex flex-wrap gap-3">
                                    <c:set var="shownColors" value="" />
                                    <c:forEach items="${list}" var="p">
                                        <c:if test="${not fn:contains(shownColors, p.color)}">
                                            <c:set var="shownColors" value="${shownColors}${p.color};" />
                                            <button type="button" 
                                                    class="btn btn-outline-dark color-option ${p.color == product.color ? 'active fw-bold' : ''}"
                                                    onclick="selectOption('color', '${p.color}')">
                                                ${p.color}
                                            </button>
                                        </c:if>
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
                                <a href="UpdateCartController?id=${product.productID}&type=add&page=detail" class="btn btn-lg btn-dark py-3">
                                    <i class="fas fa-cart-plus me-2"></i>
                                    Thêm vào giỏ hàng
                                </a>
                                <a href="UpdateCartController?id=${product.productID}&type=buy" class="btn btn-lg btn-primary py-3">
                                    <i class="fas fa-bolt me-2"></i>
                                    Mua ngay
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        function selectOption(type, value) {
                                                            const productID = ${product.productID};
                                                            const currentRom = "${product.rom}";
                                                            const currentColor = "${product.color}";

                                                            // Tạo URL mới với tham số mới
                                                            let url = "ViewProductDetailsController?id=" + productID;

                                                            if (type === 'rom') {
                                                                url += "&selectedRom=" + encodeURIComponent(value) + "&selectedColor=" + encodeURIComponent(currentColor);
                                                            } else if (type === 'color') {
                                                                url += "&selectedColor=" + encodeURIComponent(value) + "&selectedRom=" + encodeURIComponent(currentRom);
                                                            }

                                                            // Load lại trang với tham số mới
                                                            window.location.href = url;
                                                        }
        </script>
    </body>
</html>