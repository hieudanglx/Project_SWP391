<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Nhập OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .xacnhan {
            background-color: #E5E1DA;
            border-radius: 10px;
            color: #547488;
            font-weight: 500;
            border: none;
            padding: 10px 20px;
        }
        .xacnhan:hover {
            background-color: #89A8B2;
            color: white;
        }
        .resend-btn {
            background-color: #FF9800;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            display: none; /* Ẩn ban đầu */
        }
        .resend-btn:hover {
            background-color: #F57C00;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container">
        <h2 class="mt-5">Nhập mã OTP</h2>
        <form action="verifyOTPController" method="post">
            <div class="mb-3">
                <label for="otp" class="form-label">Nhập mã OTP đã gửi đến email:</label>
                <input type="text" class="form-control" id="otp" name="otp" required>
            </div>
            <p id="countdown" style="font-weight: bold; color: blue;"></p> <!-- Hiển thị thời gian còn lại -->
            <button type="submit" class="xacnhan" id="submitBtn">Xác nhận</button>
        </form>

        <!-- Nút gửi lại OTP -->
        <form action="ReOTPController" method="post">
            <button type="submit" class="resend-btn mt-3" id="resendBtn">Gửi lại OTP</button>
        </form>

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
        <% } %>
    </div>

    <script>
        let timeLeft = 30; // 30 giây

        function updateCountdown() {
            let countdownElement = document.getElementById("countdown");
            let submitBtn = document.getElementById("submitBtn");
            let resendBtn = document.getElementById("resendBtn");

            if (timeLeft > 0) {
                countdownElement.innerHTML = "Mã OTP hết hạn sau: " + timeLeft + " giây";
                timeLeft--;
                setTimeout(updateCountdown, 1000);
            } else {
                countdownElement.innerHTML = "OTP đã hết hạn. Vui lòng yêu cầu lại.";
                submitBtn.disabled = true; // Vô hiệu hóa nút submit
                resendBtn.style.display = "block"; // Hiển thị nút gửi lại
            }
        }

        window.onload = updateCountdown; // Bắt đầu đếm ngược khi trang tải
    </script>

    <%@include file="footer.jsp" %>
</body>
</html>
