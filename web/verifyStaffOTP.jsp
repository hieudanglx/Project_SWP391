<%-- 
    Document   : verifyStaffOTP
    Created on : Mar 4, 2025, 3:17:45 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Nhập OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            
            .xacnhan{
                background-color: #E5E1DA;
                border-radius: 10px;
                color: #547488;
                font-weight: 500;
                border: none;
            }
            .xacnhan:hover{
                background-color: #89A8B2;
                color: white;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <h2 class="mt-5">Nhập mã OTP</h2>
            <form action="verifyOTPStaffController" method="post">
                <div class="mb-3">
                    <label for="otp" class="form-label">Nhập mã OTP đã gửi đến email:</label>
                    <input type="text" class="form-control" id="otp" name="otp" required>
                </div>
                <button type="submit" class="xacnhan">Xác nhận</button>
            </form>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <p style="color: red;"><%= errorMessage %></p>
            <% } %>
        </div>
    </body>
</html>
