<%-- 
    Document   : header
    Created on : Feb 25, 2025, 12:48:14 AM
    Author     : CE180594_Phan Quốc Duy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <style>
            /* --- General Header Styles --- */
            .header {
                background: #ffffff;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }

            /* --- Top Row Styles --- */
            .top-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 30px;
                background: #89A8B2;
            }

            .logo {
                color: white;
                font-size: 24px;
                font-weight: bold;
                text-decoration: none;
            }

            .top-right {
                display: flex;
                gap: 25px;
                align-items: center;
            }

            .auth-section {
                display: flex;
                gap: 15px;
            }

            .login-btn {
                color: white;
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 20px;
                transition: background 0.3s;
            }

            .login-btn:hover {
                background: rgba(255,255,255,0.1);
            }

            .cart-icon {
                position: relative;
                color: white;
                text-decoration: none;
            }

            .cart-count {
                position: absolute;
                top: -8px;
                right: -12px;
                background: #ff4444;
                color: white;
                padding: 2px 8px;
                border-radius: 10px;
                font-size: 12px;
            }

            /* --- Bottom Row Styles --- */
            .bottom-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 30px;
                background: #f8f9fa;
            }

            .nav-categories {
                display: flex;
                gap: 35px;
            }

            .nav-link {
                color: #1a237e;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }

            .nav-link:hover {
                color: #4CAF50;
            }

            .search-container {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-input {
                padding: 8px 15px;
                border: 1px solid #ddd;
                border-radius: 20px;
                width: 300px;
                outline: none;
            }

            .search-btn {
                background: #4CAF50;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 20px;
                cursor: pointer;
            }

            /* Content Spacer */
            .header-spacer {
                height: 120px;

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <script>
            function confirmLogout(event) {
                event.preventDefault(); // Ngăn chặn hành động mặc định
                let confirmAction = confirm("Do you want to log out?");
                if (confirmAction) {
                    window.location.href = "logoutOfCustomerController";
                }
            }
        </script>

    </head>
    <body>
        <header class="header">
            <!-- Top Row -->
            <div class="top-row">
                <a href="ViewListProductGC?CategoryID=${1}" class="logo">ELECTRONIC STORE</a>

                <div class="top-right">
                    <div class="auth-section">
                        <c:choose>
                            <c:when test="${not empty sessionScope.customer}">
                                <p>${sessionScope.customer.username}</p>
                                <form>
                                    <button class="btn btn-danger logout-btn" onclick="confirmLogout(event)">Logout</button>
                                </form>
                                <!--<a href="logout" class="login-btn">Đăng xuất</a>-->

                            </c:when>
                            <c:otherwise>
                                <a href="choiceLogin.jsp" class="login-btn">Đăng nhập</a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <a href="ViewCartController" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                        <!-- Top Row 
                        <c:if test="">
                            <span class="cart-count">${cart.totalItems}</span>
                        </c:if>
                        -->
                    </a>
                </div>
            </div>

            <!-- Bottom Row -->
            <div class="bottom-row">
                <nav class="nav-categories">
                    <a href="ViewListProductGC?CategoryID=${1}" class="nav-link">Laptop</a>
                    <a href="ViewListProductGC?CategoryID=${2}" class="nav-link">Smartphone</a>
                    <a href="ViewListProductGC?CategoryID=${3}" class="nav-link">Tablet</a>
                </nav>

                <form action="SearchController" method="GET" class="search-container">
                    <input id="keyword"
                           type="text" 
                           name="keyword"
                           class="search-input" 
                           placeholder="Tìm kiếm sản phẩm..."
                           >
                </form>
            </div>
        </header>

        <!-- Content Spacer -->
        <div class="header-spacer"></div>
    </body>
</html>