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
<body>
    <h2>Reset Password</h2>
    
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
    <% } %>

    <form action="resetPasswordOfCustomerController" method="post">
        <label>Nhập mật khẩu mới:</label>
        <input type="password" name="newPassword" required><br>

        <label>Nhập lại mật khẩu:</label>
        <input type="password" name="confirmPassword" required><br>

        <button type="submit">Xác nhận</button>
    </form>
</body>
</html>