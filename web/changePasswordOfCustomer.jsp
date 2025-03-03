<%-- 
    Document   : changePasswordOfCustomer
    Created on : Feb 27, 2025, 1:19:34 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function sendOTP() {
                let email = document.getElementById('email').value;
                if (email === '') {
                    Swal.fire('Error', 'Please enter your email!', 'error');
                    return;
                }
                fetch('SendOTPController', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'email=' + encodeURIComponent(email)
                }).then(response => response.text()).then(data => {
                    Swal.fire('Success', 'OTP has been sent to your email!', 'success');
                }).catch(error => {
                    Swal.fire('Error', 'Failed to send OTP!', 'error');
                });
            }
        </script>
    </head>
    <body>
        <h2>Change Password</h2>
        <form action="ChangePasswordOfCustomerController" method="post">
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <br>
            <label>Old Password:</label>
            <input type="password" name="oldPassword" required>
            <br>
            <label>New Password:</label>
            <input type="password" name="newPassword" required>
            <br>
            <button type="button" onclick="sendOTP()">Send OTP</button>
            <br>
            <label>Enter OTP:</label>
            <input type="text" name="otp" required>
            <br>
            <button type="submit">Confirm Change</button>
        </form>
    </body>
</html>
