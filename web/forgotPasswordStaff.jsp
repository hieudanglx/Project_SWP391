<%-- 
    Document   : forgotPassword_Staff
    Created on : Feb 25, 2025
    Author     : nguye - CE170583
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quên mật khẩu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            
            .main-content {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            
            .forgot-password-container {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 450px;
                text-align: center;
                margin: 20px 0;
            }
            
            .forgot-password-container h2 {
                color: #547488;
                margin-bottom: 20px;
            }
            
            .form-control {
                margin-bottom: 15px;
                border-radius: 5px;
                padding: 10px;
            }
            
            .submit-btn {
                background-color: #547488;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-weight: 500;
                width: 100%;
                transition: background-color 0.3s;
            }
            
            .submit-btn:hover {
                background-color: #3a5a6e;
            }
            
            .error-message {
                color: #dc3545;
                margin-top: 15px;
            }
            
            .info-text {
                color: #6c757d;
                margin-bottom: 25px;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <div class="main-content">
            <div class="forgot-password-container">
                <h2>Quên mật khẩu</h2>
                <p class="info-text">Vui lòng nhập email đã đăng ký để đặt lại mật khẩu</p>

                <form action="ForgotPasswordOfStaff" method="post">
                    <div class="form-group">
                        <input type="email" name="email" class="form-control" placeholder="Nhập địa chỉ email" required>
                    </div>
                    <button type="submit" class="submit-btn">Gửi yêu cầu</button>
                </form>

                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) { %>
                <p class="error-message mt-3"><%= errorMessage %></p>
                <% } %>
                
                <div class="mt-3">
                    <a href="login.jsp" class="text-decoration-none">Quay lại trang đăng nhập</a>
                </div>
            </div>
        </div>
        
        <%@include file="footer.jsp" %>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>