<%-- 
    Document   : logout
    Created on : Feb 26, 2025, 4:36:49 PM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate(); // Hủy session
    }
    response.sendRedirect("logoutOfCustomerController"); // Chuyển hướng về trang đăng nhập
%>
