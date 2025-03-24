<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - List Orders</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                overflow-x: hidden;
            }

            /* Sidebar */
            .sidebar {
                height: 100vh;
                width: 250px;
                background: linear-gradient(to bottom, #343a40, #212529);
                color: white;
                position: fixed;
                padding-top: 20px;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }
            .sidebar a {
                padding: 12px 20px;
                text-decoration: none;
                color: rgba(255, 255, 255, 0.8);
                display: block;
                transition: all 0.3s;
                border-left: 4px solid transparent;
            }
            .sidebar a:hover {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border-left: 4px solid #0d6efd;
            }
            .sidebar a i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            /* Main Content */
            .content {
                margin-left: 250px;
                padding: 25px;
                transition: all 0.3s ease;
            }

            /* Navbar */
            .navbar-custom {
                background-color: white;
                padding: 15px 25px;
                border-radius: 10px;
                box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
                margin-bottom: 25px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .navbar-custom h4 {
                font-weight: 600;
                color: #2b3035;
                margin: 0;
            }
            
            .profile {
                display: flex;
                align-items: center;
            }
            
            .profile a.profile-link {
                margin-right: 15px;
                font-weight: 600;
                color: #0d6efd;
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 6px;
                transition: all 0.2s;
            }
            
            .profile a.profile-link:hover {
                background-color: rgba(13, 110, 253, 0.1);
            }
            
            .btn-logout {
                padding: 8px 16px;
                border-radius: 6px;
                transition: all 0.2s;
                font-weight: 500;
                box-shadow: 0 2px 5px rgba(220, 53, 69, 0.2);
            }
            
            .btn-logout:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }

            /* Filter Button */
            .filter-button {
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                box-shadow: 0 2px 8px rgba(108, 117, 125, 0.25);
                transition: all 0.2s;
                background-color: #6c757d;
                color: white;
            }
            
            .filter-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
            }
            
            .dropdown-menu {
                border: none;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
                border-radius: 8px;
                padding: 10px 0;
            }
            
            .dropdown-item {
                padding: 8px 20px;
                transition: all 0.2s;
            }
            
            .dropdown-item:hover {
                background-color: rgba(13, 110, 253, 0.1);
                color: #0d6efd;
            }

            /* Table */
            .table-container {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            }
            
            .table {
                border-collapse: separate;
                border-spacing: 0;
            }
            
            .table thead th {
                background-color: #343a40;
                color: white;
                font-weight: 500;
                padding: 12px 18px;
                border: none;
            }
            
            .table thead th:first-child {
                border-top-left-radius: 8px;
            }
            
            .table thead th:last-child {
                border-top-right-radius: 8px;
            }
            
            .table tbody td {
                padding: 12px 18px;
                vertical-align: middle;
                border-top: none;
                border-bottom: 1px solid #eaeaea;
            }
            
            .table tbody tr:last-child td {
                border-bottom: none;
            }
            
            .table tbody tr:hover {
                background-color: rgba(240, 242, 245, 0.6);
                transition: background-color 0.2s;
            }
            
            .table-action-btn {
                margin-right: 5px;
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.2s;
            }
            
            .table-action-btn:hover {
                transform: translateY(-2px);
            }
            
            /* Button Styling */
            .btn-warning {
                box-shadow: 0 2px 5px rgba(255, 193, 7, 0.2);
            }
            
            .btn-warning:hover {
                box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
            }
            
            .btn-success {
                box-shadow: 0 2px 5px rgba(40, 167, 69, 0.2);
            }
            
            .btn-success:hover {
                box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
            }
            
            .btn-danger {
                box-shadow: 0 2px 5px rgba(220, 53, 69, 0.2);
            }
            
            .btn-danger:hover {
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }
            
            /* Status styles */
            .status-badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
                display: inline-block;
            }
            
            .status-pending {
                background-color: rgba(255, 193, 7, 0.1);
                color: #ffc107;
            }
            
            .status-shipping {
                background-color: rgba(13, 110, 253, 0.1);
                color: #0d6efd;
            }
            
            .status-cancelled {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
            }
            
            .status-success {
                background-color: rgba(40, 167, 69, 0.1);
                color: #28a745;
            }
            
            /* Price column styling */
            .price-column {
                font-weight: 600;
                color: #0d6efd;
            }
        </style>
    </head>
    <body>
        
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <nav class="navbar-custom">
                <h4><i class="fas fa-shopping-cart me-2"></i>Admin Dashboard - Order Management</h4>
                <div class="profile">
                    <a href="ManagerProfile.jsp" class="profile-link">
                        <i class="fas fa-user-circle me-1"></i>${sessionScope.Username}
                    </a>
                    <a href="javascript:void(0);" class="btn btn-danger btn-logout" onclick="logout()">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </nav>

            <!-- Status Filter -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="dropdown">
                    <button class="btn filter-button dropdown-toggle" type="button" id="filterStatusDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-filter me-1"></i>Lọc theo trạng thái
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="filterStatusDropdown">
                        <li><a class="dropdown-item" href="filterStatus"><i class="fas fa-list me-2"></i>Tất cả</a></li>
                        <li><a class="dropdown-item" href="filterStatus?status=Chờ xử lý"><i class="fas fa-clock me-2"></i>Chờ xử lý</a></li>
                        <li><a class="dropdown-item" href="filterStatus?status=Giao Hàng"><i class="fas fa-truck me-2"></i>Giao Hàng</a></li>
                        <li><a class="dropdown-item" href="filterStatus?status=Đã Hủy"><i class="fas fa-ban me-2"></i>Đã Hủy</a></li>
                        <li><a class="dropdown-item" href="filterStatus?status=Thành công"><i class="fas fa-check-circle me-2"></i>Thành công</a></li>
                    </ul>
                </div>
            </div>

            <!-- Orders Table -->
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer ID</th>
                            <th>Staff ID</th>
                            <th>Address</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Phone</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="order">
                            <tr>
                                <td><span class="badge bg-dark">${order.orderID}</span></td>
                                <td>${order.customerID}</td>
                                <td>${order.staffID}</td>
                                <td>${order.address}</td>
                                <td>${order.date}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'Chờ xử lý'}">
                                            <span class="status-badge status-pending">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Giao Hàng'}">
                                            <span class="status-badge status-shipping">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Đã Hủy'}">
                                            <span class="status-badge status-cancelled">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Thành công'}">
                                            <span class="status-badge status-success">${order.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${order.status}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${order.phoneNumber}</td>
                                <td class="price-column"><fmt:formatNumber value="${order.total}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</td>
                                <td>
                                    <a href="orderDetailForAdmin?orderID=${order.orderID}" class="btn btn-warning table-action-btn">
                                        <i class="fas fa-eye me-1"></i>Detail
                                    </a>
                                    <c:if test="${order.status == 'Chờ xử lý'}">
                                        <a href="javascript:void(0);" 
                                           onclick="confirmStatusChange(${order.orderID}, 'Giao Hàng', 'Xác nhận đơn hàng này?')" 
                                           class="btn btn-success table-action-btn">
                                            <i class="fas fa-check me-1"></i>Xác nhận
                                        </a>
                                    </c:if>
                                    <c:if test="${order.status == 'Giao Hàng'}">
                                        <a href="javascript:void(0);" 
                                           onclick="confirmStatusChange(${order.orderID}, 'Đã Hủy', 'Hủy đơn hàng này?')" 
                                           class="btn btn-outline-danger table-action-btn">
                                            <i class="fas fa-times me-1"></i>Hủy
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Status Change Confirmation Modal -->
        <div class="modal fade" id="statusChangeModal" tabindex="-1" aria-labelledby="statusChangeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header" id="modalHeader">
                        <h5 class="modal-title" id="statusChangeModalLabel">Xác nhận thay đổi trạng thái</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessage">Bạn có chắc muốn thay đổi trạng thái đơn hàng này?</p>
                        <div class="alert alert-info">
                            <div class="d-flex align-items-center mb-2">
                                <i class="fas fa-info-circle me-2 fs-5"></i>
                                <strong>Chi tiết đơn hàng:</strong>
                            </div>
                            <ul class="list-unstyled ms-4 mb-0">
                                <li><strong>Mã đơn hàng:</strong> <span id="orderIdDisplay"></span></li>
                                <li><strong>Trạng thái mới:</strong> <span id="newStatusDisplay"></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Hủy bỏ
                        </button>
                        <button type="button" class="btn" id="confirmStatusBtn" onclick="proceedWithStatusChange()">
                            <i class="fas fa-check me-1"></i>Xác nhận
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', { method: 'POST' })
                    .then(response => {
                        if (response.ok) {
                            window.location.href = '/LoginOfDashboard.jsp';
                        } else {
                            alert('Logout Failed!');
                        }
                    })
                    .catch(error => console.error('Logout Error:', error));
            }
            
            let orderIdToChange = null;
            let newStatus = null;
            
            function confirmStatusChange(orderId, status, message) {
                // Store the order ID and new status for the change action
                orderIdToChange = orderId;
                newStatus = status;
                
                // Update the modal content
                document.getElementById('orderIdDisplay').textContent = orderId;
                document.getElementById('newStatusDisplay').textContent = status;
                document.getElementById('modalMessage').textContent = message;
                
                // Update modal header and button styling based on status
                const modalHeader = document.getElementById('modalHeader');
                const confirmBtn = document.getElementById('confirmStatusBtn');
                
                if (status === 'Giao Hàng') {
                    modalHeader.className = 'modal-header bg-success text-white';
                    confirmBtn.className = 'btn btn-success';
                } else if (status === 'Đã Hủy') {
                    modalHeader.className = 'modal-header bg-danger text-white';
                    confirmBtn.className = 'btn btn-danger';
                }
                
                // Show the confirmation modal
                const statusModal = new bootstrap.Modal(document.getElementById('statusChangeModal'));
                statusModal.show();
            }
            
            function proceedWithStatusChange() {
                if (orderIdToChange && newStatus) {
                    window.location.href = "changeStatus?orderID=" + orderIdToChange + "&status=" + encodeURIComponent(newStatus);
                }
            }
        </script>
    </body>
</html>