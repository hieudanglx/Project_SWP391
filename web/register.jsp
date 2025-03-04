<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Electronic Store - Register</title>
        <link href="css/register.css" rel="stylesheet" type="text/css" />
        <style>
            .input::placeholder {
                color: black;
            }

            .error-message {
                color: red;
                font-size: 12px;
                margin-top: 5px;
            }

            body {
                background: url('/img/OIP.jpg') no-repeat center center fixed;
                background-size: cover;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
        </style>
    </head>

    <body>
        <div class="box">
            <div class="container">
                <div class="top-header">
                    <header>Register</header>
                </div>
                <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success text-center">
                    <%= request.getAttribute("successMessage") %>
                </div>
                <% } %>
                <form action="RegisterController" method="post" onsubmit="return validateForm();">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username...">
                        <div id="usernameError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter your full name...">
                        <div id="fullNameError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="Enter your phone...">
                        <div id="phoneError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" id="dob" name="dob" class="form-control">
                        <div id="dobError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="text" id="email" name="email" class="form-control" placeholder="Enter your email...">
                        <div id="emailError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter password...">
                        <div id="passwordError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm password...">
                        <div id="confirmPasswordError" class="error-message"></div>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" id="address" name="address" class="form-control" placeholder="Enter your address...">
                        <div id="addressError" class="error-message"></div>
                    </div>

                    <!-- Dropdown chọn giới tính -->
                    <div class="mb-3">
                        <label for="sex" class="form-label">Gender</label>
                        <select id="sex" name="sex" class="form-select" required>
                            <option value="" disabled selected>-- Select Gender --</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                        <div id="sexError" class="error-message"></div> <!-- Thêm dòng này -->
                    </div>

                    <div class="mb-3 text-center">
                        <input type="submit" class="btn btn-primary w-100" value="Register">
                    </div>
                </form>
            </div>
        </div>

        <script>
            const existingPhoneNumbers = ["0123456789", "0987654321"]; // Danh sách s? ?i?n tho?i ?ã t?n t?i
            const existingEmails = ["test@example.com", "user@domain.com"]; // Danh sách email ?ã t?n t?i

            function validateForm() {
                let isValid = true;

                const username = document.getElementById('username').value.trim();
                const phoneNumber = document.getElementById('phoneNumber').value.trim();
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value.trim();
                const confirmPassword = document.getElementById('confirmPassword').value.trim();
                const address = document.getElementById('address').value.trim();
                const fullName = document.getElementById('fullName').value.trim();
                const sex = document.getElementById('sex').value.trim();
                const dob = document.getElementById('dob').value.trim();

                clearErrors();

                if (!username) {
                    showError('usernameError', "Username cannot be empty!");
                    isValid = false;
                }

                if (!fullName) {
                    showError('fullNameError', "Full Name cannot be empty!");
                    isValid = false;
                }

                if (!dob) {
                    showError('dobError', "Date of Birth cannot be empty!");
                    isValid = false;
                }

                if (!sex) {
                    showError('sexError', "Please select a gender!");
                    isValid = false;
                }

                if (!phoneNumber) {
                    showError('phoneError', "Phone number cannot be empty!");
                    isValid = false;
                } else if (!isValidPhone(phoneNumber)) {
                    showError('phoneError', "Phone number must have 10 digits and start with 0.");
                    isValid = false;
                } else if (existingPhoneNumbers.includes(phoneNumber)) {
                    showError('phoneError', "Phone number is already registered.");
                    isValid = false;
                }

                if (!email) {
                    showError('emailError', "Email cannot be empty!");
                    isValid = false;
                } else if (!isValidEmail(email)) {
                    showError('emailError', "Invalid email format (example@domain.com).");
                    isValid = false;
                } else if (existingEmails.includes(email)) {
                    showError('emailError', "Email is already registered.");
                    isValid = false;
                }

                if (!password) {
                    showError('passwordError', "Password cannot be empty!");
                    isValid = false;
                } else if (!isValidPassword(password)) {
                    showError('passwordError', "Password must be 8-16 characters long, with at least one uppercase letter and one number.");
                    isValid = false;
                }

                if (!confirmPassword) {
                    showError('confirmPasswordError', "Confirm Password cannot be empty!");
                    isValid = false;
                } else if (password !== confirmPassword) {
                    showError('confirmPasswordError', "Passwords do not match!");
                    isValid = false;
                }

                if (!address) {
                    showError('addressError', "Address cannot be empty!");
                    isValid = false;
                }

                return isValid; // Chặn submit nếu có lỗi
            }

            function isValidPhone(phoneNumber) {
                return /^[0-9]{10}$/.test(phoneNumber) && phoneNumber.startsWith('0');
            }

            function isValidEmail(email) {
                return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email);
            }

            function isValidPassword(password) {
                return password.length >= 8 && password.length <= 16 && /[A-Z]/.test(password) && /[0-9]/.test(password);
            }

            function showError(elementId, message) {
                document.getElementById(elementId).textContent = message;
            }

            function clearErrors() {
                document.querySelectorAll('.error-message').forEach(error => error.textContent = "");
            }
        </script>
    </body>

</html>
