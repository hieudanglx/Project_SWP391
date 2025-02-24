<%-- 
    Document   : ViewProductDetails
    Created on : Feb 24, 2025, 11:01:10 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${product.productName}</title>
        <style>
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                font-family: Arial, sans-serif;
                display: flex;
                gap: 40px;
            }

            .left-box {
                flex: 2;
            }

            .right-box {
                flex: 1;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                height: fit-content;
            }

            .product-title {
                font-size: 32px;
                color: #1a237e;
                font-weight: 700;
                margin: 20px 0;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
                padding-bottom: 15px;
                border-bottom: 3px solid #2196F3;
                display: inline-block;
            }

                .product-image {
                    width: 50%;
                    max-width: 500px;
                    margin-bottom: 20px;
                }

                .tab-container {
                    margin-top: 20px;
                }

                .tab-header {
                    display: flex;
                    gap: 20px;
                    border-bottom: 2px solid #eee;
                    margin-bottom: 20px;
                }

                .tab-button {
                    padding: 10px 20px;
                    background: none;
                    border: none;
                    cursor: pointer;
                    font-size: 18px;
                    color: #666;
                }

                .tab-button.active {
                    color: #2196F3;
                    border-bottom: 3px solid #2196F3;
                }

                .tab-content {
                    display: none;
                }

                .tab-content.active {
                    display: block;
                }

                .specs-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .specs-table td {
                    padding: 12px;
                    border-bottom: 1px solid #eee;
                }

                .specs-table td:first-child {
                    width: 40%;
                    font-weight: bold;
                }

                .color-options {
                    display: flex;
                    gap: 10px;
                    margin: 20px 0;
                }

                .color-display {
                    display: flex;
                    gap: 10px;
                    margin: 20px 0;
                }

                .color-box {
                    padding: 8px 16px;
                    border: 2px solid #ddd;
                    border-radius: 12px;
                    background: #f9f9f9;
                    font-size: 16px;
                    font-weight: bold;
                    color: #333;
                    text-align: center;
                }

                .product-price {
                    font-size: 32px;
                    color: #e91e63;
                    margin: 20px 0;
                }

                .btn-group {
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                }

                .btn {
                    padding: 15px 30px;
                    border: none;
                    border-radius: 25px;
                    cursor: pointer;
                    font-weight: bold;
                    text-align: center;
                }

                .btn-cart {
                    background: #4CAF50;
                    color: white;
                }

                .btn-buy {
                    background: #2196F3;
                    color: white;
                }
            </style>
        </head>
        <body>
            <%@include file="header.jsp" %>
            
            <div class="container">
                <!-- Cột trái -->
                <div class="left-box">
                    <h1 class="product-title">${product.productName}</h1>
                    <img src="${product.imageURL}" alt="${product.productName}" class="product-image">

                    <div class="tab-container">
                        <div class="tab-header">
                            <button class="tab-button active" onclick="switchTab('specs')">Thông số kỹ thuật</button>
                            <button class="tab-button" onclick="switchTab('reviews')">Bài viết đánh giá</button>
                        </div>

                        <div id="specs" class="tab-content active">
                            <table class="specs-table">
                                <tr>
                                    <td>Hệ điều hành</td>
                                    <td>${product.operatingSystem}</td>
                                </tr>
                                <tr>
                                    <td>Chip xử lý (CPU)</td>
                                    <td>${product.chip}</td>
                                </tr>
                                <tr>
                                    <td>Chip đồ họa (GPU)</td>
                                    <td>${product.gpu}</td>
                                </tr>
                                <tr>
                                    <td>RAM</td>
                                    <td>${product.ram}</td>
                                </tr>
                                <tr>
                                    <td>Bộ nhớ trong</td>
                                    <td>${product.rom}</td>
                                </tr>

                                <c:set var="cameraDetails" value="${fn:split(product.camera, ',')}" />
                                <c:forEach var="detail" items="${cameraDetails}" varStatus="status">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${status.index == 0}">Camera trước</c:when>
                                                <c:otherwise>Camera sau</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${detail}</td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td>Kích thước màn hình</td>
                                    <td>${product.size}</td>
                                </tr>
                                <tr>
                                    <td>Tần số quét</td>
                                    <td>${product.refreshRate}</td>
                                </tr>
                            </table>
                        </div>

                        <div id="reviews" class="tab-content">
                            <div class="rating">4.9 ★ (128 đánh giá)</div>

                            <div class="review">
                                <div class="review-header">
                                    <strong>Nguyễn Đức Bình</strong>
                                    <div class="rating">★★★★★</div>
                                </div>
                                <p>Điện thoại chạy mượt, pin trâu cả ngày</p>
                            </div>

                            <div class="review">
                                <div class="review-header">
                                    <strong>E Phương</strong>
                                    <div class="rating">★★★★☆</div>
                                </div>
                                <p>Hài lòng với chất lượng camera nhưng giá hơi cao</p>
                            </div>

                            <button class="btn">Xem tất cả đánh giá</button>
                        </div>
                    </div>
                </div>

                <!-- Cột phải -->
                <div class="right-box">
                    <div class="product-price">${product.price}đ</div>

                    <div class="color-display">
                        <span class="color-box">${product.color}</span>
                    </div>

                    <div class="btn-group">
                        <button class="btn btn-cart">Thêm vào giỏ hàng</button>
                        <button class="btn btn-buy">Mua ngay</button>
                    </div>
                </div>
            </div>

            <script>
                function switchTab(tabName) {
                    // Ẩn tất cả các tab content
                    document.querySelectorAll('.tab-content').forEach(content => {
                        content.classList.remove('active');
                    });

                    // Hiển thị tab được chọn
                    document.getElementById(tabName).classList.add('active');

                    // Cập nhật trạng thái nút tab
                    document.querySelectorAll('.tab-button').forEach(button => {
                        button.classList.remove('active');
                    });
                    event.currentTarget.classList.add('active');
                }

                // Xử lý chọn màu
                document.querySelectorAll('.color-option').forEach(option => {
                    option.addEventListener('click', function () {
                        document.querySelectorAll('.color-option').forEach(opt => {
                            opt.classList.remove('selected');
                        });
                        this.classList.add('selected');
                    });
                });
            </script>
        </body>
    </html>