<%-- 
    Document   : orderSuccess
    Created on : Mar 17, 2025, 2:35:57 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Đặt hàng thành công</title>
    </head>
    <body>
    <h2>Đặt hàng thành công!</h2>
    <p>Cảm ơn bạn đã mua hàng tại cửa hàng của chúng tôi.</p>
    <p>Mã đơn hàng của bạn là: <strong>${requestScope.orderID}</strong></p>
    <p>Chúng tôi sẽ liên hệ để xác nhận đơn hàng sớm nhất có thể.</p>
    <a href="index.jsp">Tiếp tục mua sắm</a>
</body>
</html>
