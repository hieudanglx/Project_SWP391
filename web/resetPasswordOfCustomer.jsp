<%-- 
    Document   : resetPasswordOfCustomer
    Created on : Feb 25, 2025, 9:53:34 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">
        <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.min.css" type="text/css" >
        <link rel="stylesheet" href="libs/font-awesome/css/font-awesome.min.css" type="text/css" >
        <link rel="stylesheet" href="css/header.css"  type="text/css" >
        <link rel="stylesheet" href="css/responsive.css"  type="text/css" >
        <link rel="stylesheet" href="css/resetPassword.css">
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
    <%@include file="header.jsp"%>
    <body>
        <div class="containerx">
            <h2>Reset Password</h2>
            <form action="resetPasswordOfCustomerController" method="post" onsubmit="return validatePassword();">
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
         <%@include file="footer.jsp" %>
    </body>
</html>
