<%-- 
    Document   : ViewProfileOfCustomer
    Created on : Mar 3, 2025, 6:11:10 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Profile</title>  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                padding-top: 60px;
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #667eea, #764ba2);
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
                background: #333;
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
            input, select {
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
        <div id="wallpaper">
            <%@include file="header.jsp" %>

            <div class="profile-container">
                <aside class="sidebar">
                    <div class="user-info">
                        <i class="fas fa-user-circle fa-3x"></i>
                        <p>${sessionScope.customer.username}</p>
                    </div>
                    <nav class="profile-nav">
                        <ul>
                            <li><a onclick="showSection('profile')">Profile</a></li>
                            <li><a onclick="showSection('changePassword')">Change Password</a></li>
                            <li><a onclick="showSection('privacySettings')">Privacy Settings</a></li>
                            <li><a onclick="showSection('orderHistory')">Order History</a></li>
                        </ul>
                    </nav>
                </aside>

                <main class="profile-content">
                    <section id="profile" class="content-section active">
                        <h2><strong>My Profile</strong></h2>
                        <p>Manage profile information to keep your account secure</p>

                        <form action="UpdateProfile" method="POST">
                            <div class="profile-details">
                                <label>Username</label>
                                <input type="text" name="username" value="${sessionScope.customer.username}" readonly>

                                <label>Full Name</label>
                                <input type="text" name="fullName" value="${sessionScope.customer.fullName}" required>

                                <label>Email</label>
                                <input type="email" name="email" value="${sessionScope.customer.email}" required>

                                <label>Phone number</label>
                                <input type="text" name="phoneNumber" value="${sessionScope.customer.phoneNumber}" required>

                                <label>Address</label>
                                <input type="text" name="address" value="${sessionScope.customer.address}" required>

                                <label>BirthDay</label>
                                <input type="date" name="dob" value="${sessionScope.customer.dob}" required>

                                <label>Gender</label>
                                <select name="sex" required>
                                    <option value="Male" ${sessionScope.customer.sex == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${sessionScope.customer.sex == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${sessionScope.customer.sex == 'Other' ? 'selected' : ''}>Other</option>
                                </select>


                                <button type="submit" class="save-btn">Save Changes</button>
                            </div>
                        </form>
                    </section>

                    <section id="changePassword" class="content-section">
                        <h2><strong>Change Password</strong></h2>

                        <!-- Hiển thị thông báo lỗi nếu có -->
                        <c:if test="${not empty errorMessage}">
                            <p style="color: red;">${errorMessage}</p>
                        </c:if>

                        <form action="ChangePasswordOfCustomer" method="POST" onsubmit="return validatePassword()">
                            <input type="hidden" name="email" value="${sessionScope.customer.email}" required>

                            <label>Current Password</label>
                            <input type="password" name="currentPassword" required>

                            <label>New Password</label>
                            <input type="password" id="newPassword" name="newPassword" required>

                            <label>Confirm New Password</label>
                            <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>

                            <button type="submit" class="save-btn">Update Password</button>
                        </form>
                    </section>


                    <section id="privacySettings" class="content-section">
                        <h2><strong>Privacy Settings</strong></h2>
                        <p>Manage your privacy preferences.</p>
                    </section>

                    <section id="orderHistory" class="content-section">
                        <h2><strong>Order History</strong></h2>
                        <p>View your past purchases.</p>
                    </section>
                </main>
            </div>

            <script>
                function validatePassword() {
                    let newPassword = document.getElementById("newPassword").value;
                    let confirmNewPassword = document.getElementById("confirmNewPassword").value;

                    // Điều kiện: Ít nhất 1 chữ hoa, 1 số, và tối thiểu 8 ký tự
                    let passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,}$/;

                    if (!passwordRegex.test(newPassword)) {
                        Swal.fire({
                            icon: "error",
                            title: "Invalid Password",
                            text: "Mật khẩu mới phải có ít nhất 8 ký tự, chứa ít nhất 1 chữ hoa và 1 số"
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
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
