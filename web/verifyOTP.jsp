<%-- 
    Document   : verifyOTP
    Created on : Feb 25, 2025, 10:20:57 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Nhập OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2 class="mt-5">Nhập mã OTP</h2>
        <form action="verifyOTPController" method="post">
            <div class="mb-3">
                <label for="otp" class="form-label">Nhập mã OTP đã gửi đến email:</label>
                <input type="text" class="form-control" id="otp" name="otp" required>
            </div>
            <button type="submit" class="btn btn-primary">Xác nhận</button>
        </form>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p style="color: red;"><%= errorMessage %></p>
        <% } %>
    </div>
</body>
</html>
