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
                        <li><a onclick="showSection('changePassword')">Ðổi mật khẩu</a></li>
                    </ul>
                </nav>
            </aside>

            <main class="profile-content">
                <!-- Profile Section -->
                <section id="profile" class="content-section active">
                    <h2><strong>Hồ sơ của tôi</strong></h2>
                    <p>Quản lý thông tin hồ sơ của bạn.</p>
                    <c:if test="${not empty sessionScope.updateSuccess}">
                        <script>
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: '${sessionScope.updateSuccess}',
                                showConfirmButton: false,
                                timer: 2000
                            });
                        </script>
                        <% session.removeAttribute("updateSuccess"); %> 
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <script>
                            Swal.fire({
                                icon: 'error',
                                title: 'Error!',
                                text: '${errorMessage}',
                                showConfirmButton: true
                            });
                        </script>
                    </c:if>

                    <form action="EditAccount_Staff" method="POST">
                        <div class="profile-details">
                            <label>Staff ID</label>
                            <input type="text" name="staffID" value="${sessionScope.staff.staffID}" readonly>

                            <label>Tên người dùng</label>
                            <input type="text" name="username" value="${sessionScope.staff.username}" readonly>

                            <label>Họ và tên</label>
                            <input type="text" name="fullName" value="${sessionScope.staff.fullName}" required>

                            <label>Email</label>
                            <input type="email" name="email" value="${sessionScope.staff.email}" required>

                            <label>Số điện thoại</label>
                            <input type="text" name="phoneNumber" value="${sessionScope.staff.phoneNumber}" required>

                            <label>Địa chỉ</label>
                            <input type="text" name="address" value="${sessionScope.staff.address}" required>

                            <label>CCCD</label>
                            <input type="text" name="cccd" value="${sessionScope.staff.cccd}" readonly>
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

                        <input type="hidden" name="email" value="${sessionScope.staff.email}" required>
                        <label>Mật khẩu hiện tại</label>
                        <input type="password" name="currentPassword" required>

                        <label>Mật khẩu mới</label>
                        <input type="password" id="newPassword" name="newPassword" required>

                        <label>Xác nhận mật khẩu mới</label>
                        <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>

                        <button type="submit" class="save-btn">Cập nhật mật khẩu</button>
                    </form>


                    <!-- Order History Section -->
                    <section id="orderHistory" class="content-section">
                        <h2><strong>Order History</strong></h2>
                        <p>View your past orders.</p>
                    </section>
            </main>
        </div>

        <script>
            function validatePassword() {
                let currentPassword = document.querySelector("input[name='currentPassword']").value;
                let newPassword = document.getElementById("newPassword").value;
                let confirmNewPassword = document.getElementById("confirmNewPassword").value;

                // Điều kiện: Ít nhất 1 chữ hoa, 1 số, và tối thiểu 8 ký tự
                let passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,}$/;

                if (!passwordRegex.test(newPassword)) {
                    Swal.fire({
                        icon: "error",
                        title: "Invalid Password",
                        text: "Mật khẩu phải có ít nhất 8 ký tự, chứa ít nhất 1 chữ hoa và 1 số!"
                    });
                    return false;
                }

                if (newPassword !== confirmNewPassword) {
                    Swal.fire({
                        icon: "error",
                        title: "Mismatch Password",
                        text: "Mật khẩu xác nhận không khớp!"
                    });
                    return false;
                }

                if (newPassword === currentPassword) {
                    Swal.fire({
                        icon: "error",
                        title: "Invalid Password",
                        text: "Mật khẩu mới không được trùng với mật khẩu cũ!"
                    });
                    return false;
                }

                return true;
            }
        </script>


        <script>
            function showSection(sectionId) {
                document.querySelectorAll('.content-section').forEach(section => {
                    section.classList.remove('active');
                });
                document.getElementById(sectionId).classList.add('active');
            }
        </script>
    </body>
</html>

