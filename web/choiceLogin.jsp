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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            font-size: 14px;
            font-family: 'Roboto', sans-serif;
            padding-top: 100px;
        }
        
        .content-wrapper {
            flex: 1;
            padding-bottom: 60px; /* Khoảng cách với footer */
        }
        
        footer {
            background-color: #f8f9fa;
            padding: 20px 0;
            margin-top: auto;
        }
    </style>
</head>

<body>
    <%@include file="header.jsp" %>
    
    <div class="content-wrapper">
        <div class="container">
            <div class="row justify-content-center">
                <!-- Đăng nhập staff_Admin -->
                <div class="col-md-5 border p-4 m-2">
                    <button class="btn btn-warning mb-3">DashBoard</button>
                    <div class="text-center">
                        <button class="btn btn-primary" onclick="window.location.href = 'LoginOfDashboard.jsp'">Đăng nhập</button>
                    </div>
                </div>

                <!-- Đăng nhập customer -->
                <div class="col-md-5 border p-4 m-2">
                    <button class="btn btn-warning mb-3">Đăng nhập Khách hàng</button>
                    <div class="text-center">
                        <button class="btn btn-primary" onclick="window.location.href = 'loginOfCustomer.jsp'">Đăng nhập</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="mt-auto">
        <%@include file="footer.jsp" %>
    </footer>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
