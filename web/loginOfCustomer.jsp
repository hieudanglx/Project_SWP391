<%-- 
    Document   : loginOfCustomer
    Created on : Feb 24, 2025, 11:14:19 PM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
            }

            .container {
                display: flex;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 800px;
                height: 400px;
                justify-content: space-between;
            }

            .image-container {
                width: 50%;
            }

            .image-container img {
                width: 100%;
            }

            .form-container {
                width: 45%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            .form-container h2 {
                margin-bottom: 20px;
            }

            .input-group {
                width: 100%;
                position: relative;
                margin-bottom: 20px;
            }

            .input-group input {
                width: 100%;
                padding: 10px 40px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .input-group img {
                position: absolute;
                left: 10px;
                top: 50%;
                transform: translateY(-50%);
                width: 20px;
            }

            .btn {
                width: 100%;
                padding: 12px;
                background-color: #b88e2f;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }

            .btn:hover {
                background-color: #a07420;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="image-container">
                <img src="https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?t=st=1740414577~exp=1740418177~hmac=031d7c58c23feba91aa62989c5ad68c169821d887bd88e66e6dcad3be1acbf4a&w=1480" 
                     alt="Login Illustration">
            </div>
            <div class="form-container">
                <h2>LOGIN</h2>
                <form action="loginOfCustomer" method="post">
                    <div class="input-group">                    
                       <input type="email" name="email" placeholder="Your email" required>

                    </div>
                    <button class="btn">NEXT</button>
                </form>
                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) { %>
                <p style="color: red;"><%= errorMessage %></p>
                <% } %>
            </div>
        </div>  
    </body>
</html>
