<%-- 
    Document   : ViewProfileOfCustomer
    Created on : Mar 3, 2025, 6:11:10 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    HttpSession sessionObj = request.getSession();
    String avatarPath = (String) sessionObj.getAttribute("avatarPath");
    String defaultAvatar = "images/default-avatar.png";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Profile</title>  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .profilex {
                body {
                    margin-top: 200px;
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

                .user-info img {
                    width: 80px; /* Nhỏ hơn */
                    height: 80px;
                    border-radius: 50%; /* Bo tròn */
                    border: 2px solid #ffcc00;
                    object-fit: cover; /* Hiển thị đẹp hơn */
                }

                .avatar-upload {
                    text-align: center;
                    margin-top: 20px;
                }

                .avatar-upload img {
                    width: 150px;
                    height: 150px;
                    border-radius: 50%;
                    object-fit: cover;
                    border: 2px solid #ddd;
                }

                .avatar-upload input {
                    display: block;
                    margin: 10px auto;
                }
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
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>
        <div id="wallpaper" class="profilex">
            <div class="profile-container">
                <aside class="sidebar">
                    <div class="user-info">
                        <img id="sidebarAvatar" src="<%= avatarPath != null ? request.getContextPath() + "/" + avatarPath : request.getContextPath() + "/" + defaultAvatar %>" alt="Avatar">
                        <p>${sessionScope.customer.username}</p>
                    </div>
                    <nav class="profile-nav">
                        <ul>
                            <li><a onclick="showSection('profile')">Profile</a></li>
                            <li><a onclick="showSection('changePassword')">Change Password</a></li>
                            <li><a onclick="showSection('changePhoneNumber')">Change Phone Number</a></li>
                            <li><a onclick="showSection('orderHistory')">Order History</a></li>
                        </ul>
                    </nav>
                </aside>

                <main class="profile-content">
                    <section id="profile" class="content-section active">
                        <h2><strong>My Profile</strong></h2>
                        <p>Manage profile information to keep your account secure</p>

                        <form action="UpdateProfile" method="POST">
                            <label>Username</label>
                            <input type="text" name="username" value="${sessionScope.customer.username}" readonly>

                            <label>Full Name</label>
                            <input type="text" name="fullName" value="${sessionScope.customer.fullName}" required>

                            <label>Email</label>
                            <input type="email" name="email" value="${sessionScope.customer.email}" readonly>

                            <label>Phone number</label>
                            <input type="text" name="phoneNumber" value="${sessionScope.customer.phoneNumber}" readonly>

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
                        </form>

                        <div class="avatar-upload">
                            <form action="${pageContext.request.contextPath}/UploadAvatarController" method="post" enctype="multipart/form-data">
                                <img id="avatarPreview" src="<%= avatarPath != null ? request.getContextPath() + "/" + avatarPath : request.getContextPath() + "/images/user-placeholder.png" %>" 
                                     alt="Avatar">
                                <input type="file" name="avatar" id="avatarInput" accept="image/*" onchange="previewAvatar(event)">
                                <button type="submit">Upload</button>
                            </form>
                        </div>
                    </section>


                    <script>
                        function previewAvatar(event) {
                            var reader = new FileReader();
                            reader.onload = function () {
                                var output = document.getElementById('avatarPreview');
                                output.src = reader.result;
                            };
                            reader.readAsDataURL(event.target.files[0]);
                        }
                    </script>



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


                    <section id="changePhoneNumber" class="content-section">
                        <h2><strong>Change Phone Number</strong></h2>

                        <!-- Hiển thị thông báo thành công -->
                        <c:if test="${not empty successMessage}">
                            <p style="color: green;">${successMessage}</p>
                        </c:if>

                        <!-- Hiển thị thông báo lỗi nếu có -->
                        <c:if test="${not empty errorMessage}">
                            <p style="color: red;">${errorMessage}</p>
                        </c:if>

                        <form action="ChangePhoneNumberOfCustomer" method="POST" onsubmit="return validatePhoneNumber()">
                            <input type="hidden" name="email" value="${sessionScope.customer.email}" required>

                            <label>Current Phone Number</label>
                            <input type="text" name="currentPhoneNumber" value="${sessionScope.customer.phoneNumber}" readonly>


                            <label>New Phone Number</label>
                            <input type="text" name="newPhoneNumber" required>

                            <button type="submit" class="save-btn">Update Phone Number</button>
                        </form>
                    </section>

                    <section id="orderHistory" class="content-section">
                        <a href="Order_History" class="btn btn-primary">View Order History</a>
                    </section>
                </main>
            </div>

            <script>
                function validatePhoneNumber() {
                    let currentPhoneNumber = document.querySelector("input[name='currentPhoneNumber']").value;
                    let newPhoneNumber = document.querySelector("input[name='newPhoneNumber']").value;

                    // Biểu thức chính quy: Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số
                    let phoneRegex = /^0\d{9}$/;

                    if (!phoneRegex.test(newPhoneNumber)) {
                        Swal.fire({
                            icon: "error",
                            title: "Invalid Phone Number",
                            text: "Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số!"
                        });
                        return false;
                    }

                    if (newPhoneNumber === currentPhoneNumber) {
                        Swal.fire({
                            icon: "error",
                            title: "Invalid Phone Number",
                            text: "Số điện thoại mới không được trùng với số cũ!"
                        });
                        return false;
                    }

                    return true;
                }
            </script>





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
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
