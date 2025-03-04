<%-- 
    Document   : viewListProductGC
    Created on : Feb 24, 2025, 2:46:46 PM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .product-card {
                transition: transform 0.2s;
                height: 100%;
            }
            .product-card:hover {
                transform: translateY(-5px);
            }
            .filter-offcanvas {
                max-width: 300px;
            }
            .price-range-btn {
                white-space: nowrap;
            }
            .chip-group {
                margin-bottom: 1rem;
            }
            .chip-list {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
            }
            .chip-item {
                border: 1px solid #ccc;
                padding: 0.5rem 1rem;
                border-radius: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container mt-4">
            <c:if test="${empty search}">
                <!-- Brand Filter -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#filterCanvas">
                        <i class="fas fa-filter me-2"></i>Lọc
                    </button>

                    <div class="d-flex gap-2">
                        <c:forEach items="${listbrand}" var="b">
                            <a href="FilterGCController?CategoryID=${CategoryID}&brand=${b}" 
                               class="btn btn-outline-secondary rounded-pill">
                                ${b}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            <!-- Product Grid -->
            <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                <c:forEach items="${list}" var="p">
                    <div class="col">
                        <div class="card h-100 product-card shadow-sm">
                            <a href="ViewProductDetailsController?name=${p.productName}&id=${p.productID}" class="text-decoration-none">
                                <img src="${p.imageURL}" class="card-img-top p-3" alt="${p.productName}">
                                <div class="card-body">
                                    <h5 class="card-title text-dark">${p.productName}</h5>
                                    <div class="text-danger fw-bold">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" />
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Filter Offcanvas -->
        <div class="offcanvas offcanvas-start" tabindex="-1" id="filterCanvas" class="filter-offcanvas">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title">Bộ lọc sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <form id="filterForm" action="FilterGCController?CategoryID=${CategoryID}" method="POST">
                    <!-- Price Filter -->
                    <div class="mb-6">
                        <label class="form-label">Khoảng giá</label>
                        <div class="d-flex flex-wrap gap-2 mb-3">
                            <button type="button" class="btn btn-outline-secondary price-range-btn" 
                                    onclick="setPrice(0, 10000000)">Dưới 10 triệu</button>
                            <button type="button" class="btn btn-outline-secondary price-range-btn" 
                                    onclick="setPrice(10000000, 20000000)">10-20 triệu</button>
                            <button type="button" class="btn btn-outline-secondary price-range-btn" 
                                    onclick="setPrice(20000000, 500000000)">Trên 20 triệu</button>
                        </div>
                        <div class="row g-2">
                            <div class="col">
                                <input type="number" class="form-control" id="minPrice" name="minPrice" 
                                       placeholder="Giá thấp nhất" step="100000" min="0" max="499900000">
                            </div>
                            <div class="col">
                                <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                       placeholder="Giá cao nhất" step="100000" min="100000" max="500000000" maxlength="9">
                            </div>
                        </div>
                    </div>
                    <div class="row g-3">
                        <!-- Other Filters -->
                        <div class="mb-6">
                            <label class="form-label">Hãng sản xuất</label>
                            <select class="form-select" id="brand" name="brand">
                                <option value="">Tất cả hãng</option>
                                <c:forEach items="${listbrand}" var="v">
                                    <option value="${v}">${v}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-6">
                            <label class="form-label">Loại sản phẩm</label>
                            <select class="form-select" id="os" name="os">
                                <option value="">Hệ điều hành</option>
                                <c:if test="${CategoryID==1}">
                                    <option value="Windows">Windows</option>
                                    <option value="macOS">MacBook</option>
                                </c:if>
                                <c:if test="${CategoryID==2}">
                                    <option value="iOS">IOS</option>
                                    <option value="Android">Android</option>
                                </c:if>
                                <c:if test="${CategoryID==3}">
                                    <option value="iPadOS">IPadOS</option>
                                    <option value="Android">Android</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">RAM</label>
                            <select class="form-select" id="ram" name="ram">
                                <option value="">Tất cả RAM</option>
                                <c:if test="${CategoryID!=1}">
                                    <option value="6gb">6 GB</option>
                                </c:if>
                                <option value="8gb">8 GB</option>
                                <c:if test="${CategoryID!=1}">
                                    <option value="12gb">12 GB</option>
                                </c:if>
                                <c:if test="${CategoryID!=3}">
                                    <option value="16gb">16 GB</option>
                                </c:if>
                                <c:if test="${CategoryID==1}">
                                    <option value="32gb">32 GB</option>
                                </c:if>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Bộ nhớ</label>
                            <select class="form-select" id="rom" name="rom">
                                <option value="">Tất cả bộ nhớ</option>
                                <c:if test="${CategoryID!=1}">
                                    <option value="128gb">128 GB</option>
                                </c:if>
                                <option value="256gb">256 GB</option>
                                <option value="512gb">512 GB</option>
                                <c:if test="${CategoryID==2}">
                                    <option value="1tb">1 TB</option>
                                </c:if>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tần số quét</label>
                            <select class="form-select" id="rate" name="rate">
                                <option value="">Tất cả tần số quét</option>
                                <option value="60hz">60 Hz</option>
                                <c:if test="${CategoryID!=1}">
                                    <option value="90hz">90 Hz</option>
                                </c:if>
                                <option value="120hz">120 Hz</option>
                                <c:if test="${CategoryID!=2}">
                                    <option value="144hz">144 Hz</option>
                                </c:if>
                            </select>
                        </div>
                        <c:if test="${CategoryID==1}">
                            <div class="col-md-6">
                                <label class="form-label">Độ phân giải</label>
                                <select class="form-select" id="res" name="res">
                                    <option value="">Tất cả độ phân giải</option>
                                    <option value="Full HD">Full HD</option>
                                    <option value="Full HD+">Full HD+</option>
                                    <option value="2K">2K</option>
                                    <option value="2K+">2K+</option>
                                    <option value="3.5K">3.5K</option>
                                    <option value="4K">4K</option>
                                    <option value="4K OLED">4K OLED</option>
                                    <option value="Retina">Retina</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Kích thước màn hình</label>
                                <select class="form-select" id="size" name="size">
                                    <option value="">Tất cả kích thước màn hình</option>
                                    <option value="13">13"</option>
                                    <option value="14">14"</option>
                                    <option value="15.6">15.6"</option>
                                    <option value="16">16"</option>
                                </select>
                            </div>
                            <c:forEach items="${Chip}" var="chipGroup" varStatus="i">
                                <div class="col-md-6">
                                    <label class="form-label">${Chiptype[i.count-1]}</label>
                                    <select class="form-select" id="${Chiptype[i.count-1]}" name="${Chiptype[i.count-1]}">
                                        <option value="">Tất cả chíp xử lí</option>
                                        <c:forEach items="${chipGroup}" var="chip">
                                            <option value="${chip}">${chip}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>

                    <!-- Additional Filters -->
                    <div class="mt-4 d-grid gap-3">
                        <button type="submit" class="btn btn-primary">Áp dụng bộ lọc</button>
                        <button type="button" class="btn btn-outline-danger" onclick="clearFilters()">Xóa bộ lọc</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function setPrice(min, max) {
                                document.getElementById('minPrice').value = min;
                                document.getElementById('maxPrice').value = max;
                            }
                            function validatePriceFields() {
                                const minPriceInput = document.getElementById('minPrice');
                                const maxPriceInput = document.getElementById('maxPrice');

                                let minPrice = minPriceInput.value.trim();
                                let maxPrice = maxPriceInput.value.trim();

                                if (minPrice === "" && maxPrice !== "") {
                                    minPriceInput.value = 0;
                                }

                                if (maxPrice === "" && minPrice !== "") {
                                    maxPriceInput.value = 500000000;
                                }
                            }

                            window.addEventListener('load', () => {
                                document.getElementById('minPrice').addEventListener('blur', validatePriceFields);
                                document.getElementById('maxPrice').addEventListener('blur', validatePriceFields);
                            });

                            function clearFilters() {
                                document.querySelectorAll('#filterForm select').forEach(select => {
                                    select.value = '';
                                });
                                document.getElementById('minPrice').value = '';
                                document.getElementById('maxPrice').value = '';
                            }
        </script>
    </body>
</html>