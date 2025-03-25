<%-- 
    Document   : ViewProductDetails
    Created on : Feb 24, 2025, 11:01:10 PM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List, java.util.Map, model.Feedback, model.Reply_Feedback" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${product.productName}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/popup.css">
        <style>
            .details{
                .tab-pane {
                    opacity: 0;
                    transition: opacity 0.5s ease-in-out;
                }

                .tab-pane.active {
                    opacity: 1;
                }
                .container {
                    max-width: 1200px !important;
                    width: 100% !important;
                    padding: 20px;
                    margin: 0 auto;
                    box-sizing: border-box;
                }
                .product-header {
                    border-bottom: 3px solid #0d6efd;
                    padding-bottom: 1rem;
                }
                .product-title {
                    font-size: 24px;
                    font-weight: 700;
                    color: #1a1a1a;
                    margin-bottom: 8px;
                    line-height: 1.3;
                }
                .sales-info {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }
                .sold-quantity {
                    font-size: 14px;
                    color: #666;
                    position: relative;
                    padding-left: 24px;
                }
                .sold-quantity::before {
                    content: "•";
                    position: absolute;
                    left: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #ccc;
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
                .avatar-basic {
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                    font-size: 20px;
                    color: white;
                    background-color: #6c757d;
                    text-transform: uppercase;
                }
            }
        </style>
    </head>
    <body data-status="${sessionScope.status}" data-message="${sessionScope.message}">
        <c:remove var="status" scope="session"/>
        <c:remove var="message" scope="session"/>
        <%@include file="header.jsp" %>

        <div class="container py-5 details">
            <div class="row g-4">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <div class="product-header mb-4">
                        <h1 class="product-title">
                            ${product.productName} ${product.ram} ${product.rom}  
                        </h1>
                        <div class="sales-info">
                            <span class="sold-quantity">
                                Đã bán 
                                <c:choose>
                                    <c:when test="${product.quantitySell >= 1000}">
                                        <fmt:formatNumber value="${product.quantitySell / 1000}" maxFractionDigits="1"/>k
                                    </c:when>
                                    <c:otherwise>
                                        ${product.quantitySell}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
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
                            <!-- Nội dung Thông số kỹ thuật -->
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
                            <!-- Nội dung Đánh giá -->

                            <div class="mb-4">
                                <h4>Viết đánh giá của bạn</h4>
                                <form action="SubmitReviewController" method="post">
                                    <input type="hidden" name="productID" value="${product.productID}">
                                    <div class="mb-3">
                                        <label class="form-label">Đánh giá (1-5 sao):</label>
                                        <select class="form-select" name="rating" required>
                                            <option value="5">⭐⭐⭐⭐⭐ - Rất tốt</option>
                                            <option value="4">⭐⭐⭐⭐ - Tốt</option>
                                            <option value="3">⭐⭐⭐ - Bình thường</option>
                                            <option value="2">⭐⭐ - Tệ</option>
                                            <option value="1">⭐ - Rất tệ</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Nội dung đánh giá:</label>
                                        <textarea class="form-control" name="comment" rows="3" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                                </form>
                            </div>
                            <% if (session.getAttribute("successMessage") != null) { %>
                            <div class="alert alert-success"><%= session.getAttribute("successMessage") %></div>
                            <% session.removeAttribute("successMessage"); }%>

                            <% if (session.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger"><%= session.getAttribute("errorMessage") %></div>
                            <% session.removeAttribute("errorMessage"); }%>

                            <div class="mt-4">
                                <h4>Đánh giá sản phẩm</h4>
                                <c:choose>
                                    <c:when test="${not empty feedbackList}">
                                        <c:forEach var="feedback" items="${feedbackList}">
                                            <c:set var="customerName" value="${customerNames[feedback.customerID] ne null ? customerNames[feedback.customerID] : 'Khách hàng Ẩn danh'}"/>
                                            <c:set var="initials" value="${fn:toUpperCase(fn:substring(customerName, 0, 1))}" />

                                            <div class="card shadow-sm mb-3">
                                                <div class="card-body">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <!-- Avatar basic (hình tròn có chữ viết tắt) -->
                                                        <div class="avatar-basic me-3">${initials}</div>

                                                        <div>
                                                            <h6 class="mb-0">${customerName}</h6>
                                                            <small class="text-muted">Mã phản hồi: ${feedback.feedbackID}</small>
                                                        </div>
                                                    </div>
                                                    <p class="mb-1">${feedback.content}</p>
                                                    <div class="text-warning">
                                                        <c:forEach begin="1" end="${feedback.ratePoint}">⭐</c:forEach>
                                                        (${feedback.ratePoint}/5)
                                                    </div>
                                                </div>
                                                <!-- Hiển thị phản hồi nếu có -->  
                                                <c:set var="hasReply" value="false" />
                                                <c:forEach var="item" items="${replyFeedbackList}">
                                                    <c:if test="${item.feedbackID == feedback.feedbackID}">
                                                        <c:set var="hasReply" value="true" />
                                                        <div class="mt-2 p-2 border rounded bg-light">
                                                            <strong>Phản hồi:</strong>
                                                            <p class="mb-1">${item.contentReply}</p>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${not hasReply}">
                                                    <p class="text-muted">Chưa có phản hồi.</p>
                                                </c:if>

                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>

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
                                    <c:if test="${empty list}">
                                        <button type="button" style="margin: 0"
                                                class="btn btn-outline-dark color-option active fw-bold">
                                            ${product.rom}
                                        </button>
                                    </c:if>
                                    <c:set var="shownROMs" value="" />
                                    <c:forEach items="${list}" var="p">
                                        <c:if test="${not fn:contains(shownROMs, p.rom)}">
                                            <c:set var="shownROMs" value="${shownROMs}${p.rom};" />
                                            <button type="button" style="margin: 0"
                                                    class="btn btn-outline-dark storage-option ${p.rom == product.rom ? 'active fw-bold' : ''}"
                                                    onclick="selectOption('rom', '${p.rom}')">
                                                ${p.rom}
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
                            <!-- Color Options -->
                            <div class="mb-4">
                                <h5 class="mb-3">Màu sắc</h5>
                                <div class="d-flex flex-wrap gap-3">
                                    <c:set var="shownColors" value="" />
                                    <c:if test="${empty list}">
                                        <button type="button" style="margin: 0"
                                                class="btn btn-outline-dark color-option active fw-bold">
                                            ${product.color}
                                        </button>
                                    </c:if>
                                    <c:forEach items="${list}" var="p">
                                        <c:if test="${not fn:contains(shownColors, p.color)}">
                                            <c:set var="shownColors" value="${shownColors}${p.color};" />
                                            <button type="button" style="margin: 0"
                                                    class="btn btn-outline-dark color-option ${p.color == product.color ? 'active fw-bold' : ''}"
                                                    onclick="selectOption('color', '${p.color}')">
                                                ${p.color}
                                            </button>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-grid gap-2">
                                <a href="UpdateCartController?id=${product.productID}&type=%2B&page=detail" class="btn btn-lg btn-dark py-3"
                                   <i class="fas fa-cart-plus me-2"></i>
                                    Thêm vào giỏ hàng
                                </a>
                                <a href="UpdateCartController?id=${product.productID}&type=%2B" class="btn btn-lg btn-primary py-3">
                                    <i class="fas fa-bolt me-2"></i>
                                    Mua ngay
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <!-- Popup Thông Báo (Dùng cho các trang khác) -->
        <div class="alert-popup-overlay" id="alertPopup">
            <div class="alert-popup-content">
                <div class="alert-popup-icon" id="alertIcon"></div>
                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                <h5 class="alert-popup-message" id="alertMessage"></h5>
            </div>
        </div>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/popup.js"></script>
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
                                                        const tabLinks = document.querySelectorAll('#nav-tab button');

                                                        tabLinks.forEach(button => {
                                                            button.addEventListener('shown.bs.tab', function (event) {
                                                                const targetTab = document.querySelector(event.target.dataset.bsTarget);
                                                                targetTab.classList.add("fade");
                                                            });
                                                        });
    </script>
</html>
