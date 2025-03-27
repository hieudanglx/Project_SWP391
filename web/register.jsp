<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Electronic Store - Register</title>
        <link href="css/register.css" rel="stylesheet" type="text/css" />
        <style>

            .text-primary {
                font-weight: bold;
                transition: color 0.3s ease-in-out;
            }

            .text-primary:hover {
                color: #007bff;
                text-decoration: underline;
            }


            /* Background gradient */
            body {
                background: linear-gradient(to right, #74ebd5, #acb6e5);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }

            /* Form container */
            .register-card {
                max-width: 900px;
                width: 100%;
                padding: 30px;
                background: white;
                border-radius: 12px;
                box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease-in-out;
            }

            .register-card:hover {
                transform: scale(1.02);
            }

            /* Title */
            .register-title {
                font-weight: bold;
                color: #333;
            }

            /* Input fields */
            .form-control {
                border-radius: 8px;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: #74ebd5;
                box-shadow: 0px 0px 8px rgba(116, 235, 213, 0.5);
            }

            /* Gender dropdown */
            .form-select {
                border-radius: 8px;
                transition: all 0.3s;
            }

            .form-select:focus {
                border-color: #acb6e5;
                box-shadow: 0px 0px 8px rgba(172, 182, 229, 0.5);
            }

            /* Error message */
            .error-message {
                color: red;
                font-size: 0.9rem;
            }

            /* Register button */
            .btn-primary {
                background: linear-gradient(to right, #74ebd5, #acb6e5);
                border: none;
                font-size: 1.1rem;
                font-weight: bold;
                padding: 12px;
                border-radius: 8px;
                transition: all 0.3s;
            }

            .btn-primary:hover {
                background: linear-gradient(to right, #6ad3c4, #98a8e5);
                transform: translateY(-2px);
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>
    <body>
        <div class="register-card">
            <h3 class="text-center register-title mb-4">Tạo một tài khoản</h3>
            <form action="RegisterController" method="post" onsubmit="return validateForm();">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="username" class="form-label">Tên người dùng</label>
                            <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên người dùng của bạn..." value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                            <div id="usernameError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="fullName" class="form-label">Họ và tên</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Nhập tên đầy đủ của bạn..." value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>">
                            <div id="fullNameError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="phoneNumber" class="form-label">Số điện thoại</label>
                            <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="Nhập số điện thoại của bạn..." value="<%= request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "" %>">
                            <div id="phoneError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="dob" class="form-label">Ngày sinh</label>
                            <input type="date" id="dob" name="dob" class="form-control" value="<%= request.getParameter("dob") != null ? request.getParameter("dob") : "" %>">
                            <div id="dobError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="text" id="email" name="email" class="form-control" placeholder="Nhập email của bạn..." value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                            <div id="emailError" class="error-message"></div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu...">
                            <div id="passwordError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu...">
                            <div id="confirmPasswordError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <input type="text" id="address" name="address" class="form-control" placeholder="Nhập địa chỉ của bạn..." value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                            <div id="addressError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="sex" class="form-label">Giới tính</label>
                            <select id="sex" name="sex" class="form-select" required>
                                <option value="" disabled>-- Chọn giới tính --</option>
                                <option value="Male" <%= "Male".equals(request.getParameter("sex")) ? "selected" : "" %>>Nam</option>
                                <option value="Female" <%= "Female".equals(request.getParameter("sex")) ? "selected" : "" %>>Nữ</option>
                                <option value="Other" <%= "Other".equals(request.getParameter("sex")) ? "selected" : "" %>>Khác</option>
                            </select>
                            <div id="sexError" class="error-message"></div>
                        </div>
                    </div>
                </div>

                <div class="mb-3 text-center">
                    <input type="submit" class="btn btn-primary w-100" value="Đăng ký">
                </div>

                <div class="mb-3 text-center">
                    <a href="loginOfCustomer.jsp" class="text-decoration-none text-primary">Đã có tài khoản? Đăng nhập tại đây!</a>
                </div>
            </form>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                // Kiểm tra nếu có thông báo từ server
                window.onload = function () {
                    let successMessage = "<%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>";
                    let errorMessage = "<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>";

                    if (successMessage) {
                        Swal.fire({
                            icon: "success",
                            title: "Success",
                            text: successMessage,
                            timer: 3000,
                            showConfirmButton: false
                        }).then(() => {
                            window.location.href = "choiceLogin.jsp"; // Chuyển hướng đến trang đăng nhập
                        });
                    }

                    if (errorMessage) {
                        Swal.fire({
                            icon: "error",
                            title: "Error",
                            text: errorMessage,
                        });
                    }
                };
        </script>


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
                    showError('usernameError', "Tên người dùng không được để trống!");
                    isValid = false;
                }

                if (!fullName) {
                    showError('fullNameError', "Tên đầy đủ không được để trống!");
                    isValid = false;
                }

                if (!dob) {
                    showError('dobError', "Ngày sinh không được để trống!");
                    isValid = false;
                }

                if (!sex) {
                    showError('sexError', "Vui lòng chọn giới tính!");
                    isValid = false;
                }

                if (!phoneNumber) {
                    showError('phoneError', "Số điện thoại không được để trống!");
                    isValid = false;
                } else if (!isValidPhone(phoneNumber)) {
                    showError('phoneError', "Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0.");
                    isValid = false;
                } else if (existingPhoneNumbers.includes(phoneNumber)) {
                    showError('phoneError', "Số điện thoại đã được đăng ký.");
                    isValid = false;
                }

                if (!email) {
                    showError('emailError', "Email không được để trống!");
                    isValid = false;
                } else if (!isValidEmail(email)) {
                    showError('emailError', "Định dạng email không hợp lệ (example@domain.com).");
                    isValid = false;
                } else if (existingEmails.includes(email)) {
                    showError('emailError', "Email đã được đăng ký.");
                    isValid = false;
                }

                if (!password) {
                    showError('passwordError', "Mật khẩu không được để trống!");
                    isValid = false;
                } else if (!isValidPassword(password)) {
                    showError('passwordError', "Mật khẩu phải dài từ 8-16 ký tự, có ít nhất một chữ cái viết hoa và một chữ số.");
                    isValid = false;
                }

                if (!confirmPassword) {
                    showError('confirmPasswordError', "Xác nhận mật khẩu không được để trống!");
                    isValid = false;
                } else if (password !== confirmPassword) {
                    showError('confirmPasswordError', "Mật khẩu không khớp!");
                    isValid = false;
                }

                if (!address) {
                    showError('addressError', "Địa chỉ không được để trống!");
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
