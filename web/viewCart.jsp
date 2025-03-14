<%-- 
    Document   : viewCart
    Created on : Feb 25, 2025, 5:23:00 PM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/popup.css">
        <style>
            /* Fix cứng kích thước cho trang giỏ hàng */
            .cart-container {
                width: 1200px !important;
                min-width: 1200px !important;
                margin: 0 auto;
                padding: 30px 15px;
                min-height: 70vh;
            }

            /* Đè style Bootstrap */
            @media (min-width: 1200px) {
                .cart-container {
                    max-width: 1200px !important;
                }
            }

            .product-color {
                width: 25px;
                height: 25px;
                border-radius: 50%;
                border: 2px solid #dee2e6;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .cart-item-image {
                width: 120px;
                height: 120px;
                object-fit: contain;
                padding: 10px;
                background: #fff;
                border-radius: 8px;
                border: 1px solid #eee;
            }

            .quantity-input-group {
                width: 140px;
            }
            .payment-icon {
                width: 40px !important;
                height: 40px !important;
                border-radius: 6px;
                border: 1px solid #dee2e6;
                padding: 5px;
            }

            /* Responsive điều kiện */
            @media (max-width: 1200px) {
                body {
                    overflow-x: auto;
                }
                .cart-container {
                    min-width: 100% !important;
                }
            }
        </style>
    </head>
    <body data-status="${status} data-status="${Message}>
        <%@include file="header.jsp" %>

        <!-- Main Container -->
        <div class="container-lg cart-container">
            <c:choose>
                <c:when test="${size>0}">
                    <div class="row g-5">
                        <!-- Product List Column -->
                        <div class="col-lg-8">
                            <div class="d-flex align-items-center mb-4">
                                <h3 class="mb-0 me-3">Giỏ hàng</h3>
                                <span class="badge bg-primary rounded-pill">${size} sản phẩm</span>
                            </div>

                            <c:forEach items="${list}" var="product">
                                <c:if test="${product.quantityProduct>0}">
                                    <div class="card mb-3 shadow-sm">
                                        <div class="card-body">
                                            <div class="d-flex gap-4 align-items-center">
                                                <img src="${product.imageURL}" 
                                                     alt="${product.productName}" 
                                                     class="cart-item-image">

                                                <!-- Product Info -->
                                                <div class="flex-grow-1">
                                                    <h5 class="mb-2">${product.productName}</h5>

                                                    <!-- Color-->
                                                    <div class="d-flex gap-3 mb-3">
                                                        <div class="d-flex align-items-center gap-1">
                                                            <span class="text-muted small">${product.color}</span>
                                                        </div>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <span class="text-muted small">${product.ram}</span>
                                                        </div>
                                                        <div class="d-flex align-items-center gap-3">
                                                            <span class="text-muted small">${product.rom}</span>
                                                        </div>
                                                    </div>

                                                    <!-- Price & Quantity -->
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="text-danger fw-bold h5">
                                                            <fmt:formatNumber value="${product.price}" 
                                                                              type="currency" 
                                                                              currencySymbol="đ"/>
                                                        </div>

                                                        <div class="d-flex align-items-center gap-3">
                                                            <div class="input-group quantity-input-group">
                                                                <a href="UpdateCartController?id=${product.productID}&type=-"
                                                                   class="btn btn-outline-secondary px-3"
                                                                   style="margin: 0;"
                                                                   onclick="return decreaseQuantity(${product.productID}, ${product.quantityProduct});">-</a>
                                                                <input type="text"
                                                                       class="form-control text-center border-secondary" style="width: 100px"
                                                                       value="${product.quantityProduct}"
                                                                       disabled>
                                                                <a href="UpdateCartController?id=${product.productID}&type=%2B"
                                                                   class="btn btn-outline-secondary px-3"
                                                                   style="margin: 0; pointer-events: ${product.quantitySell == product.quantityProduct + 1 ? 'none' : 'auto'}; opacity: ${product.quantitySell == product.quantityProduct + 1 ? '0.5' : '1'};"
                                                                   onclick="return increaseQuantity(${product.productID}, ${product.quantityProduct});">+</a>
                                                            </div>
                                                            <a href="UpdateCartController?id=${product.productID}&type=R"
                                                               class="btn btn-link text-danger"
                                                               onclick="return confirmRemove(${product.productID});">
                                                                <i class="fas fa-trash fa-lg"></i>
                                                            </a>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>

                        <!-- Checkout Column -->
                        <div class="col-lg-4">

                            <div class="card border-primary shadow-lg">
                                <div class="card-header bg-primary text-white">
                                    <h4 class="mb-0">Thông tin thanh toán</h4>
                                </div>

                                <div class="card-body">
                                    <!-- Các phần thông tin khách hàng -->
                                    <div class="mb-4">
                                        <label class="form-label">Họ và tên</label>
                                        <input type="text" disabled
                                               name="fullname"
                                               value="${sessionScope.customer.fullName}"
                                               class="form-control"
                                               required>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="tel"  disabled
                                               name="phone"
                                               value="${sessionScope.customer.phoneNumber}"
                                               class="form-control"
                                               pattern="[0-9]{10}"
                                               required>
                                    </div>

                                    <!-- Địa chỉ giao hàng -->
                                    <div class="mb-4">
                                        <label class="form-label">Địa chỉ nhận hàng</label>
                                        <div class="address-selector">
                                            <select class="form-select mb-2" id="city" name="city" required>
                                                <option value="">Chọn tỉnh/thành phố</option>
                                            </select>
                                            <select class="form-select mb-2" id="district" name="district" required>
                                                <option value="">Chọn quận/huyện</option>
                                            </select>
                                            <input type="text" 
                                                   class="form-control"
                                                   name="street"
                                                   placeholder="Số nhà, tên đường..."
                                                   required>
                                        </div>
                                    </div>

                                    <!-- Dynamic Total Calculation -->
                                    <c:set var="total" value="${0}"/>
                                    <c:forEach items="${list}" var="product">
                                        <c:set var="total" value="${total + (product.price * product.quantityProduct)}"/>
                                    </c:forEach>

                                    <!-- Order Summary -->
                                    <div class="mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span>Tạm tính:</span>
                                            <span class="fw-bold">
                                                <fmt:formatNumber value="${total}" 
                                                                  type="currency" 
                                                                  currencySymbol="đ"/>
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>Phí vận chuyển:</span>
                                            <span class="text-success">Miễn phí</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between align-items-center h5">
                                            <span>Tổng cộng:</span>
                                            <span class="text-danger fw-bold">
                                                <fmt:formatNumber value="${total}" 
                                                                  type="currency" 
                                                                  currencySymbol="đ"/>
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Payment Methods -->
                                    <div class="mb-4">
                                        <h5 class="mb-3">Hình thức thanh toán</h5>

                                        <div class="form-check mb-3">
                                            <input class="form-check-input" 
                                                   type="radio" 
                                                   name="paymentMethod" 
                                                   id="cod" value="COD"
                                                   checked>
                                            <label class="form-check-label d-flex align-items-center gap-2" 
                                                   for="cod">
                                                <img src="https://cdn-icons-png.flaticon.com/512/2331/2331966.png" 
                                                     class="payment-icon">
                                                <div>
                                                    <div class="fw-bold">COD</div>
                                                    <small class="text-muted">Thanh toán khi nhận hàng</small>
                                                </div>
                                            </label>
                                        </div>

                                        <div class="form-check">
                                            <input class="form-check-input" 
                                                   type="radio" 
                                                   name="paymentMethod" value="VNPAY"
                                                   id="vnpay">
                                            <label class="form-check-label d-flex align-items-center gap-2" 
                                                   for="vnpay">
                                                <img src="https://images.seeklogo.com/logo-png/42/1/vnpay-logo-png_seeklogo-428006.png" 
                                                     class="payment-icon">
                                                <div>
                                                    <div class="fw-bold">VNPAY QR</div>
                                                    <small class="text-muted">Thanh toán qua ứng dụng</small>
                                                </div>
                                            </label>
                                        </div>
                                    </div>

                                    <!-- Checkout Button -->
                                    <a href="payment.jsp" class="btn btn-danger w-100 py-3 fw-bold">
                                        <i class="fas fa-wallet me-2"></i>
                                        Thanh toán ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- Empty Cart -->
                    <div class="empty-cart text-center py-5">
                        <div class="empty-cart-icon mb-4">
                            <i class="fas fa-shopping-cart fa-4x text-muted"></i>
                        </div>
                        <h2 class="mb-3">Giỏ hàng của bạn đang trống</h2>
                        <p class="text-muted mb-4">Hãy khám phá các sản phẩm mới nhất của chúng tôi!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
    <!-- Popup container -->
    <div class="popup-overlay" id="popupOverlay">
        <div class="popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <div id="popupIcon" class="popup-icon"></div>
            <h3 id="popupMessage"></h3>
            <div class="popup-buttons" id="popupButtons"></div>
        </div>
    </div>
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
                // Xử lý fixed width
                function enforceCartWidth() {
                    const container = document.querySelector('.cart-container');
                    if (window.innerWidth < 1200) {
                        container.style.transform = `translateX(${(1200 - window.innerWidth)/2}px)`;
                    } else {
                        container.style.transform = 'none';
                    }
                }

                window.addEventListener('resize', enforceCartWidth);
                enforceCartWidth(); // Khởi chạy lần đầu

                // Xử lý API địa chỉ
                const citis = document.getElementById("city");
                const districts = document.getElementById("district");

                const fetchData = async () => {
                    try {
                        const response = await axios.get("https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json");
                        renderCity(response.data);
                    } catch (error) {
                        console.error("Lỗi khi tải dữ liệu địa chỉ:", error);
                    }
                };

                const renderCity = (data) => {
                    citis.innerHTML = '<option value="">Chọn tỉnh/thành phố</option>';
                    districts.innerHTML = '<option value="">Chọn quận/huyện</option>';

                    data.forEach(province => {
                        citis.options.add(new Option(province.Name, province.Id));
                    });

                    citis.onchange = function () {
                        districts.innerHTML = '<option value="">Chọn quận/huyện</option>';
                        if (this.value) {
                            const selectedProvince = data.find(p => p.Id === this.value);
                            selectedProvince.Districts.forEach(district => {
                                districts.options.add(new Option(district.Name, district.Id));
                            });
                        }
                    };
                };

                fetchData();
    </script>
    <script src="js/popup.js"></script>
</html>