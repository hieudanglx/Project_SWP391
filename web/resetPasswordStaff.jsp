<%-- 
    Document   : resetPasswordStaff
    Created on : Feb 26, 2025, 2:20:41 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
        <style>
            .container {
                max-width: 500px;
                margin: 50px auto;
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
            }
            .xacnhan {
                background-color: #E5E1DA;
                border-radius: 10px;
                color: #547488;
                font-weight: 500;
                border: none;
                font-size: 16px;
                padding: 8px 20px;
                cursor: pointer;
            }
            .xacnhan:hover {
                background-color: #89A8B2;
                color: white;
            }
            .inputpassword {
                width: 30%;
                margin: 10px 0;
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #dee2e6;
                font-size: 16px;
            }
            .error-message {
                color: red;
                font-size: 14px;
                margin-top: 5px;
            }
        </style>
        <script>
            function validatePassword() {
                var password = document.getElementById("newPassword").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var passwordPattern = /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,16}$/;

                if (!password.match(passwordPattern)) {
                    document.getElementById("errorMessage").innerText = "Mật khẩu phải có 8-16 ký tự, ít nhất 1 chữ hoa và 1 số!";
                    return false;
                }
                if (password !== confirmPassword) {
                    document.getElementById("errorMessage").innerText = "Mật khẩu xác nhận không khớp!";
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <h2>Reset Password</h2>
            <form action="resetPasswordOfStaffController" method="post" onsubmit="return validatePassword();">
                <div>
                    <label>Nhập mật khẩu mới:</label><br>
                    <input class="inputpassword" type="password" id="newPassword" name="newPassword" required><br>
                    <label>Nhập lại mật khẩu:</label><br>
                    <input class="inputpassword" type="password" id="confirmPassword" name="confirmPassword" required><br>
                </div>
                <p id="errorMessage" class="error-message"></p>
                <button type="submit" class="xacnhan">Xác nhận</button>
            </form>

            <%-- Hiển thị lỗi từ backend nếu có --%>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
            <% } %>
        </div>
    </body>
</html>
