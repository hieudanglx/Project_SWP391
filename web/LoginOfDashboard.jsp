<%-- 
    Document   : LoginOfDashBoard
    Created on : Feb 24, 2025, 8:03:39 PM
    Author     : Dang Khac Hieu_CE180465
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            body, html {
                height: 100%;
                margin: 0;
            }
            .wrapper {
                display: flex;
                height: 100vh;
            }
            .left-section {
                flex: 0.35; /* Gi?m kích th??c ph?n màu xanh */
                background: linear-gradient(135deg, #7287FF, #A8C1FF);
                color: white;
                display: flex;
                align-items: center; /* C?n gi?a theo chi?u d?c */
                justify-content: center; /* C?n gi?a theo chi?u ngang */
                text-align: center;
                font-size: 40px; /* T?ng kích th??c ch? */
                font-weight: bold;
                padding: 20px;
            }
            .right-section {
                flex: 0.65; /* T?ng kích th??c ph?n login */
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 20px;
            }
            .login-box {
                width: 100%;
                max-width: 450px; /* T?ng kích th??c login box */
                text-align: center;
            }
            .login-box h3 {
                font-size: 32px; /* T?ng size ch? tiêu ?? */
            }
            .form-control {
                border-radius: 30px;
                padding: 15px 20px; /* T?ng kho?ng cách trong ô nh?p */
                font-size: 16px;
            }
            .btn-primary {
                border-radius: 30px;
                padding: 14px;
                font-size: 18px; /* Nút l?n h?n */
                width: 100%;
                background-color: #007bff;
                border: none;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-secondary {
                border-radius: 30px;
                padding: 12px;
                font-size: 16px;
                width: 100%;
                background-color: #6c757d;
                border: none;
                margin-top: 10px;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            @media (max-width: 768px) {
                .wrapper {
                    flex-direction: column;
                }
                .left-section {
                    height: 25vh;
                    flex: none;
                    font-size: 28px; /* Ch?nh nh? l?i trên mobile */
                    align-items: center;
                }
                .right-section {
                    height: 75vh;
                    flex: none;
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="left-section">
                WELCOME TO DASHBOARD
            </div>
            <div class="right-section">
                <div class="login-box">
                    <h3 class="fw-bold">Hello Again!</h3>
                    <p class="fs-5">Welcome Back</p>
                    <form action="LoginStaff_Admin" method="POST">
                        <div class="mb-3">
                            <input type="text" id="Username" name="Username" class="form-control form-control-lg"
                                   placeholder="Enter a valid username" required>
                        </div>
                        <div class="mb-3">
                            <input type="password" id="Password" name="Password" class="form-control"
                                   placeholder="Password" required>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="text-danger text-center fw-bold mt-2">${error}</div>
                        </c:if>
                        <button type="submit" class="btn btn-primary">Login</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'forgotPasswordStaff.jsp'" >Forgot Password</button>
                    </form>
                </div>
            </div>


        </div>
    </body>
</html>


