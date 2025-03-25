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
                width: 1140px !important;
                min-width: 1140px !important;
                margin: 0 auto;
                padding: 30px 15px;
                min-height: 70vh;
            }

            /* Đè style Bootstrap */
            @media (min-width: 1140px) {
                .cart-container {
                    max-width: 1140px !important;
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
            .bg-gradient-primary {
                background: linear-gradient(135deg, #ff4d4d, #d80000);
            }

            .payment-icon-circle {
                width: 80px;
                height: 80px;
                background-color: rgba(0, 123, 255, 0.1);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
            }

            .btn-primary {
                background-color: #d9000d;
                border-color: #c8000d;
            }

            .btn-primary:hover {
                background-color: #b30000;
                border-color: #a30000;
            }

            .btn-shine {
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(
                    90deg,
                    rgba(255, 255, 255, 0) 0%,
                    rgba(255, 255, 255, 0.2) 50%,
                    rgba(255, 255, 255, 0) 100%
                    );
                animation: btn-shine 3s infinite;
            }

            @keyframes btn-shine {
                0% {
                    left: -100%;
                }
                20% {
                    left: 100%;
                }
                100% {
                    left: 100%;
                }
            }
        </style>
    </head>
    <body data-status="${sessionScope.status}" data-message="${sessionScope.message}">
        <c:remove var="status" scope="session"/>
        <c:remove var="message" scope="session"/>
        <%@include file="header.jsp" %>

        <!-- Main Container -->
        <form action="PaymentController" method="post">
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
                                                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ
                                                            </div>

                                                            <div class="d-flex align-items-center gap-3">
                                                                <div class="input-group quantity-input-group">
                                                                    <a href="UpdateCartController?id=${product.productID}&type=-"
                                                                       class="btn btn-outline-secondary px-3"
                                                                       style="margin: 0;"
                                                                       onclick="return decreaseQuantity(${product.productID}, ${product.quantityProduct}) || false;">-</a>
                                                                    <input type="text"
                                                                           class="form-control text-center border-secondary" style="width: 100px"
                                                                           value="${product.quantityProduct}"
                                                                           disabled>
                                                                    <a href="UpdateCartController?id=${product.productID}&type=%2B"
                                                                       class="btn btn-outline-secondary px-3"
                                                                       style="margin: 0"
                                                                       >+</a>
                                                                </div>
                                                                <!-- Nút xóa -->
                                                                <a href="RemoveInCartController?id=${product.productID}"
                                                                   class="btn btn-link text-danger"
                                                                   onclick="return confirmRemove(${product.productID})">
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
                                            <input type="tel"  
                                                   name="phone"
                                                   value="${sessionScope.customer.phoneNumber}"
                                                   class="form-control"
                                                   pattern="[0-9]{10}"
                                                   required>
                                        </div>

                                        <!-- Địa chỉ giao hàng -->
                                        <div class="mb-4">
                                            <!-- Chọn Tỉnh/Thành phố -->
                                            <label class="form-label">Tỉnh/Thành phố</label>
                                            <select class="form-select mb-2" id="city" name="city" required>
                                                <option value="">Chọn tỉnh/thành phố</option>
                                            </select>
                                            <input type="hidden" id="cityName" name="cityName">

                                            <!-- Chọn Quận/Huyện -->
                                            <label class="form-label">Quận/Huyện</label>
                                            <select class="form-select mb-2" id="district" name="district" required>
                                                <option value="">Chọn quận/huyện</option>
                                            </select>
                                            <input type="hidden" id="districtName" name="districtName">

                                            <!-- Địa chỉ chi tiết -->
                                            <label class="form-label">Địa chỉ cụ thể</label>
                                            <input type="text" class="form-control mb-4" name="street" placeholder="Số nhà, tên đường..." required>                                       
                                            <p id="addressError" class="text-danger" style="display: none;">Vui lòng nhập đầy đủ địa chỉ trước khi thanh toán!</p>

                                        </div>


                                        <!-- Dynamic Total Calculation -->
                                        <c:set var="total" value="${0}"/>
                                        <c:forEach items="${list}" var="product">
                                            <c:set var="total" value="${total + (product.price * product.quantityProduct)}"/>
                                        </c:forEach>
                                        <c:set var="sessionScope.total" value="${total}" />


                                        <!-- Order Summary -->
                                        <div class="mb-4">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <span>Tạm tính:</span>
                                                <span class="fw-bold" >
                                                    <fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ
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
                                                    <fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ
                                                </span>
                                            </div>
                                        </div>
                                        <input type="hidden" name="total" value="${total}">
                                        <!-- Payment Methods -->
                                        <div class="mb-4">
                                            <h5 class="mb-3">Hình thức thanh toán</h5>

                                            <div class="form-check mb-3">
                                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                                <lab    el class="form-check-label d-flex align-items-center gap-2" for="cod">
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
                                        <button type="button" class="btn btn-danger w-100 py-3 fw-bold position-relative overflow-hidden" id="openConfirmModal">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <i class="fas fa-wallet me-2"></i>
                                                <span>Thanh toán ngay</span>
                                            </div>
                                            <div class="btn-shine"></div>
                                        </button>


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

        </form>
        <!-- Modal Xác Nhận -->
        <div class="modal fade" id="confirmPaymentModal" tabindex="-1" aria-labelledby="confirmPaymentLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow">
                    <div class="modal-header bg-gradient-primary text-white border-0">
                        <h5 class="modal-title" id="confirmPaymentLabel">
                            <i class="fas fa-shopping-cart me-2"></i>Xác nhận thanh toán
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body py-4">
                        <div class="text-center mb-3">
                            <div class="payment-icon-circle mb-3">
                                <i class="fas fa-credit-card fa-2x text-primary"></i>
                            </div>
                            <h5 class="fw-bold">Bạn có chắc chắn muốn thanh toán không?</h5>
                            <p class="text-muted">Vui lòng xác nhận để hoàn tất quá trình thanh toán của bạn</p>
                        </div>
                    </div>
                    <div class="modal-footer border-0 justify-content-center">
                        <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Hủy bỏ
                        </button>
                        <button type="button" class="btn btn-primary px-4" id="confirmPaymentBtn">
                            <i class="fas fa-check me-1"></i>Xác nhận
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Popup Xác Nhận (Dùng trong giỏ hàng) -->
        <div class="confirm-popup-overlay" id="confirmPopup">
            <div class="confirm-popup-content shadow-lg">
                <div class="confirm-popup-body">
                    <div class="confirm-popup-icon">⚠️</div>
                    <h5 class="confirm-popup-title" id="confirmPopupMessage"></h5>
                </div>
                <div class="confirm-popup-footer">
                    <button type="button" class="btn btn-secondary" onclick="hideConfirmPopup()">Hủy</button>
                    <button type="button" class="btn btn-danger" id="confirmActionBtn">Xác nhận</button>
                </div>
            </div>
        </div>

        <!-- Popup Thông Báo (Dùng cho các trang khác) -->
        <div class="alert-popup-overlay" id="alertPopup">
            <div class="alert-popup-content">
                <div class="alert-popup-icon" id="alertIcon"></div>
                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                <h5 class="alert-popup-message" id="alertMessage"></h5>
            </div>
        </div>

    </body>
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            var paymentForm = document.querySelector("form[action='PaymentController']");
                            var openModalBtn = document.getElementById("openConfirmModal");
                            var confirmBtn = document.getElementById("confirmPaymentBtn");

                            openModalBtn.addEventListener("click", function () {
                                var city = document.getElementById("city");
                                var district = document.getElementById("district");
                                var street = document.querySelector("input[name='street']");
                                var errorMessage = document.getElementById("addressError");

                                var isValid = true;

                                if (!city.value) {
                                    highlightField(city);
                                    isValid = false;
                                }
                                if (!district.value) {
                                    highlightField(district);
                                    isValid = false;
                                }
                                if (!street.value.trim()) {
                                    highlightField(street);
                                    isValid = false;
                                }

                                if (!isValid) {
                                    errorMessage.style.display = "block"; // Hiển thị thông báo lỗi
                                    return; // Dừng lại nếu địa chỉ chưa đầy đủ
                                }

                                errorMessage.style.display = "none"; // Ẩn thông báo lỗi nếu hợp lệ

                                var confirmModal = new bootstrap.Modal(document.getElementById("confirmPaymentModal"));
                                confirmModal.show();
                            });

                            confirmBtn.addEventListener("click", function () {
                                confirmBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Đang xử lý...';
                                confirmBtn.disabled = true;

                                setTimeout(function () {
                                    paymentForm.submit();
                                }, 1000);
                            });

                            function highlightField(field) {
                                field.classList.add("border", "border-danger");
                                setTimeout(() => {
                                    field.classList.remove("border", "border-danger");
                                }, 3000);
                            }
                        });

    </script>       
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

        // window.addEventListener('resize', enforceCartWidth);
        //enforceCartWidth(); // Khởi chạy lần đầu

        document.addEventListener("DOMContentLoaded", function () {
            const citySelect = document.getElementById("city");
            const districtSelect = document.getElementById("district");
            // Lấy dữ liệu tỉnh/thành phố từ GitHub
            const fetchData = async () => {
                try {
                    const response = await axios.get("https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json");
                    const data = response.data;
                    renderCities(data);
                } catch (error) {
                    console.error("Lỗi khi tải dữ liệu địa chỉ:", error);
                }
            };
            // Hiển thị danh sách tỉnh/thành phố
            const renderCities = (data) => {
                citySelect.innerHTML = '<option value="">Chọn tỉnh/thành phố</option>';
                districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                data.forEach(province => {
                    let option = document.createElement("option");
                    option.value = province.Id;
                    option.setAttribute("data-name", province.Name);
                    option.textContent = province.Name;
                    citySelect.appendChild(option);
                });
                // Khi chọn tỉnh, cập nhật danh sách quận/huyện
                citySelect.addEventListener("change", function () {
                    const selectedCityId = this.value;
                    const selectedCity = data.find(p => p.Id === selectedCityId);
                    document.getElementById("cityName").value = selectedCity ? selectedCity.Name : "";
                    districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                    if (selectedCity) {
                        selectedCity.Districts.forEach(district => {
                            let option = document.createElement("option");
                            option.value = district.Id;
                            option.setAttribute("data-name", district.Name);
                            option.textContent = district.Name;
                            districtSelect.appendChild(option);
                        });
                    }
                });
                // Khi chọn quận/huyện, cập nhật giá trị ẩn
                districtSelect.addEventListener("change", function () {
                    let selectedDistrict = districtSelect.options[districtSelect.selectedIndex];
                    document.getElementById("districtName").value = selectedDistrict.getAttribute("data-name") || "";
                });
            };
            fetchData();
        });
    </script>

    <script>
        document.getElementById("checkoutBtn").addEventListener("click", function () {
            let paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            if (paymentMethod === "COD") {
                window.location.href = "PaymentController";
            } else if (paymentMethod === "VNPAY") {
                window.location.href = "vnpay_pay.jsp";
            }
        });
    </script>
    <script src="js/popup.js"></script>
</html>