<%-- 
    Document   : choiceLogin
    Created on : Feb 24, 2025, 8:02:38 PM
    Author     : Tran Phong Hai - CE180803
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">


    <head>
    <a href="choiceLogin.jsp"></a>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <!-- Đăng nhập Phụ huynh -->
            <div class="col-md-5 border p-4">
                <button class="btn btn-warning mb-3">DashBoard</button>
                <div class="text-center">
                    <button class="btn btn-primary" onclick="window.location.href = 'LoginOfDashboard.jsp'">Đăng nhập</button>
                </div>
            </div>

            <!-- Đăng nhập Sinh viên, Giảng viên, Cán bộ -->
            <div class="col-md-6 offset-md-1 border p-4">
                <button class="btn btn-warning mb-3">Customer</button>
                <div class="mb-3">
                    <input type="text" id="Username" name="Username" class="form-control form-control-lg"
                           placeholder="Enter a valid username" required>
                </div>
                <div class="mb-3">
                    <input type="password" id="Password" name="Password" class="form-control"
                           placeholder="Password" required>
                </div>
                <button class="btn btn-danger w-100 mb-2">G+ Login With Google</button>
                <button type="submit" class="btn btn-primary">Login</button>
                <button type="button" class="btn btn-secondary">Forgot Password</button>
            </div>
        </div>


    </div>
</body>
</html>
