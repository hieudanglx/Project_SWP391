<%-- 
<%-- 
    Document   : verifyOTPChangeStaff
    Created on : Mar 3, 2025, 9:11:10 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Xác Nhận OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            /* Tổng thể */
            body {
                background: linear-gradient(to right, #4facfe, #00f2fe);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                font-family: 'Arial', sans-serif;
            }

            /* Hộp OTP */
            .otp-container {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
                text-align: center;
                max-width: 400px;
                width: 100%;
            }

            .otp-container h2 {
                font-weight: bold;
                margin-bottom: 20px;
                color: #333;
            }

            /* Input OTP */
            .otp-input {
                width: 100%;
                padding: 10px;
                font-size: 18px;
                text-align: center;
                border: 2px solid #ddd;
                border-radius: 8px;
                transition: 0.3s;
            }

            .otp-input:focus {
                border-color: #4facfe;
                outline: none;
            }

            /* Nút Xác nhận */
            .btn-confirm {
                width: 100%;
                padding: 12px;
                background: #4facfe;
                border: none;
                border-radius: 8px;
                font-size: 18px;
                color: white;
                cursor: pointer;
                margin-top: 15px;
                transition: 0.3s;
            }

            .btn-confirm:hover {
                background: #007bff;
            }

            /* Icon */
            .icon {
                font-size: 50px;
                color: #4facfe;
                margin-bottom: 15px;
            }

            /* Thông báo lỗi */
            .error-message {
                color: red;
                font-weight: bold;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>

        <!-- Content Spacer để tránh bị header che -->
        <div class="header-spacer"></div>

        <!-- Form nhập OTP -->
        <div class="otp-container">
            <i class="fas fa-lock icon"></i>
            <h2>Xác Nhận OTP</h2>
            <p>Nhập mã OTP đã gửi đến email của bạn</p>

            <!-- Form nhập OTP -->
            <form action="verifyOTPChangeStaffController" method="post">
                <input type="text" class="otp-input" id="otp" name="otp" placeholder="Nhập OTP" required>
                <button type="submit" class="btn-confirm">Xác Nhận</button>
            </form>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
            <% } %>
        </div>
        <footer class="mt-auto">

        </footer>
    </body>
</html>

