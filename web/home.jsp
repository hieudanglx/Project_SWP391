<%-- 
    Document   : home
    Created on : Mar 6, 2025, 4:07:34 PM
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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="libs/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="css/popup.css">
    </head>
    <body>
        <div id="wallpaper">
            <%@include file="header.jsp" %>
            <div id="content">
                <div class="container">
                    <div class="slider">
                        <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block w-100" src="images/baner-011.png" alt="First slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src="images/baner-022.png" alt="Second slide">
                                </div>
                            </div>
                            <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="product-box">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 order-lg-0 order-1">
                                <div class="sidebar">
                                    <div class="category-box">
                                        <h3>Danh mục sản phẩm</h3>
                                        <div class="content-cat">
                                            <ul>
                                                <li><i class="fa fa-angle-right"></i> <a href="ViewListProductGC?CategoryID=2">Điện thoại</a></li>
                                                <li><i class="fa fa-angle-right"></i> <a href="ViewListProductGC?CategoryID=3">Máy tính bảng</a></li>
                                                <li><i class="fa fa-angle-right"></i> <a href="ViewListProductGC?CategoryID=1">laptop</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="widget">
                                        <h3>
                                            <i class="fa fa-bars"></i>
                                            Quảng cáo
                                        </h3>
                                        <div class="content-banner">
                                            <a href="#">
                                                <img src="images/banner.png" alt="">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="widget">
                                        <h3>
                                            <i class="fa fa-facebook"></i>
                                            Facebook
                                        </h3>
                                        <div class="content-fb">
                                            <div class="fb-page" data-href="https://www.facebook.com/" data-tabs="timeline" data-width="" data-height="200" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-9 order-lg-1 order-0">



                                <div class="product-section">
                                    <h2 class="title-product">
                                        <a href="#" class="title">Sản phẩm nổi bật</a>
                                        <div class="bar-menu"><i class="fa fa-bars"></i></div>
                                        <div class="list-child">
                                            <ul>
                                                <li><a href="homeController?CatogoryID=2">Điện thoại</a></li>
                                                <li><a href="homeController?CatogoryID=3">Máy tính bảng</a></li>
                                                <li><a href="homeController?CatogoryID=1">Laptop</a></li>
                                            </ul>
                                        </div>
                                        <div class="clear"></div>
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
                                                        </div>
                                                        <div class="info-product">
                                                            <h4>
                                                                <a href="ViewProductDetailsController?name=${p.productName}&id=${p.productID}">
                                                                    ${p.productName} ${p.ram} ${p.rom} 
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
            <!-- Popup container -->
            <div class="popup-overlay" id="popupOverlay">
                <div class="popup-content">
                    <span class="close-btn" onclick="closePopup()">&times;</span>
                    <div id="popupIcon" class="popup-icon"></div>
                    <h3 id="popupMessage"></h3>
                    <div class="popup-buttons" id="popupButtons"></div>
                </div>
            </div>
            <%@include file="footer.jsp" %>
        </div>
    </body>
    <script src="libs/jquery-3.4.1.min.js"></script>
    <script src="libs/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/popup.js"></script>

</html>
