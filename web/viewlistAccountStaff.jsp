<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Staff Management</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

            /* Search Box */
            .search-container {
                width: 40%;
                margin: 0 auto;
            }

            .search-box {
                display: flex;
                align-items: center;
                background-color: white;
                border-radius: 8px;
                padding: 4px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
                border: 1px solid #e0e0e0;
                transition: all 0.3s;
            }

            .search-box:focus-within {
                box-shadow: 0 3px 15px rgba(13, 110, 253, 0.15);
                border-color: #0d6efd;
            }

            .search-box input {
                border: none;
                padding: 8px 15px;
                width: 100%;
                outline: none;
                font-size: 15px;
            }

            .search-box button {
                background-color: #0d6efd;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.2s;
            }

            .search-box button:hover {
                background-color: #0b5ed7;
            }

            /* Table */
            .table-container {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                overflow-x: auto;
            }

            .table {
                table-layout: auto; /* Tự động điều chỉnh kích thước cột dựa trên nội dung */
                width: 100%; /* Đảm bảo bảng chiếm toàn bộ chiều rộng */
            }

            .table th, .table td {
                white-space: normal; /* Cho phép văn bản xuống dòng */
                word-wrap: break-word; /* Tự động ngắt dòng nếu văn bản quá dài */
                overflow-wrap: break-word; /* Tương tự như word-wrap */
                padding: 12px 18px; /* Khoảng cách bên trong các ô */
                vertical-align: middle; /* Căn giữa nội dung theo chiều dọc */
            }

            .table thead th {
                background-color: #343a40; /* Màu nền header */
                color: white; /* Màu chữ */
                font-weight: 500; /* Độ đậm của chữ */
                padding: 12px 18px; /* Khoảng cách bên trong các ô */
                border: none; /* Loại bỏ đường viền */
            }

            .table thead th:first-child {
                border-top-left-radius: 8px; /* Bo tròn góc trên cùng bên trái */
            }

            .table thead th:last-child {
                border-top-right-radius: 8px; /* Bo tròn góc trên cùng bên phải */
            }

            .table tbody tr:last-child td {
                border-bottom: none;
            }

            .table tbody tr:hover {
                background-color: rgba(240, 242, 245, 0.6);
                transition: background-color 0.2s;
            }

            /* Status Badge */
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
                display: inline-block;
            }

            .active-status {
                background-color: rgba(40, 167, 69, 0.1);
                color: #28a745;
            }

            .inactive-status {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
            }

            /* Action Buttons */
            .table-action-btn {
                margin-right: 5px;
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.2s;
                min-width: 80px;
                text-align: center;
            }

            .table-action-btn:hover {
                transform: translateY(-2px);
            }

            .btn-edit {
                background-color: #ffc107;
                border-color: #ffc107;
                box-shadow: 0 2px 5px rgba(255, 193, 7, 0.2);
            }

            .btn-edit:hover {
                background-color: #e0a800;
                border-color: #d39e00;
                box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
            }

            .btn-delete {
                background-color: transparent;
                color: #dc3545;
                border-color: #dc3545;
                box-shadow: 0 2px 5px rgba(220, 53, 69, 0.1);
            }

            .btn-delete:hover {
                background-color: #dc3545;
                color: white;
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.2);
            }

            /* Staff Image */
            .staff-image {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #f0f2f5;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            /* Delete Confirmation Modal */
            .modal-header.bg-danger {
                background-color: #dc3545 !important;
            }

            .modal-title {
                font-weight: 600;
            }

            .modal-body .alert {
                border-radius: 8px;
                border: none;
            }

            /* Create Staff Button */
            .btn-create {
                background-color: #0d6efd;
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                margin-bottom: 20px;
                box-shadow: 0 3px 10px rgba(13, 110, 253, 0.2);
                transition: all 0.2s;
                display: inline-flex;
                align-items: center;
            }

            .btn-create:hover {
                background-color: #0b5ed7;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
            }

            .btn-create i {
                margin-right: 8px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <div class="navbar-custom">
                <h4><i class="fas fa-user-tie me-2"></i>Admin Dashboard - Staff Management</h4>                 
            </div>

            <!-- Create Staff Button -->
            <div class="d-flex justify-content-end mb-4">
                <a href="Create_account_staff.jsp" class="btn btn-create">
                    <i class="fas fa-user-plus"></i>Create Staff
                </a>
            </div>

            <!-- Search Bar -->
            <div class="search-container mb-4">
                <form action="SearchAccountStaff" method="POST" class="search-box">
                    <input type="text" name="fullname" placeholder="Search by full name..." autocomplete="off">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </form>
            </div>

            <!-- Hiển thị thông báo bằng SweetAlert2 -->
            <% String message = (String) session.getAttribute("message"); %>
            <% if (message != null) { %>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        title: "Notification",
                        text: "<%= message %>",
                        icon: "info",
                        confirmButtonText: "OK",
                        confirmButtonColor: "#0d6efd"
                    });
                });
            </script>
            <% session.removeAttribute("message"); %>
            <% } %>

            <!-- Table -->
            <div class="table-container" style="overflow-x: auto;">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>CCCD</th>
                            <th>Gender</th>
                            <th>BirthDay</th>
                            <th>Address</th>
                            <th>City</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="staff">
                            <c:if test="${staff.username ne 'admin'}">
                                <tr>
                                    <td><span class="badge bg-dark">${staff.staffID}</span></td>
                                    <td class="fw-medium">${staff.username}</td>
                                    <td>${staff.fullName}</td>
                                    <td>${staff.cccd}</td>
                                    <td>${staff.sex}</td>
                                    <td>${staff.dob}</td>
                                    <td>${staff.address}</td>
                                    <td>${staff.province_city}</td>
                                    <td>${staff.email}</td>                               
                                    <td>${staff.phoneNumber}</td>
                                    <td>
                                        <span class="status-badge ${staff.status == 0 ? 'active-status' : 'inactive-status'}">
                                            ${staff.status == 0 ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>              
                                        <div class="d-flex">
                                            <a href="EditAccountStaff_ForAdmin?staffID=${staff.staffID}" class="btn btn-edit table-action-btn me-2">
                                                <i class="fas fa-edit me-1"></i>Edit
                                            </a>
                                            <a href="javascript:void(0);" class="btn btn-delete table-action-btn"
                                               onclick="confirmDelete(${staff.staffID}, '${staff.username}')">
                                                <i class="fas fa-trash-alt me-1"></i>Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="deleteConfirmModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Confirm Deletion</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="mb-2">Are you sure you want to delete this staff account?</p>
                        <div class="alert alert-warning">
                            <div class="d-flex align-items-center mb-2">
                                <i class="fas fa-info-circle me-2 text-warning fs-5"></i>
                                <strong>Staff details:</strong>
                            </div>
                            <ul class="list-unstyled ms-4 mb-0">
                                <li><strong>ID:</strong> <span id="deleteStaffId"></span></li>
                                <li><strong>Username:</strong> <span id="deleteStaffName"></span></li>
                            </ul>
                        </div>
                        <p class="text-danger mb-0"><strong>This action cannot be undone.</strong></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn" onclick="proceedWithDelete()">
                            <i class="fas fa-trash-alt me-1"></i>Delete Account
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function logout() {
                fetch('/LogOutStaffAndAdminController', {method: 'POST'})
                        .then(response => {
                            if (response.ok)
                                window.location.href = '/LoginOfDashboard.jsp';
                            else
                                alert('Logout Failed!');
                        })
                        .catch(error => console.error('Logout Error:', error));
            }

            let staffToDelete = null;

            function confirmDelete(staffId, username) {
                // Store the staff ID for delete action
                staffToDelete = staffId;

                // Update the modal with staff details
                document.getElementById('deleteStaffId').textContent = staffId;
                document.getElementById('deleteStaffName').textContent = username;

                // Show the confirmation modal
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                deleteModal.show();
            }

            function proceedWithDelete() {
                if (staffToDelete) {
                    window.location.href = "DeleteAccount_Staff?staffID=" + staffToDelete;
                }
            }
        </script>
    </body>
</html>