<%-- 
    Document   : viewListProductGC
    Created on : Feb 24, 2025, 2:46:46 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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


        <c:set var="pageSize" value="8"/>
        <c:set var="totalProducts" value="${list.size()}"/>

        <!-- Tính tổng số trang và làm tròn lên -->
        <c:choose>
            <c:when test="${totalProducts == 0}">
                <c:set var="totalPages" value="1"/>
            </c:when>
            <c:otherwise>
                <c:set var="totalPages" value="${Math.ceil(totalProducts / pageSize)}"/>
            </c:otherwise>
        </c:choose>

        <!-- Validate và xử lý currentPage -->
        <c:choose>
            <c:when test="${empty param.page or param.page < 1}">
                <c:set var="currentPage" value="1"/>
            </c:when>
            <c:when test="${param.page > totalPages}">
                <c:set var="currentPage" value="${totalPages}"/>
            </c:when>
            <c:otherwise>
                <c:set var="currentPage" value="${param.page}"/>
            </c:otherwise>
        </c:choose>

        <!-- Tính chỉ số hiển thị -->
        <c:set var="startIndex" value="${(currentPage - 1) * pageSize}"/>
        <c:set var="endIndex" value="${startIndex + pageSize - 1}"/>
        <c:if test="${endIndex >= totalProducts}">
            <c:set var="endIndex" value="${totalProducts}"/>
        </c:if>

        <div id="wallpaper">
            <%@include file="header.jsp"%>
            <div id="content">
                <div class="product-box">
                    <div class="container">

                        <div style="margin: 20px 0 ">
                            <a href="homeController?CatogoryID=2">Trang chủ </a>
                            <span>> ${list.size()} sản phẩm</span>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 order-lg-0 order-1">
                                <c:if test="${empty search}">
                                    <jsp:include page="filter.jsp"></jsp:include>
                                </c:if>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-9 order-lg-1 order-0">
                                <div class="product-section">
                                    <c:if test="${empty list}">
                                        <h1>
                                            Hiện cửa hàng chưa có sản phẩm phù hợp
                                        </h1>
                                    </c:if>
                                    <h2 class="title-product">
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
                                                <c:if test="${status.index >= startIndex and status.index <= endIndex}">
                                                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                        <div class="item-product">
                                                            <div class="thumb">
                                                                <a href="ViewProductDetailsController?name=${p.productName}&id=${p.productID}">
                                                                    <img src="${p.imageURL}" alt="${p.productName}">
                                                                </a>
                                                                <div class="action">
                                                                    <a href="AddToCartController?id=${p.productID}" class="buy"><i class="fas fa-bolt "></i> Mua ngay</a>
                                                                    <a href="AddToCartController?id=${p.productID}&CategoryID=${p.categoryID}&web=list" class="like"><i class="fas fa-cart-plus me-2"></i> Thêm giỏ</a>
                                                                    <div class="clear"></div>
                                                                </div>
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
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <!-- Phần phân trang cải tiến -->
                                    <c:if test="${totalPages > 1}">
                                        <div class="pagination-container mt-4">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination justify-content-center">
                                                    <!-- Nút Previous -->
                                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                        <c:url var="prevUrl" value="">
                                                            <c:param name="page" value="${currentPage - 1}"/>
                                                            <c:forEach items="${param}" var="entry">
                                                                <c:if test="${entry.key ne 'page'}">
                                                                    <c:param name="${entry.key}" value="${entry.value}"/>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:url>
                                                        <a class="page-link" href="${prevUrl}" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>

                                                    <!-- Tính toán trang hiển thị -->
                                                    <c:set var="maxVisiblePages" value="5"/>
                                                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                                                    <c:set var="endPage" value="${startPage + maxVisiblePages - 1}"/>
                                                    <c:if test="${endPage > totalPages}">
                                                        <c:set var="endPage" value="${totalPages}"/>
                                                        <c:set var="startPage" value="${endPage - maxVisiblePages + 1 > 0 ? endPage - maxVisiblePages + 1 : 1}"/>
                                                    </c:if>

                                                    <!-- Hiển thị các trang -->
                                                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <c:url var="pageUrl" value="">
                                                                <c:param name="page" value="${i}"/>
                                                                <c:forEach items="${param}" var="entry">
                                                                    <c:if test="${entry.key ne 'page'}">
                                                                        <c:param name="${entry.key}" value="${entry.value}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:url>
                                                            <a class="page-link" href="${pageUrl}">${i}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <!-- Nút Next -->
                                                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                                        <c:url var="nextUrl" value="">
                                                            <c:param name="page" value="${currentPage + 1}"/>
                                                            <c:forEach items="${param}" var="entry">
                                                                <c:if test="${entry.key ne 'page'}">
                                                                    <c:param name="${entry.key}" value="${entry.value}"/>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:url>
                                                        <a class="page-link" href="${nextUrl}" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </c:if>
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
                <div class="alert-popup-icon" id="alertIcon"></div>
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
