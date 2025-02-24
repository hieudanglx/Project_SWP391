<%-- 
    Document   : ViewProductDetails
    Created on : Feb 24, 2025, 11:01:10 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Product Details</title>
        <style>
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                font-family: Arial, sans-serif;
            }

            .product-header {
                border-bottom: 2px solid #eee;
                padding-bottom: 20px;
                margin-bottom: 30px;
            }

            .product-title {
                font-size: 28px;
                color: #333;
                margin-bottom: 10px;
            }

            .badge {
                background: #ff4444;
                color: white;
                padding: 5px 10px;
                border-radius: 3px;
                font-size: 14px;
            }

            .product-content {
                display: grid;
                grid-template-columns: 1fr 300px;
                gap: 40px;
            }

            .specs-section {
                margin-bottom: 30px;
            }

            .specs-section h3 {
                color: #333;
                border-bottom: 1px solid #eee;
                padding-bottom: 10px;
            }

            .review-section {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
            }

            .rating {
                font-size: 24px;
                color: #ff9900;
                margin-bottom: 15px;
            }

            .review-box {
                background: white;
                padding: 15px;
                margin: 10px 0;
                border-radius: 5px;
            }

            .price-box {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .product-price {
                font-size: 32px;
                color: #e91e63;
                margin: 20px 0;
            }

            .btn-group {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-weight: bold;
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
        <div class="container">
            <!-- Phần header -->
            <div class="product-header">
                <h1 class="product-title">OPPO A3x 4GB/64GB</h1>
                <span class="badge">Drop-out</span>
            </div>

            <!-- Nội dung chính -->
            <div class="product-content">
                <!-- Cột trái -->
                <div>
                    <!-- Thông số kỹ thuật -->
                    <div class="specs-section">
                        <h3>Thông số kỹ thuật</h3>
                        <ul>
                            <li>Màn hình: 6.5" HD+</li>
                            <li>Camera sau: 13MP + 2MP</li>
                            <li>RAM: 4GB</li>
                            <li>Bộ nhớ trong: 64GB</li>
                        </ul>
                    </div>

                    <!-- Đánh giá -->
                    <div class="review-section">
                        <div class="rating">4.9 ★</div>

                        <!-- Đánh giá mẫu -->
                        <div class="review-box">
                            <strong>Nguyễn Đức Bình</strong>
                            <p>Điện thoại chạy mượt, pin trâu</p>
                        </div>

                        <div class="review-box">
                            <strong>E Phương</strong>
                            <p>Hài lòng với chất lượng camera</p>
                        </div>

                        <a href="#">Xem 11 đánh giá →</a>
                    </div>
                </div>

                <!-- Cột phải -->
                <div class="price-box">
                    <div class="product-price">14.190.000đ</div>

                    <div class="btn-group">
                        <button class="btn btn-cart">Thêm vào giỏ hàng</button>
                        <button class="btn btn-buy">Mua ngay</button>
                    </div>

                    <!-- Yêu cầu tư vấn -->
                    <div style="margin-top: 30px;">
                        <h4>Yêu cầu tư vấn</h4>
                        <textarea 
                            rows="4" 
                            style="width: 100%; margin: 10px 0; padding: 8px;"
                            placeholder="Nhập yêu cầu của bạn..."></textarea>
                        <button class="btn">Gửi yêu cầu</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>