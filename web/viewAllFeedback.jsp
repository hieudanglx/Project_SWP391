<%-- 
    Document   : viewAllFeedback.jsp
    Created on : Mar 11, 2025
    Author     : TRAN NHU Y - CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Feedback</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center">Danh sách Feedback</h2>
            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Nội dung</th>
                        <th>Điểm đánh giá</th>
                        <th>Product ID</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty feedbackList}">
                            <c:forEach var="feedback" items="${feedbackList}">
                                <tr>
                                    <td>${feedback.feedbackID}</td>
                                    <td>${customerNames[feedback.customerID] != null ? customerNames[feedback.customerID] : 'Không xác định'}</td>
                                    <td>${feedback.content}</td>
                                    <td>${feedback.ratePoint}</td>
                                    <td>${productNames[feedback.productID.toString()] ne null ? productNames[feedback.productID.toString()] : 'Không xác định'}</td>
                                    <td>
                                        <a href="feedback?action=delete&feedbackID=${feedback.feedbackID}" class="btn btn-danger"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>
                                        <form action="feedback" method="post" style="display:inline">
                                            <input type="hidden" name="action" value="reply">
                                            <input type="hidden" name="feedbackID" value="${feedback.feedbackID}">
                                            <input type="hidden" name="customerID" value="${feedback.customerID}">
                                            <textarea name="replyContent" placeholder="Nhập phản hồi..." required></textarea>
                                            <button type="submit" class="btn btn-primary">Gửi phản hồi</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center">Không có feedback nào.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </body>
</html>