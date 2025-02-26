<%-- 
    Document   : logout
    Created on : Feb 26, 2025, 3:09:28 PM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate(); // Hủy session
    }
    response.sendRedirect("loginOfCustomer.jsp"); // Chuyển hướng về trang đăng nhập
%>
<!--<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>-->
