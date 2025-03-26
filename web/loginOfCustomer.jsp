<%-- 
    Document   : loginOfCustomer
    Created on : Feb 24, 2025, 11:14:19 PM
    Author     : TRAN NHU Y - CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <<link rel="stylesheet" href="/css/loginCutomer.css"/>
    </head>
    <body>
        <%@include file="header.jsp"%>
        <div class="login">
            <div class="container">
                <div class="image-container">
                    <img src="https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?t=st=1740414577~exp=1740418177~hmac=031d7c5...a&w=1480" 
                         alt="Login Illustration">
                </div>
                <div class="form-container">
                    <h2>ĐĂNG NHẬP</h2>
                    <form action="loginOfCustomer" method="post">
                        <div class="input-group">                    
                            <input type="text" id="username" name="username" class="form-control form-control-lg"
                                   placeholder="Tên người dùng" required> 
                        </div>
                        <div class="input-group">                        
                            <input type="password" id="password" name="password" class="form-control"
                                   placeholder="Mật khẩu" required>
                        </div>
                        <div>
                            <button class="btn">Đăng nhập</button>
                        </div>
                        <div class="link-container">
                            <a href="forgotPasswordOfCustomer.jsp" class="forgotpassword">Quên mật khẩu</a>
                            | <a href="register.jsp" class="register">Đăng ký</a>
                        </div>

                        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                        <% if (errorMessage != null) { %>
                        <p style="color: red;"><%= errorMessage %></p>
                        <% } %>

                        <% 
                        String successMessage = (String) session.getAttribute("successMessage");
                        if (successMessage != null) {
                        %>
                        <script>
                            alert("<%= successMessage %>");
                        </script>
                        <% 
                            session.removeAttribute("successMessage"); // Xóa thông báo sau khi hiển thị
                            } 
                        %>
                    </form>
                </div>
            </div>  
                    
        </div>
                     <%@include file="footer.jsp" %>
    </body>
</html>
