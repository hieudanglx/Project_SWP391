<%-- 
    Document   : resetPasswordOfCustomer
    Created on : Feb 25, 2025, 9:53:34 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
    </head>
    <style>
        .container {
            max-width: 907px;
            margin-top: 62px;
            margin-left: 250px;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .xacnhan{
            background-color: #E5E1DA;
            border-radius: 10px;
            color: #547488;
            font-weight: 500;
            border: none;
            font-size: 16px;
            margin-left: 110px;
            border-radius: 5px;  
        }
        .xacnhan:hover{
            background-color: #89A8B2;
            color: white;
        }
        .inputpassword{
            margin: 13px;
            border-radius: 5px;
            border-color: #dee2e6;
            border-width: 1px;
            font-size: 19px;
            padding: 4px;
        }
    </style>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <h2 class="mt-5">Reset Password</h2>
            <form action="resetPasswordOfCustomerController" method="post">
                <div lass="mb-3">
                    <label>Nhập mật khẩu mới:</label>
                    <input class="inputpassword" type="password" name="newPassword" required><br>
                    <label>Nhập lại mật khẩu:</label>
                    <input class="inputpassword" type="password" name="confirmPassword" required><br>
                </div>
                <button type="submit" class="xacnhan">Xác nhận</button>

            </form>
        </div>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
        <% } %>
    </form>
</body>
</html>