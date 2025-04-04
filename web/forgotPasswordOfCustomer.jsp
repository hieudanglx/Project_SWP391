<%-- 
    Document   : forgotPasswordOfCustomer
    Created on : Feb 25, 2025, 9:32:37 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Forgot Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .forgot{
                body {
                    background-color: #f4f4f4;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .container {
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                    width: 400px;
                    text-align: center;
                }
                .submit{
                    background-color: #E5E1DA;
                    border-radius: 10px;
                    color: #547488;
                    font-weight: 500;
                    border: none;
                }
                .submit:hover{
                    background-color: #89A8B2;
                    color: white;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="forgot">
            <div class="container">
                <h2>Quên mật khẩu</h2>
                <p>Nhập email của bạn để đặt lại mật khẩu.</p>

                <form action="forgotPasswordOfCustomerController" method="post">
                    <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                    <button type="submit" class="submit mt-3">Xác nhận</button>
                </form>

                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) { %>
                <p style="color: red;"><%= errorMessage %></p>
                <% } %>
            </div>
        </div>
             <%@include file="footer.jsp" %>
    </body>
</html>