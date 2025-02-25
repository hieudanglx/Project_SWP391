<%-- 
    Document   : viewCart
    Created on : Feb 25, 2025, 5:23:00 PM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .cart-container {
                padding: 2rem 0;
            }
            .product-color {
                width: 20px;
                height: 20px;
                border-radius: 50%;
                border: 1px solid #dee2e6;
            }
            .quantity-input {
                width: 60px;
                text-align: center;
            }
            .sticky-summary {
                position: sticky;
                top: 100px;
            }
            .payment-icon {
                width: 40px;
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container cart-container">
            <div class="row g-4">
                <!-- Danh sách sản phẩm -->
                <div class="col-lg-8">
                    <h4 class="mb-4">Giỏ hàng của bạn</h4>

                    <c:forEach items="${list}" var="product">
                        <div class="card mb-3 shadow-sm">
                            <div class="card-body">
                                <div class="d-flex align-items-center gap-3">
                                    <img src="${product.imageURL}" 
                                         alt="${product.productName}" 
                                         class="img-fluid" 
                                         style="width: 100px; height: 100px; object-fit: contain;">

                                    <div class="flex-grow-1">
                                        <h5 class="mb-1">${product.productName}</h5>
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <div class="product-color" style="background: ${product.color};"></div>
                                            <span class="text-muted">${product.color}</span>
                                        </div>
                                        <p class="text-danger fw-bold mb-3">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" />
                                        </p>

                                        <div class="d-flex align-items-center gap-3">
                                            <div class="input-group" style="width: 140px;">
                                                <button class="btn btn-outline-secondary">-</button>
                                                <input type="number" 
                                                       value="${product.quantityProduct}" 
                                                       class="form-control quantity-input">
                                                <button class="btn btn-outline-secondary">+</button>
                                            </div>
                                            <button class="btn btn-link text-danger">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Thông tin đặt hàng -->
                <div class="col-lg-4">
                    <div class="card shadow-sm sticky-summary">
                        <div class="card-body">
                            <h4 class="mb-4">Thông tin đặt hàng</h4>

                            <form>
                                <!-- Thông tin khách hàng -->
                                <div class="mb-3">
                                    <label class="form-label">Họ và tên</label>
                                    <input type="text" 
                                           value="${sessionScope.customer.username}"
                                           class="form-control"
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" 
                                           value="${sessionScope.customer.email}"
                                           class="form-control"
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" 
                                           value="${sessionScope.customer.phoneNumber}"
                                           class="form-control"
                                           required>
                                </div>

                                <!-- Địa chỉ giao hàng -->
                                <div class="mb-4">
                                    <label class="form-label">Địa chỉ nhận hàng</label>
                                    <select class="form-select mb-2" id="city">
                                        <option value="">Chọn tỉnh/thành phố</option>
                                    </select>
                                    <select class="form-select mb-2" id="district">
                                        <option value="">Chọn quận/huyện</option>
                                    </select>
                                    <input type="text" 
                                           class="form-control"
                                           placeholder="Số nhà, tên đường...">
                                </div>

                                <!-- Tổng thanh toán -->
                                <div class="mb-4">
                                    <h5 class="mb-3">Tổng thanh toán</h5>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tạm tính (${size} sản phẩm):</span>
                                        <strong class="text-danger">
                                            <c:set var="total" value="0" />
                                            
                                            <c:forEach items="${list}" var="product">
                                                <c:set var="total" value="${total + (product.price * product.quantityProduct)}" />
                                            </c:forEach>
                                        </strong>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-4">
                                        <span>Tổng cộng:</span>
                                        <strong class="text-danger">
                                            <fmt:formatNumber value="${total}" type="currency" currencySymbol="đ" />
                                        </strong>
                                    </div>
                                </div>

                                <!-- Hình thức thanh toán -->
                                <div class="mb-4">
                                    <h5 class="mb-3">Hình thức thanh toán</h5>
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" 
                                               type="radio" 
                                               name="payment" 
                                               id="cod">
                                        <label class="form-check-label d-flex align-items-center" for="cod">
                                            <img src="https://as2.ftcdn.net/v2/jpg/02/27/73/93/1000_F_227739395_BhszneMcufcAe9DJEBTHFFxVJM1PR8RT.jpg" 
                                                 class="payment-icon">
                                            COD - Thanh toán khi nhận hàng
                                        </label>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" 
                                               type="radio" 
                                               name="payment" 
                                               id="vnpay">
                                        <label class="form-check-label d-flex align-items-center" for="vnpay">
                                            <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR.png" 
                                                 class="payment-icon">
                                            Thanh toán qua VNPAY
                                        </label>
                                    </div>
                                </div>

                                <button class="btn btn-danger w-100 py-2">
                                    <i class="fas fa-shopping-bag me-2"></i>
                                    Đặt hàng ngay
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
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
    </body>
</html>