<%-- 
    Document   : homeOfCustomer
    Created on : Feb 25, 2025, 7:59:52 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customer" %>
<%
    HttpSession userSession = request.getSession(false);
    Customer customer = (Customer) userSession.getAttribute("customer");

    if (customer == null) {
        response.sendRedirect("loginOfCustomer.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin-top: 50px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .logout-btn {
            margin-top: 20px;
        }
    </style>
    <script>
        function confirmLogout(event) {
            event.preventDefault(); // Ngăn chặn gửi form ngay lập tức
            let confirmAction = confirm("Do you want log out?");
            if (confirmAction) {
                document.getElementById("logoutOfCustomerController").submit(); // Gửi form nếu nhấn OK
            }
        }
    </script>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container">
        <h2>Welcome, <a href="ViewProfileOfCustomer.jsp" class="username-link"><%= customer.getUsername() %></a>!</h2>       

        <form id="logoutOfCustomerController" action="logoutOfCustomerController" method="post">
            <a href="forgotPasswordOfCustomer.jsp" class="btn btn-warning">Forgot Password</a>
            <button class="btn btn-danger logout-btn" onclick="confirmLogout(event)">Logout</button>
        </form>
    </div>
</body>
</html>
