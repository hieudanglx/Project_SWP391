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
    <%@include file="header.jsp" %>
    <div class="container mt-5">
        <div class="row">
            <!-- Đăng nhập staff_Admin -->
            <div class="col-md-5 border p-4">
                <button class="btn btn-warning mb-3">DashBoard</button>
                <div class="text-center">
                    <button class="btn btn-primary" onclick="window.location.href = 'LoginOfDashboard.jsp'">Đăng nhập</button>
                </div>
            </div>

            <!-- Đăng nhập customer -->
            <div class="col-md-6 offset-md-1 border p-4">
               <button class="btn btn-warning mb-3">Login Customer</button>
                <div class="text-center">
                    <button class="btn btn-primary" onclick="window.location.href = 'loginOfCustomer.jsp'">Đăng nhập</button>
                </div>
            </div>
        </div>


    </div>
</body>
</html>
