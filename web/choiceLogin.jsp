<%-- 
    Document   : choiceLogin
    Created on : Feb 24, 2025, 8:02:38 PM
    Author     : Tran Phong Hai - CE180803
--%>

<!DOCTYPE html>
<html lang="vi">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>

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
                    <button class="btn btn-warning mb-3">Sinh viên, Giảng viên, Cán bộ ĐH-FPT</button>
                    <select class="form-select mb-2">
                        <option>Select Campus</option>
                        <option>Hà Nội</option>
                        <option>Đà Nẵng</option>
                        <option>TP.HCM</option>
                    </select>
                    <button class="btn btn-danger w-100 mb-2">G+ Login With Google</button>
                    <p class="text-center small">Với sinh viên từ K19 đăng nhập với FEID</p>
                    <button class="btn btn-primary w-100">Login With FeID</button>
                </div>
            </div>

            <!-- Footer -->
            <div class="text-center mt-4">
                <p>&copy; Powered by <a href="#">FPT University</a> | <a href="#">CMS</a> | <a href="#">Library</a> | <a href="#">Books24x7</a></p>
            </div>
        </div>
    </body>
</html>
