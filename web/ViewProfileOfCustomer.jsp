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
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .profile-container {
                display: flex;
                max-width: 900px;
                margin: 50px auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .sidebar {
                width: 200px;
                padding: 20px;
                background: #f8f9fa;
                border-right: 1px solid #ddd;
            }
            .profile-nav ul {
                list-style: none;
                padding: 0;
            }
            .profile-nav li {
                margin: 15px 0;
            }
            .profile-nav a {
                text-decoration: none;
                color: #333;
                font-weight: bold;
            }
            .profile-content {
                flex: 1;
                padding: 20px;
            }
            .profile-details label {
                display: block;
                margin-top: 15px;
                font-weight: bold;
            }
            .profile-details input {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background: #f9f9f9;
            }
            .avatar-section {
                text-align: center;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .avatar-large {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #ddd;
                background: #f0f0f0;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 50px;
                color: #aaa;
            }
            .avatar-btn {
                margin-top: 15px;
                padding: 10px 15px;
                background: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                font-size: 14px;
            }
            .avatar-input {
                display: none;
            }
            .save-btn {
                width: 100%;
                margin-top: 20px;
                padding: 12px;
                background: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                font-size: 16px;
            }
            .save-btn:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="profile-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="user-info">
                    <i class="fas fa-user-circle fa-3x"></i>
                    <p>${sessionScope.customer.username}</p>
                </div>
                <nav class="profile-nav">
                    <ul>
                        <li class="active"><a href="#">Profile</a></li>
                        <li><a href="ChangePassword.jsp">Change Password</a></li>
                        <li><a href="PrivacySettings.jsp">Privacy Settings</a></li>
                        <li><a href="OrderHistory.jsp">Order History</a></li>
                    </ul>
                </nav>
            </aside>
            <c:if test="${not empty sessionScope.updateSuccess}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: '${sessionScope.updateSuccess}'
                        }).then(() => {
                            window.location.href = "ViewProfileOfCustomer"; // Load lại trang sau khi đóng thông báo
                        });
                    });
                </script>
                <% session.removeAttribute("updateSuccess"); %> 
            </c:if>

            <!-- Profile Content -->
            <main class="profile-content">
                <h2><strong>My Profile</strong></h2>
                <p>Manage profile information to keep your account secure</p>

                <form action="UpdateProfile" method="POST">
                    <div class="profile-details">
                        <label>Username</label>
                        <input type="text" name="username" value="${sessionScope.customer.username}" required>

                        <label>Email</label>
                        <input type="email" name="email" value="${sessionScope.customer.email}" required>

                        <label>Phone number</label>
                        <input type="text" name="phoneNumber" value="${sessionScope.customer.phoneNumber}" required>

                        <label>Address</label>
                        <input type="text" name="address" value="${sessionScope.customer.address}" required>

                        <button type="submit" class="save-btn">Save Changes</button>
                    </div>
                </form>

            </main>

            <!-- Avatar Section -->
            <aside class="avatar-section">
                <div class="avatar-large" id="avatarPreview">
                    <i class="fas fa-user"></i>
                </div>
                <input type="file" id="avatarInput" class="avatar-input" accept="image/*" onchange="previewAvatar(event)">
                <button class="avatar-btn" onclick="document.getElementById('avatarInput').click();">Choose Avatar</button>
            </aside>
        </div>

        <script>
            function previewAvatar(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById("avatarPreview").innerHTML = `<img src="${e.target.result}" alt="Avatar" style="width: 100%; height: 100%; border-radius: 50%;">`;
                    }
                    reader.readAsDataURL(file);
                }
            }
        </script>
    </body>


</html> 




