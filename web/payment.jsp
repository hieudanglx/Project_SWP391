<%-- 
    Document   : payment
    Created on : Mar 3, 2025, 2:39:23 PM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Cổng thanh toán VNPAY DEMO</title>        
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f5f5f5;
                font-family: Arial, sans-serif;
                margin: 0;
            }

            .container2 {
                background: white;
                padding: 30px;
                border-radius: 20px;
                box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 400px;
                margin-top: 145px;
            }

            h3 {
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .btn {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: none;
                border-radius: 20px;
                font-size: 16px;
                cursor: pointer;
                background: white;
                box-shadow: 3px 3px 6px rgba(0, 0, 0, 0.1), -3px -3px 6px rgba(255, 255, 255, 1);
                transition: 0.3s;
            }

            .btn:hover {
                background: #eee;
            }

            .copyright {
                margin-top: 15px;
                font-size: 14px;
                color: gray;
                font-weight: bold;
            }
        </style>
    </head>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container2">
        <div>
            <h3>VNPAY DEMO</h3>
        </div>
        <div class="form-group">
            <button onclick="pay()">Giao dịch thanh toán</button><br>
        </div>
        <p>
            &nbsp;
        </p>
        <div class="form-group">
            <button onclick="querydr()">API truy vấn kết quả thanh toán</button><br>
        </div>
        <p>
            &nbsp;
        </p>
        <div class="form-group">
            <button onclick="refund()">API hoàn tiền giao dịch</button><br>
        </div>
        <p>
            &nbsp;
        </p>
        <footer class="footer">
            <p>&copy; VNPAY 2020</p>
        </footer>
    </div> 
    <script>
        function pay() {
            window.location.href = "vnpay_pay.jsp";
        }
        function querydr() {
            window.location.href = "vnpay_querydr.jsp";
        }
        function refund() {
            window.location.href = "vnpay_refund.jsp";
        }
    </script>
</body>
</html>
