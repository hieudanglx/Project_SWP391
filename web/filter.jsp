<%-- 
    Document   : filter
    Created on : Mar 7, 2025, 11:31:28 PM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/filter.css" type="text/css">
        <title>JSP Page</title>
    </head>
    <body class="filter">
        <div class="wrapper cf">
            <form action="FilterGCController?CategoryID=${CategoryID}" method="Post">
                <aside class="sidebar">
                    <h1 class="sidebar-heading">
                        Filter by
                    </h1>

                    <ul class="filter ul-reset">


                        <li class="filter-item">
                            <section class="filter-item-inner">
                                <h1 class="filter-item-inner-heading plus">
                                    Hãng sản xuất
                                </h1>
                                <ul class="filter-attribute-list ul-reset filter-section">
                                    <div class="filter-attribute-list-inner">
                                        <c:forEach items="${listbrand}" var="v">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="brand" value="${v}"> ${v}
                                            </li>
                                        </c:forEach>
                                    </div>
                                </ul>
                            </section>
                        </li>
                        <li class="filter-item">
                            <section class="filter-item-inner">
                                <h1 class="filter-item-inner-heading plus">
                                    Loại sản phẩm
                                </h1>
                                <ul class="filter-attribute-list ul-reset filter-section">
                                    <div class="filter-attribute-list-inner">
                                        <c:choose>
                                            <c:when test="${CategoryID==1}">
                                                <li class="filter-attribute-item filter-item">
                                                    <input class="filter-attribute-checkbox ib-m" type="radio" name="os" value="Windows"> Windows
                                                </li>
                                                <li class="filter-attribute-item filter-item">
                                                    <input class="filter-attribute-checkbox ib-m" type="radio"name="os" value="macOS"> MacBook
                                                </li>
                                            </c:when>
                                            <c:when test="${CategoryID==2}">
                                                <li class="filter-attribute-item filter-item">
                                                    <input class="filter-attribute-checkbox ib-m" type="radio"name="os" value="iOS"> IOS
                                                </li>
                                            </c:when>
                                            <c:when test="${CategoryID==3}">
                                                <li class="filter-attribute-item filter-item">
                                                    <input class="filter-attribute-checkbox ib-m" type="radio"name="os" value="iPadOS"> IPadOS
                                                </li>
                                            </c:when>
                                        </c:choose>
                                        <c:if test="${CategoryID!=1}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio"name="os" value="Android"> Android
                                            </li>
                                        </c:if>
                                    </div>
                                </ul>
                            </section>
                        </li>
                        <li class="filter-item">
                            <section class="filter-item-inner">
                                <h1 class="filter-item-inner-heading plus">
                                    RAM
                                </h1>
                                <ul class="filter-attribute-list ul-reset filter-section">
                                    <div class="filter-attribute-list-inner">
                                        <c:if test="${CategoryID!=1}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="ram" value="6gb"> 6 GB
                                            </li>
                                        </c:if>
                                        <li class="filter-attribute-item filter-item">
                                            <input class="filter-attribute-checkbox ib-m" type="radio" name="ram" value="8gb"> 8 GB
                                        </li>
                                        <c:if test="${CategoryID!=1}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="ram" value="12gb"> 12 GB
                                            </li>
                                        </c:if>
                                        <c:if test="${CategoryID!=3}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="ram" value="16gb"> 16 GB
                                            </li>
                                        </c:if>
                                        <c:if test="${CategoryID==1}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="ram" value="32gb"> 32 GB
                                            </li>
                                        </c:if>
                                    </div>
                                </ul>
                            </section>
                        </li>

                        <li class="filter-item">
                            <section class="filter-item-inner">
                                <h1 class="filter-item-inner-heading plus">
                                    Bộ nhớ
                                </h1>
                                <ul class="filter-attribute-list ul-reset filter-section">
                                    <div class="filter-attribute-list-inner">
                                        <c:if test="${CategoryID!=1}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="rom" value="128gb"> 128 GB
                                            </li>
                                        </c:if>
                                        <li class="filter-attribute-item filter-item">
                                            <input class="filter-attribute-checkbox ib-m" type="radio" name="rom" value="256gb"> 256 GB
                                        </li>
                                        <li class="filter-attribute-item filter-item">
                                            <input class="filter-attribute-checkbox ib-m" type="radio" name="rom" value="512gb"> 512 GB
                                        </li>
                                        <c:if test="${CategoryID==2}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="rom" value="1tb"> 1 TB
                                            </li>
                                        </c:if>
                                    </div>
                                </ul>
                            </section>
                        </li>
                        <li class="filter-item">
                            <section class="filter-item-inner">
                                <h1 class="filter-item-inner-heading plus">
                                    Tần số quét
                                </h1>
                                <ul class="filter-attribute-list ul-reset filter-section">
                                    <div class="filter-attribute-list-inner">
                                        <li class="filter-attribute-item filter-item">
                                            <input class="filter-attribute-checkbox ib-m" type="radio" name="rate" value="60hz"> 60 Hz
                                        </li>
                                        <c:if test="${CategoryID!=1}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="rate" value="90hz"> 90 Hz
                                            </li>
                                        </c:if>
                                        <li class="filter-attribute-item filter-item">
                                            <input class="filter-attribute-checkbox ib-m" type="radio" name="rate" value="120hz"> 120 Hz
                                        </li>
                                        <c:if test="${CategoryID!=2}">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="rate" value="144hz"> 144 Hz
                                            </li>
                                        </c:if>
                                    </div>
                                </ul>
                            </section>
                        </li>


                        <c:if test="${CategoryID==1}">
                            <li class="filter-item">
                                <section class="filter-item-inner">
                                    <h1 class="filter-item-inner-heading plus">
                                        Độ phân giải
                                    </h1>
                                    <ul class="filter-attribute-list ul-reset filter-section">
                                        <div class="filter-attribute-list-inner" name="res">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="res" value="Full HD"> Full HD
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="res" value="2K"> 2K
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="res" value="4K OLED"> 4K OLED
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="res" value="4K"> 4K
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="res" value="Retina"> Retina
                                            </li>
                                        </div>
                                    </ul>
                                </section>
                            <li class="filter-item">
                                <section class="filter-item-inner">
                                    <h1 class="filter-item-inner-heading plus">
                                        Kích cỡ màn hình
                                    </h1>
                                    <ul class="filter-attribute-list ul-reset filter-section">
                                        <div class="filter-attribute-list-inner" name="size">
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="size" value="13"> 13"
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="size" value="14"> 14"
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="size" value="15.6"> 15.6"
                                            </li>
                                            <li class="filter-attribute-item filter-item">
                                                <input class="filter-attribute-checkbox ib-m" type="radio" name="size" value="16"> 16"
                                            </li>
                                        </div>
                                    </ul>
                                </section>
                            </li>
                            <c:forEach items="${Chip}" var="chipGroup" varStatus="i">
                                <li class="filter-item">
                                    <section class="filter-item-inner">
                                        <h1 class="filter-item-inner-heading plus">
                                            ${Chiptype[i.count-1]}
                                        </h1>
                                        <ul class="filter-attribute-list ul-reset filter-section">
                                            <div class="filter-attribute-list-inner" name="${Chiptype[i.count-1]}">
                                                <c:forEach items="${chipGroup}" var="chip">
                                                    <li class="filter-attribute-item filter-item">
                                                        <input class="filter-attribute-checkbox ib-m" type="radio" name="${Chiptype[i.count-1]}" value="${chip}"> ${chip}
                                                    </li>
                                                </c:forEach>
                                            </div>
                                        </ul>
                                    </section>
                                </li>
                            </c:forEach>
                        </c:if>

                        <!-- Phần Price Range -->
                        <li class="filter-item">
                            <section class="filter-item-inner">
                                <h1 class="filter-item-inner-heading">
                                    Price Range
                                </h1>
                                <ul class="filter-item ul-reset">
                                    <div class="price-input">
                                        <div class="field">
                                            <input type="text" 
                                                   class="input-min" 
                                                   value="<fmt:formatNumber value="25000000" pattern="#,##0" />"
                                                   data-raw-value="25000000">
                                        </div>
                                        <div class="separator">-</div>
                                        <div class="field">
                                            <input type="text" 
                                                   class="input-max" 
                                                   value="<fmt:formatNumber value="75000000" pattern="#,##0" />"
                                                   data-raw-value="75000000">
                                        </div>
                                    </div>
                                    <div class="slider">
                                        <div class="progress"></div>
                                    </div>
                                    <div class="range-input">
                                        <input type="range" name="minPrice" class="range-min" min="0" max="100000000" value="25000000" step="1000000">
                                        <input type="range" name="maxPrice" class="range-max" min="0" max="100000000" value="75000000" step="1000000">
                                    </div>
                                </ul>
                            </section>
                        </li>
                    </ul>
                    <div class="filter-action mt-3">
                        <button type="submit" class="btn btn-primary w-100" style="margin: 0">Lọc</button>
                    </div>
                </aside>
            </form>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/filter.js"></script>
</html>