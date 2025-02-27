<%-- 
    Document   : viewProfileStaff
    Created on : Feb 27, 2025, 9:12:06 PM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.AccountStaff" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            width: 50%;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        .profile-details {
            text-align: left;
            margin: 20px 0;
        }

        .profile-details .form-container {
            max-width: 100%;
        }

        .profile-details label {
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            text-decoration: none;
            color: #fff;
            background: #007bff;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545;
        }

    </style>
</head>
<body>
    <form action="viewProfileStaffController">
        <div class="container mt-5">
        <h2>Thông Tin Nhân Viên</h2>
        <table class="table table-bordered">
            <tr><th>StaffID</th><td><${sessionScope.staffID}</td></tr>
            <tr><th>Địa chỉ</th><td>${sessionScope.address}</td></tr>
            <tr><th>Email</th><td>${sessionScope.email}</td></tr>
            <tr><th>Mật khẩu</th><td>${sessionScope.password}</td></tr>
             <tr><th>Họ và tên</th><td>${sessionScope.fullname}</td></tr>
            <tr><th>Số Điện Thoại</th><td${sessionScope.phoneNumber}</td></tr>
            <tr><th>Tên Đăng Nhập</th><td>${sessionScope.username}</td></tr>
        </table>
        <a href="EditStaff.jsp" class="btn btn-warning">Chỉnh Sửa</a>
        
    </div>
    </form>
   
</body>
</html>
