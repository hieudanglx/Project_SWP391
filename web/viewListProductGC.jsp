<%-- 
    Document   : viewListProductGC
    Created on : Feb 24, 2025, 2:46:46 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Website bán hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">
        <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="libs/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/viewListProduct.css">
        <link rel="stylesheet" href="css/popup.css">
    </head>
    <body data-status="${sessionScope.status}" data-message="${sessionScope.message}">
        <c:remove var="status" scope="session"/>
        <c:remove var="message" scope="session"/>
        <div id="wallpaper">
            <%@include file="header.jsp" %>
            <div id="content">
                <div class="product-box">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 order-lg-0 order-1">
                                <c:if test="${empty search}">
                                    <jsp:include page="filter.jsp"></jsp:include>
                                </c:if>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-9 order-lg-1 order-0">
                                <div class="product-section">
                                    <h2 class="title-product">
                                        <c:if test="${ empty list}">
                                            <h1>
                                                Hiện cửa hàng chưa có sản phẩm phù hợp
                                            </h1>
                                        </c:if>
                                        <c:if test="${not empty list}">

                                            <a href="#" class="title">Sản phẩm nổi bật</a>
                                            <div class="bar-menu"><i class="fa fa-bars"></i></div>
                                            <div class="list-child">
                                                <ul>
                                                    <c:forEach items="${listbrand}" var="b">
                                                        <li><a href="FilterGCController?CategoryID=${CategoryID}&brand=${b}">${b}</a></li>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="clear"></div>

                                        </c:if>

                                    </h2>
                                    <div class="content-product-box">
                                        <div class="row">
                                            <c:forEach items="${list}" var="p" varStatus="status">
                                                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                    <div class="item-product">
                                                        <div class="thumb">
                                                            <a href="ViewProductDetailsController?name=${p.productName}&id=${p.productID}">
                                                                <img src="${p.imageURL}" alt="${p.productName}">
                                                            </a>
                                                            <div class="action">
                                                                <a href="UpdateCartController?id=${p.productID}&type=%2B" class="buy"><i class="fas fa-bolt "></i> Mua ngay</a>
                                                                <a href="UpdateCartController?id=${p.productID}&CategoryID=${p.categoryID}&type=%2B&page=list" class="like"><i class="fas fa-cart-plus me-2"></i> Thêm giỏ</a>
                                                                <div class="clear"></div>
                                                            </div>
                                                        </div>
                                                        <div class="info-product">
                                                            <h4>
                                                                <a href="ViewProductDetailsController?name=${p.productName}&id=${p.productID}">
                                                                    ${p.productName}
                                                                </a>
                                                            </h4>
                                                            <div class="price">
                                                                <span class="price-current">
                                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                                                </span>
                                                            </div>
                                                            <a href="ViewProductDetailsController?id=${p.productID}" class="view-more">Xem chi tiết</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Popup Thông Báo (Dùng cho các trang khác) -->
        <div class="alert-popup-overlay" id="alertPopup">
            <div class="alert-popup-content">
                <div class="alert-popup-icon" id="alertIcon" style="display: none"></div>
                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                <h5 class="alert-popup-message" id="alertMessage"></h5>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
    <script src="libs/jquery-3.4.1.min.js"></script>
    <script src="libs/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/bootstrap-hover-dropdown.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    <script src="js/popup.js"></script>

</html>
