<%-- 
    Document   : header
    Created on : Feb 25, 2025, 12:48:14 AM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Website bán hàng</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">
        <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.min.css" type="text/css" >
        <link rel="stylesheet" href="libs/font-awesome/css/font-awesome.min.css" type="text/css" >
        <link rel="stylesheet" href="css/header.css"  type="text/css" >
        <link rel="stylesheet" href="css/responsive.css"  type="text/css" >
    </head>
    <body>
        <header class="header">
            <div class="top">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <p>Chào mừng đến với shop bán hàng!</p>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <div class="top-menu">
                                <ul>
                                    <li>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.customer}">
                                                Chào, <a href="ViewProfileOfCustomer.jsp" class="username-link">${sessionScope.customer.username}</a>!
                                                <button class="btn btn-danger logout-btn" onclick="confirmLogout(event)">Logout</button>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="choiceLogin.jsp" class="login-btn">Đăng nhập</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main-header">
                <div class="container">
                    <div class="row">
                        <div class="col-6 col-xs-6 col-sm-6 col-md-3 col-lg-3 order-md-0 order-0">
                            <div class="logo">
                                <a href="homeController?CatogoryID=2"><img src="images/logo.png" alt=""></a>
                                <h1>Website bán hàng</h1>
                            </div>
                        </div>
                        <div class="col-12 col-xs-12 col-sm-12 col-md-6 col-lg-6 order-md-1 order-2">
                            <div class="form-seach-product">
                                <form action="SearchController" method="post" role="form">
                                    <select name="CategoryID" class="form-control" required="required">
                                        <option value="">Chọn danh mục</option>
                                        <option value="2">Điện thoại</option>
                                        <option value="3">Máy tính bản</option>
                                        <option value="1">Lap top</option>
                                    </select>
                                    <div class="input-seach">
                                        <input type="text" name="keyword" id="" class="form-control">
                                        <button type="submit" class="btn-search-pro"><i class="fa fa-search"></i></button>
                                    </div>
                                    <div class="clear"></div>
                                </form>
                            </div>
                        </div>
                        <div class="col-6 col-xs-6 col-sm-6 col-md-3 col-lg-3 order-md-2 order-1" style="text-align: right">
                            <a href="ViewCartController" class="icon-cart">
                                <div class="icon">
                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                    <c:if test="${not empty sessionScope.customer}">
                                        <span class="cart-count">${sessionScope.size}</span>
                                    </c:if>
                                </div>
                                <span class="clear"></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main-menu-header">
                <div class="container">
                    <div id="nav-menu">
                        <ul>
                            <li class="current-menu-item"><a href="homeController?CatogoryID=2">Trang chủ</a></li>
                            <li>
                                <a href="ViewListProductGC?CategoryID=${1}">Sản phẩm</a>
                                <ul>
                                    <li><a href="ViewListProductGC?CategoryID=${2}">Điện thoại</a></li>
                                    <li><a href="ViewListProductGC?CategoryID=${3}">Máy tính bảng</a></li>
                                    <li><a href="ViewListProductGC?CategoryID=${1}">Laptop</a></li>
                                </ul>
                            </li>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </header>
        <script>

            function confirmLogout(event) {
                event.preventDefault(); // Ngăn chặn hành động mặc định
                let confirmAction = confirm("Do you want to log out?");
                if (confirmAction) {
                    window.location.href = "logoutOfCustomerController";
                }
            }
        </script>
        <script src="libs/jquery-3.4.1.min.js"></script>
        <script src="libs/bootstrap/js/bootstrap.min.js"></script>

    </body>
</html>
