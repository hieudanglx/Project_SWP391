<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <title>Electronic Store - Register</title>
        <link href="css/register.css" rel="stylesheet" type="text/css"/>
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
                <form action="http://localhost:8080/Project_SWP/RegisterController" method="post" onsubmit="return validateForm();">
                    <div class="input-field">
                        <input type="text" id="username" name="username" class="input" placeholder="Enter your username...">
                        <i class="bx bx-user" style="color: #000"></i>
                        <div id="usernameError" class="error-message"></div>
                    </div>
                    <div class="input-field">
                        <input type="text" id="phoneNumber" name="phoneNumber" class="input" placeholder="Enter your phone...">
                        <i class='bx bx-phone' style="color: #000"></i>
                        <div id="phoneError" class="error-message"></div>
                    </div>
                    <div class="input-field">
                        <input type="text" id="email" name="email" class="input" placeholder="Enter your email...">
                        <i class='bx bx-envelope' style="color: #000"></i>
                        <div id="emailError" class="error-message"></div>
                    </div>
                    <div class="input-field">
                        <input type="password" id="password" name="password" class="input" placeholder="Enter password...">
                        <i class="bx bx-lock-alt" style="color: #000"></i>
                        <div id="passwordError" class="error-message"></div>
                    </div>
                    <div class="input-field">
                        <input type="password" id="confirmPassword" name="confirmPassword" class="input" placeholder="Confirm password...">
                        <i class="bx bx-lock-alt" style="color: #000"></i>
                        <div id="confirmPasswordError" class="error-message"></div>
                    </div>
                    <div class="input-field">
                        <input type="text" id="address" name="address" class="input" placeholder="Enter your address...">
                        <i class='bx bx-home' style="color: #000"></i>
                        <div id="addressError" class="error-message"></div>
                    </div>
                    <div class="input-field">
                        <input type="submit" class="submit" value="Register">
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

                clearErrors();

                if (!username) {
                    showError('usernameError', "Username cannot be empty!");
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

                return isValid;
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
