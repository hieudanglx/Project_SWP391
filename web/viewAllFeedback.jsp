<%-- 
    Document   : viewAllFeedback.jsp
    Created on : Mar 11, 2025
    Author     : TRAN NHU Y - CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Feedback</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            body {
                display: flex;
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: #343a40;
                color: white;
                position: fixed;
                padding-top: 20px;
                transition: background-color 0.3s;
            }
            .sidebar a {
                padding: 10px 15px;
                text-decoration: none;
                font-size: 18px;
                color: white;
                display: block;
                transition: background-color 0.3s ease;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .content {
                margin-left: 250px;
                width: calc(100% - 250px);
                padding: 20px;
            }
            .navbar-custom {
                background: white;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                padding: 10px 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
<!--        <div class="sidebar">
            <h4 class="text-center">
                <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
            </h4>
            <a href="/ListAccountStaff"><i class="fas fa-chart-bar"></i> Manager Staff</a>
            <a href="listAccountCustomer"><i class="fas fa-users"></i> Manage Customer</a>
            <a href="listProductsForAdmin"><i class="fas fa-box"></i> Manage Products</a>
            <a href="listOrderAdmin"><i class="fas fa-box"></i> Manage Orders</a>
            <a href="feedback"><i class="fas fa-cog"></i> Manager Feedback</a>
            <a href="Revenue"><i class="fas fa-cog"></i> Manager Revenue</a>
            <a href="ListInventory"><i class="fas fa-cog"></i> Manager Inventory</a>
        </div>-->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4>Admin Dashboard - View All Feedback</h4>
                <div class="ms-auto">
                    <a href="/viewProfileStaff" class="text-decoration-none text-dark me-3 fw-bold"> ${sessionScope.fullname}</a>
                    <a href="javascript:void(0);" class="text-lg-startr fw-bold" onclick="logout()">Logout</a>
                </div>
            </nav>  

            <div class="container mt-4">
                <h2 class="text-center">Danh sách Feedback</h2>

                <!-- Hiển thị thông báo thành công -->
                <c:if test="${not empty sessionScope.repSuccess}">
                    <div id="successMessage" class="alert alert-success">${sessionScope.repSuccess}</div>
                    <c:remove var="repSuccess" scope="session"/>
                </c:if>

                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div id="errorMessage" class="alert alert-danger">${sessionScope.errorMessage}</div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Nội dung</th>
                            <th>Điểm đánh giá</th>
                            <th>Product ID</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty feedbackList}">
                                <c:forEach var="feedback" items="${feedbackList}">
                                    <tr>
                                        <td>${feedback.feedbackID}</td>
                                        <td>${customerNames[feedback.customerID] != null ? customerNames[feedback.customerID] : 'Không xác định'}</td>
                                        <td>${feedback.content}
                                            <div id="reply_${feedback.feedbackID}">
                                                <c:if test="${not empty feedbackReplies[feedback.feedbackID]}">
                                                    <br><strong>Phản hồi:</strong> ${feedbackReplies[feedback.feedbackID]}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>${feedback.ratePoint}</td>
                                        <td>${productNames[feedback.productID] != null ? productNames[feedback.productID] : 'Không xác định'}</td>

                                        <td>
                                            <div class="card p-3 mb-2">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <a href="feedback?action=delete&feedbackID=${feedback.feedbackID}" class="btn btn-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>
                                                    <form action="feedback" method="post" class="w-100 ms-3">
                                                        <input type="hidden" name="action" value="reply">
                                                        <input type="hidden" name="feedbackID" value="${feedback.feedbackID}">
                                                        <input type="hidden" name="customerID" value="${feedback.customerID}">

                                                        <c:choose>
                                                            <c:when test="${sessionScope.username eq 'admin'}">
                                                                <div class="mb-2">
                                                                    <label for="staffID">Admin:</label>
                                                                    <input type="hidden" name="staffID" value="${sessionScope.adminID}">
                                                                    <span class="fw-bold">${sessionScope.adminID}</span>
                                                                </div>
                                                                <div class="mb-2">
                                                                    <label for="replyContent_${feedback.feedbackID}" class="form-label">Nhập phản hồi:</label>
                                                                    <textarea name="replyContent" id="replyContent_${feedback.feedbackID}" 
                                                                              class="form-control" placeholder="Nhập phản hồi..." required></textarea>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="mb-2">
                                                                    <label for="staffID">Staff ID:</label>
                                                                    <input type="hidden" name="staffID" value="${sessionScope.staffId}">
                                                                    <span class="fw-bold">${sessionScope.staffId}</span>
                                                                </div>

                                                                <div class="mb-2">
                                                                    <label for="replyContent_${feedback.feedbackID}" class="form-label">Nhập phản hồi:</label>
                                                                    <textarea name="replyContent" id="replyContent_${feedback.feedbackID}" 
                                                                              class="form-control" placeholder="Nhập phản hồi..." required></textarea>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <button type="submit" class="btn btn-primary w-100">Gửi phản hồi</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center">Không có feedback nào.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- JavaScript để ẩn thông báo sau 5 giây -->
        <script>
            setTimeout(function () {
                let successMsg = document.getElementById("successMessage");
                let errorMsg = document.getElementById("errorMessage");
                if (successMsg)
                    successMsg.style.display = "none";
                if (errorMsg)
                    errorMsg.style.display = "none";
            }, 3000);
        </script>
        <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', {method: 'POST'})
                        .then(response => {
                            if (response.ok) {
                                window.location.href = '/LoginOfDashboard.jsp';
                            } else {
                                alert('Logout Fail!');
                            }
                        })
                        .catch(error => console.error('Logout Error:', error));
            }
        </script>
    </body>
</html>

