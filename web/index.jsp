<%-- 
    Document   : login
    Created on : Feb 22, 2025, 9:20:21 PM
    Author     : Dinh Van Do - CE182224
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <form action="CustomerController" method="POST">

                <!-- Username Input -->
                <div class="form-outline mb-4">
                    <input type="text" id="username" name="username" class="form-control form-control-lg"
                           placeholder="Enter a valid username" required />
                    <label class="form-label" for="username">Username</label>
                </div>

                <!-- Password Input -->
                <div class="form-outline mb-3">
                    <input type="password" id="password" name="password" class="form-control form-control-lg"
                           placeholder="Enter password" required />
                    <label class="form-label" for="password">Password</label>
                </div>
                <!-- Remember Me and Forgot Password -->
                <div class="d-flex justify-content-between align-items-center">
                    <div class="form-check mb-0">
                        <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
                        <label class="form-check-label" for="form2Example3">Remember me</label>
                    </div>
                    <a href="forgotPassword.jsp" class="text-body">Forgot password?</a>
                </div>
                <!-- Submit Button -->
                <div class="text-center text-lg-start mt-4 pt-2">
                    <button type="submit" class="btn btn-primary btn-lg"
                            style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
                    <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? 
                        <a href="register.jsp" class="link-danger">Register</a>
                    </p>
                </div>
            </form>
    </body>
</html>