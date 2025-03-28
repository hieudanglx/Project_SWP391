<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Lịch sử đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            .OrderHistory{
                 body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 900px;
                margin-top: 30px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }
            .filter-buttons {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }
            .filter-buttons a {
                text-decoration: none;
                padding: 10px 15px;
                border-radius: 5px;
                font-weight: bold;
                transition: 0.3s;
                color: black;
                background: #ddd;
                border: 1px solid #ccc;
            }
            .filter-buttons a:hover {
                background: #bbb;
                color: white;
            }
            .filter-buttons .active {
                background: #dc3545 !important;
                color: white !important;
            }
            .order-card {
                display: flex;
                border: 1px solid #ddd;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 15px;
                background: #fff;
                align-items: center;
                transition: 0.3s;
            }
            .order-card:hover {
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            .order-card img {
                width: 100px;
                height: 100px;
                border-radius: 5px;
                object-fit: cover;
            }
            .order-info {
                flex-grow: 1;
                margin-left: 15px;
            }
            .status-label {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 12px;
                font-weight: bold;
                margin-top: 5px;
            }
            .status-success {
                background: #28a745;
                color: white;
            }
            .status-pending {
                background: #ffc107;
                color: black;
            }
            .status-cancelled {
                background: #dc3545;
                color: white;
            }
            .price {
                color: red;
                font-weight: bold;
                font-size: 18px;
            }
            .order-actions {
                text-align: right;
            }
            .order-actions a {
                margin-left: 10px;
            }
            
            }
        </style>
    </head>
    
    <body>
        <%@include file="header.jsp" %>
        <%-- Hiển thị thông báo thành công hoặc lỗi --%>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <div class="OrderHistory container">
            <h2 class="text-center">Lịch sử đơn hàng</h2>

            


            <%-- Hiển thị thông báo khi hủy đơn --%>
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success" role="alert">
                    ${sessionScope.message}
                </div>
                <% session.removeAttribute("message"); %> <%-- Xóa sau khi hiển thị để tránh lặp lại --%>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger" role="alert">
                    ${sessionScope.error}
                </div>
                <% session.removeAttribute("error"); %> <%-- Xóa sau khi hiển thị --%>
            </c:if>

            <%-- Bộ lọc trạng thái đơn hàng --%>
            <div class="filter-buttons">
                <a href="Filter_Order_For_Customer" class="${empty param.status ? 'active' : ''}">Tất cả</a>
                <a href="Filter_Order_For_Customer?status=Chờ xử lý" class="${param.status eq 'Chờ xử lý' ? 'active' : ''}">Chờ xử lý</a>
                <a href="Filter_Order_For_Customer?status=Giao Hàng" class="${param.status eq 'Giao Hàng' ? 'active' : ''}">Giao Hàng</a>
                <a href="Filter_Order_For_Customer?status=Thành Công" class="${param.status eq 'Thành công' ? 'active' : ''}">Thành công</a>
                <a href="Filter_Order_For_Customer?status=Đã Hủy" class="${param.status eq 'Đã Hủy' ? 'active' : ''}">Đã Hủy</a>
            </div>

            <%-- Hiển thị danh sách đơn hàng --%>
            <c:set var="previousOrderID" value="0" />
            <c:forEach items="${orderDetails}" var="order">
                <c:if test="${order.orderID != previousOrderID}">
                    <div class="order-card">
                        <img src="${order.imageURL}" alt="Product Image">
                        <div class="order-info">
                            <h5>${order.productName} <small class="text-muted">(Đơn #${order.orderID})</small></h5>
                            <div>
                                <div class="text-muted small">
                                    <c:set var="orderCount" value="0" />
                                    <c:forEach items="${orderDetails}" var="detailItem">
                                        <c:if test="${detailItem.orderID == order.orderID}">
                                            <c:set var="orderCount" value="${orderCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${orderCount > 1}">
                                        và sản phẩm khác
                                    </c:if>
                                </div>   
                                <c:choose>
                                    <c:when test="${order.status eq 'Thành công'}">
                                        <span class="status-label status-success">${order.status}</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'Đã Hủy'}">
                                        <span class="status-label status-cancelled">${order.status}</span>
                                    </c:when>
                                    <c:when test="${fn:trim(order.status) eq 'Chờ Xử Lý' or fn:trim(order.status) eq 'Chờ xử lý'}">
                                        <span class="status-label status-pending">Chờ Xử Lý</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-label status-pending">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="price">
                                <fmt:formatNumber value="${order.price}" type="number" groupingUsed="true" /> đ
                            </div>
                        </div>
                        <div class="order-actions">
                            <p style="color: gray;">${order.date}</p>
                            <a href="OrderDetail?orderID=${order.orderID}" class="btn btn-outline-danger btn-sm">Xem chi tiết</a>



                            <%-- Chỉ hiển thị nút Feedback nếu đơn hàng có trạng thái "Thành công" --%>
                            <c:if  test="${fn:toLowerCase(fn:trim(order.status)) == 'thành công'}">
                                <button class="btn btn-outline-danger btn-sm" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#feedbackModal-${order.orderID}" 
                                        data-orderid="${order.orderID}">
                                    Ðánh giá
                                </button>



                                <!-- Modal Feedback (Mỗi đơn hàng có một modal riêng biệt) -->
                                <div class="modal fade" id="feedbackModal-${order.orderID}" tabindex="-1" aria-labelledby="feedbackModalLabel-${order.orderID}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="feedbackModalLabel-${order.orderID}">Viết đánh giá của bạn</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="SubmitReviewController" method="post">
                                                    <input type="hidden" name="orderID" value="${order.orderID}">
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
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <%-- Chỉ hiển thị nút hủy nếu đơn hàng đang chờ xử lý --%>
                            <c:if test="${fn:trim(order.status) eq 'Chờ Xử Lý' or fn:trim(order.status) eq 'Chờ xử lý'}">
                                <form action="Cancel_order" method="post" style="display:inline;">
                                    <input type="hidden" name="orderID" value="${order.orderID}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn này?');">
                                        Hủy đơn
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${fn:trim(order.status) eq 'Giao Hàng' or fn:trim(order.status) eq 'Giao hàng'}">
                                <form action="Confirm_order" method="post" style="display:inline;">
                                    <input type="hidden" name="orderID" value="${order.orderID}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        Đã nhận hàng
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                    <c:set var="previousOrderID" value="${order.orderID}" />
                </c:if>
            </c:forEach>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy tất cả các nút feedback
                var feedbackButtons = document.querySelectorAll(".feedback-btn");

                feedbackButtons.forEach(function (button) {
                    button.addEventListener("click", function () {
                        // Lấy orderID từ data-orderid của nút
                        var orderID = this.getAttribute("data-orderid");

                        // Tìm modal tương ứng theo ID động
                        var modal = document.getElementById("feedbackModal-" + orderID);

                        // Kiểm tra modal có tồn tại không
                        if (modal) {
                            var inputOrderID = modal.querySelector("input[name='orderID']");
                            if (inputOrderID) {
                                inputOrderID.value = orderID;
                            }

                            // Hiển thị modal
                            var modalInstance = new bootstrap.Modal(modal);
                            modalInstance.show();
                        }
                    });
                });
            });
        </script>
    <%@include file="footer.jsp" %>
    </body>
</html>
