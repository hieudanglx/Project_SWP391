<%-- 
    Document   : changePasswordOfStaff
    Created on : Feb 27, 2025, 1:19:51 PM
    Author     : nguye
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.AccountCustomer" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>


<%
    AccountCustomer customer = (AccountCustomer) session.getAttribute("loggedCustomer");
    if (customer == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
    String success = (String) session.getAttribute("success");
    session.removeAttribute("success");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đổi Mật Khẩu</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 350px;
                text-align: center;
            }
            h2 {
                margin-bottom: 15px;
                color: #333;
            }
            .form-group {
                text-align: left;
                margin-bottom: 10px;
            }
            label {
                font-weight: bold;
                font-size: 14px;
                display: block;
                margin-bottom: 5px;
            }
            input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                outline: none;
            }
            input:focus {
                border-color: #007bff;
            }
            button {
                width: 100%;
                padding: 12px;
                background: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
            }
            button:hover {
                background: #0056b3;
            }
            .alert {
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 15px;
                font-size: 14px;
                display: none;
            }
            .alert-error {
                background: #ffdddd;
                color: #d8000c;
                border: 1px solid #d8000c;
            }
            .alert-success {
                background: #ddffdd;
                color: #4CAF50;
                border: 1px solid #4CAF50;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Đổi Mật Khẩu</h2>

            <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi!',
                    text: '<%= error %>'
                });
            </script>
            <% } %>

            <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
            <script>
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: '<%= success %>',
                    didClose: () => {
                        window.location.href = "profile.jsp";
                    }
                });
            </script>
            <% } %>

            <form action="changePasswordCustomer" method="POST">
                <div class="form-group">
                    <label for="oldPassword">Mật khẩu cũ:</label>
                    <input type="password" name="oldPassword" required>
                </div>

                <div class="form-group">
                    <label for="newPassword">Mật khẩu mới:</label>
                    <input type="password" name="newPassword" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                    <input type="password" name="confirmPassword" required>
                </div>

                <button type="submit">Đổi Mật Khẩu</button>
            </form>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let alertBoxes = document.querySelectorAll(".alert");
                alertBoxes.forEach(alert => {
                    if (alert.textContent.trim() !== "") {
                        alert.style.display = "block";
                    }
                });
            });
        </script>

    </body>
</html>


