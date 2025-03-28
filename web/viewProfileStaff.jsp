<%-- 
    Document   : ViewProfileStaff
    Created on : Mar 3, 2025, 6:11:10 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Profile</title>  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #8396b3, #9eb1d0);
                margin: 0;
                padding: 0;
                color: #333;
            }
            .profile-container {
                display: flex;
                max-width: 1200px;
                margin: 40px auto;
                background: white;
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                overflow: hidden;
            }
            .sidebar {
                width: 250px;
                background: #2d2d2d;
                color: white;
                padding: 30px 20px;
            }
            .sidebar .user-info {
                text-align: center;
                margin-bottom: 30px;
            }
            .sidebar .user-info i {
                font-size: 60px;
                color: #ffcc00;
            }
            .sidebar .profile-nav ul {
                list-style: none;
                padding: 0;
            }
            .sidebar .profile-nav ul li {
                margin: 15px 0;
                text-align: left;
            }
            .sidebar .profile-nav ul li a {
                text-decoration: none;
                color: white;
                font-weight: bold;
                display: block;
                padding: 10px 15px;
                border-radius: 5px;
                transition: 0.3s;
            }
            .sidebar .profile-nav ul li a:hover {
                background: #ffcc00;
                color: black;
            }
            .profile-content {
                flex: 1;
                padding: 40px;
                background: #f8f9fa;
            }
            .content-section {
                display: none;
                animation: fadeIn 0.5s ease-in-out;
            }
            .content-section.active {
                display: block;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            h2 {
                border-left: 5px solid #ffcc00;
                padding-left: 10px;
                font-size: 22px;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            input {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .save-btn {
                margin-top: 20px;
                padding: 12px;
                background: #ffcc00;
                color: black;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                font-size: 16px;
                transition: 0.3s;
            }
            .save-btn:hover {
                background: #ff9900;
            }
            .error-message {
                color: #ff0000; /* Màu đỏ */
                font-size: 0.8rem;
                margin-top: 0.25rem;
                display: block;
            }

            .form-group {
                margin-bottom: 1rem;
                position: relative;
            }

            /* Màu đỏ khi input có lỗi */
            input.error {
                border-color: #ff0000;
            }
        </style>
    </head>
    <body>       
        <div class="profile-container">
            <aside class="sidebar">
                <div class="user-info">
                    <i class="fas fa-user-circle fa-3x"></i>
                    <p>${sessionScope.staff.username}</p>
                </div>
                <nav class="profile-nav">
                    <ul>
                        <li><a onclick="showSection('profile')">Hồ sơ</a></li>
                        <li><a onclick="showSection('changePassword')">Đổi mật khẩu</a></li>
                    </ul>
                </nav>
            </aside>

            <main class="profile-content">
                <!-- Profile Section -->
                <section id="profile" class="content-section active">
                    <h2><strong>Hồ sơ của tôi</strong></h2>
                    <p>Quản lý thông tin hồ sơ của bạn.</p>

                    <!-- Hiển thị thông báo chung -->
                    <c:if test="${not empty sessionScope.updateSuccess or not empty errorMessage}">
                        <script>
                            Swal.fire({
                                icon: '${not empty sessionScope.updateSuccess ? "success" : "error"}',
                                title: '${not empty sessionScope.updateSuccess ? "Success!" : "Error!"}',
                                text: '${not empty sessionScope.updateSuccess ? sessionScope.updateSuccess : errorMessage}',
                                showConfirmButton: ${not empty errorMessage},
                                timer: ${not empty sessionScope.updateSuccess ? '2000' : 'null'}
                            });
                            <% session.removeAttribute("updateSuccess"); %>
                        </script>
                    </c:if>

                    <form action="EditAccount_Staff" method="POST" onsubmit="return validateProfileForm()">
                        <div class="profile-details">
                            <div class="form-group">
                                <label>Staff ID</label>
                                <input type="text" name="staffID" value="${sessionScope.staff.staffID}" readonly>
                            </div>

                            <div class="form-group">
                                <label>Tên người dùng</label>
                                <input type="text" name="username" value="${sessionScope.staff.username}" readonly>
                            </div>

                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" name="fullName" value="${sessionScope.staff.fullName}" required>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" id="email" name="email" value="${sessionScope.staff.email}" required>
                                <span id="emailError" class="error-message"></span>
                            </div>

                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" id="phoneNumber" name="phoneNumber" value="${sessionScope.staff.phoneNumber}" required>
                                <span id="phoneError" class="error-message"></span>
                            </div>

                            <div class="form-group">
                                <label>Địa chỉ</label>
                                <input type="text" name="address" value="${sessionScope.staff.address}" required>
                            </div>

                            <div class="form-group">
                                <label>CCCD</label>
                                <input type="text" name="cccd" value="${sessionScope.staff.cccd}" readonly>
                            </div>

                            <button type="submit" class="save-btn">Lưu thay đổi</button>
                        </div>
                    </form>
                </section>

                <!-- Change Password Section -->
                <section id="changePassword" class="content-section">
                    <h2><strong>Thay đổi mật khẩu</strong></h2>

                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${not empty errorMessage}">
                        <p style="color: red;">${errorMessage}</p>
                    </c:if>

                    <form action="changePasswordStaff" method="POST" onsubmit="return validatePassword()">
                        <input type="hidden" name="email" value="${sessionScope.staff.email}">

                        <input type="hidden" name="email" value="${sessionScope.staff.email}" required>
                        <label>Mật khẩu hiện tại</label>
                        <input type="password" name="currentPassword" required>

                        <label>Mật khẩu mới</label>
                        <input type="password" id="newPassword" name="newPassword" required>

                        <label>Xác nhận mật khẩu mới</label>
                        <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>

                        <button type="submit" class="save-btn">Cập nhật mật khẩu</button>
                    </form>
                </section>
            </main>
        </div>

        <script>
            // Hàm chung để hiển thị các section
            function showSection(sectionId) {
                document.querySelectorAll('.content-section').forEach(section => {
                    section.classList.remove('active');
                });
                document.getElementById(sectionId).classList.add('active');
            }

            // Validate form profile
            function validateProfileForm() {
                const phoneNumber = document.getElementById('phoneNumber').value.trim();
                const email = document.getElementById('email').value.trim();

                // Clear previous errors
                document.querySelectorAll('.error-message').forEach(el => el.textContent = '');

                let isValid = true;

                // Validate phone number
                if (!phoneNumber) {
                    showError('phoneError', "Vui lòng nhập số điện thoại!");
                    isValid = false;
                } else if (!/^[0-9]{10}$/.test(phoneNumber) || !phoneNumber.startsWith('0')) {
                    showError('phoneError', "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0!");
                    isValid = false;
                }

                // Validate email
                if (!email) {
                    showError('emailError', "Vui lòng nhập email!");
                    isValid = false;
                } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    showError('emailError', "Email không hợp lệ!");
                    isValid = false;
                }

                return isValid;
            }

            // Validate password change
            function validatePassword() {
                const currentPassword = document.querySelector("input[name='currentPassword']").value;
                const newPassword = document.getElementById("newPassword").value;
                const confirmNewPassword = document.getElementById("confirmNewPassword").value;
                const passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,}$/;

                if (!passwordRegex.test(newPassword)) {
                    Swal.fire({
                        icon: "error",
                        title: "Mật khẩu không hợp lệ!",
                        text: "Mật khẩu phải có ít nhất 8 ký tự, chứa ít nhất 1 chữ hoa và 1 số!"
                    });
                    return false;
                }

                if (newPassword !== confirmNewPassword) {
                    Swal.fire({
                        icon: "error",
                        title: "Mật khẩu không khớp!",
                        text: "Mật khẩu xác nhận không trùng khớp!"
                    });
                    return false;
                }

                if (newPassword === currentPassword) {
                    Swal.fire({
                        icon: "error",
                        title: "Mật khẩu không hợp lệ",
                        text: "Mật khẩu mới không được trùng với mật khẩu hiện tại!"
                    });
                    return false;
                }

                return true;
            }

            // Helper function to show error messages
            function showError(elementId, message) {
                document.getElementById(elementId).textContent = message;
            }
        </script>
    </body>
</html>

