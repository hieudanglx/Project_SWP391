<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Customer Management</title>

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
                margin: 0;
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
            }
            
            .table-action-btn:hover {
                transform: translateY(-2px);
            }
            
            .btn-block {
                background-color: #dc3545;
                border-color: #dc3545;
                box-shadow: 0 2px 5px rgba(220, 53, 69, 0.2);
            }
            
            .btn-block:hover {
                background-color: #bb2d3b;
                border-color: #b02a37;
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }
            
            .btn-unblock {
                background-color: #198754;
                border-color: #198754;
                box-shadow: 0 2px 5px rgba(25, 135, 84, 0.2);
            }
            
            .btn-unblock:hover {
                background-color: #157347;
                border-color: #146c43;
                box-shadow: 0 4px 8px rgba(25, 135, 84, 0.3);
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
            
            /* Customer Image */
            .customer-image {
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
        </style>
    </head>

    <body>
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="content">

            <!-- Navbar -->
            <div class="navbar-custom">
                <h4><i class="fas fa-users me-2"></i>Admin Dashboard - Customer Management</h4>
                <div class="profile">
                    <a href="ManagerProfile.jsp" class="profile-link">
                        <i class="fas fa-user-circle me-1"></i>${sessionScope.Username}
                    </a>
                    <a href="javascript:void(0);" class="btn btn-danger btn-logout" onclick="logout()">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </div>
            
            <!-- Search Bar -->
            <div class="search-container mb-4">
                <form action="SearchAccountCustomer" method="POST" class="search-box">
                    <input type="text" name="keyword" placeholder="Search by username..." autocomplete="off">
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
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Status</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="customer">
                            <c:if test="${customer.customerID != 0}">
                            <tr>
                                <td><span class="badge bg-dark">${customer.customerID}</span></td>
                                <td class="fw-medium">${customer.username}</td>
                                <td>${customer.fullName}</td>
                                <td>${customer.email}</td>                               
                                <td>${customer.phoneNumber}</td>
                                <td>${customer.sex}</td>
                                <td>
                                    <span class="status-badge ${customer.status == 0 ? 'active-status' : 'inactive-status'}">
                                        ${customer.status == 0 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty customer.imgCustomer}">
                                            <img src="${customer.imgCustomer}" alt="Customer" class="customer-image">
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">No Image</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>              
                                    <div class="d-flex">
                                        <form action="UpdateStatusCustomer" method="POST" class="me-2">
                                            <input type="hidden" name="customerID" value="${customer.customerID}">
                                            <input type="hidden" name="status" value="${customer.status}">
                                            <button type="submit" class="btn ${customer.status == 0 ? 'btn-block' : 'btn-unblock'} table-action-btn">
                                                <i class="fas ${customer.status == 0 ? 'fa-ban' : 'fa-check-circle'} me-1"></i>
                                                ${customer.status == 0 ? 'Block' : 'Unblock'}
                                            </button>
                                        </form>
                                        <a href="javascript:void(0);" class="btn btn-delete table-action-btn"
                                           onclick="confirmDelete(${customer.customerID}, '${customer.username}')">
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
                        <p class="mb-2">Are you sure you want to delete this customer account?</p>
                        <div class="alert alert-warning">
                            <div class="d-flex align-items-center mb-2">
                                <i class="fas fa-info-circle me-2 text-warning fs-5"></i>
                                <strong>Customer details:</strong>
                            </div>
                            <ul class="list-unstyled ms-4 mb-0">
                                <li><strong>ID:</strong> <span id="deleteCustomerId"></span></li>
                                <li><strong>Username:</strong> <span id="deleteCustomerName"></span></li>
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
            
            let customerToDelete = null;

            function confirmDelete(customerId, username) {
                // Store the customer ID for delete action
                customerToDelete = customerId;
                
                // Update the modal with customer details
                document.getElementById('deleteCustomerId').textContent = customerId;
                document.getElementById('deleteCustomerName').textContent = username;
                
                // Show the confirmation modal
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                deleteModal.show();
            }
            
            function proceedWithDelete() {
                if (customerToDelete) {
                    window.location.href = "DeletCustomerAccount?customerID=" + customerToDelete;
                }
            }
        </script>
    </body>
</html>