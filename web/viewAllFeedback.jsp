<%-- 
    Document   : viewAllFeedback.jsp
    Created on : Mar 11, 2025
    Author     : TRAN NHU Y - CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Feedback</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #3498db;
                --secondary-color: #2ecc71;
                --background-light: #f4f6f7;
                --text-dark: #2c3e50;
            }

            body {
                background-color: var(--background-light);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-dark);
            }

            .dashboard-container {
                display: flex;
                min-height: 100vh;
            }

            .sidebar {
                width: 260px;
                background: linear-gradient(135deg, var(--primary-color), #2980b9);
                color: white;
                padding: 20px 0;
                transition: width 0.3s ease;
            }

            .sidebar a {
                color: rgba(255,255,255,0.8);
                padding: 12px 20px;
                display: block;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .sidebar a:hover {
                background-color: rgba(255,255,255,0.1);
                color: white;
                transform: translateX(10px);
            }

            .content {
                flex-grow: 1;
                padding: 20px;
                margin-left: 260px;
                transition: margin-left 0.3s ease;
            }

            .feedback-table {
                background: white;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .feedback-card {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 15px;
                margin-top: 10px;
            }

            .alert {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1000;
                animation: slideIn 0.5s ease;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                }
                to {
                    transform: translateX(0);
                }
            }

            .rate-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: bold;
            }

            .rate-badge-good {
                background-color: #28a745;
                color: white;
            }

            .rate-badge-average {
                background-color: #ffc107;
                color: black;
            }

            .rate-badge-poor {
                background-color: #dc3545;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <jsp:include page="sidebar.jsp" />

            <div class="content">
                <div class="container-fluid">
                    <div class="row mb-4">
                        <div class="col">
                            <h2 class="text-center mb-4">
                                <i class="fas fa-comment-dots me-2"></i>Feedback Management
                            </h2>

                            <c:if test="${not empty repSuccess}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${repSuccess}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <div class="table-responsive feedback-table">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Client</th>
                                            <th>Content</th>
                                            <th>Rating Score</th>
                                            <th>Product</th>
                                            <th>Act</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty feedbackList}">
                                                <c:forEach var="feedback" items="${feedbackList}">
                                                    <tr>
                                                        <td>${feedback.feedbackID}</td>
                                                        <td>${customerNames[feedback.customerID] != null ? customerNames[feedback.customerID] : 'Unknown'}</td>
                                                        <td>
                                                            ${feedback.content}
                                                            <c:if test="${not empty feedbackReplies[feedback.feedbackID]}">
                                                                <div class="text-muted mt-2">
                                                                    <strong>Response:</strong> 
                                                                    ${feedbackReplies[feedback.feedbackID]}
                                                                </div>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <span class="rate-badge ${feedback.ratePoint >= 4 ? 'rate-badge-good' : 
                                                                                      (feedback.ratePoint >= 2 ? 'rate-badge-average' : 'rate-badge-poor')}">
                                                                      ${feedback.ratePoint}/5
                                                                  </span>
                                                            </td>
                                                            <td>${productNames[feedback.productID] != null ? productNames[feedback.productID] : 'Unknown'}</td>
                                                            <td>
                                                                <div class="btn-group" role="group">
                                                                    <a href="feedback?action=delete&feedbackID=${feedback.feedbackID}" 
                                                                       class="btn btn-sm btn-outline-danger" 
                                                                       onclick="return confirm('Are you sure you want to delete?');">
                                                                        <i class="fas fa-trash"></i>
                                                                    </a>
                                                                    <button class="btn btn-sm btn-outline-primary" 
                                                                            data-bs-toggle="modal" 
                                                                            data-bs-target="#replyModal${feedback.feedbackID}">
                                                                        <i class="fas fa-reply"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center text-muted">
                                                            <i class="fas fa-inbox fa-2x mb-3"></i>
                                                            <p>There is no feedback to display.</p>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reply Modals for each feedback -->
            <c:forEach var="feedback" items="${feedbackList}">
                <div class="modal fade" id="replyModal${feedback.feedbackID}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Response feedback</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form action="feedback" method="post">
                                    <input type="hidden" name="action" value="reply">
                                    <input type="hidden" name="feedbackID" value="${feedback.feedbackID}">
                                    <input type="hidden" name="customerID" value="${feedback.customerID}">

                                    <div class="mb-3">
                                        <label class="form-label">Respondent:</label>
                                        <input type="text" class="form-control" 
                                               value="${sessionScope.username eq 'admin' ? sessionScope.adminID : sessionScope.staffId}" 
                                               readonly>
                                        <input type="hidden" name="staffID" 
                                               value="${sessionScope.username eq 'admin' ? sessionScope.adminID : sessionScope.staffId}">
                                    </div>

                                    <div class="mb-3">
                                        <label for="replyContent" class="form-label">Response Content</label>
                                        <textarea name="replyContent" class="form-control" rows="4" 
                                                  placeholder="Enter response..." required></textarea>
                                    </div>

                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-paper-plane me-2"></i>Send response
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                                                                           document.addEventListener('DOMContentLoaded', function () {
                                                                               var alertElements = document.querySelectorAll('.alert');
                                                                               alertElements.forEach(function (alert) {
                                                                                   setTimeout(function () {
                                                                                       bootstrap.Alert.getOrCreateInstance(alert).close();
                                                                                   }, 5000);
                                                                               });
                                                                           });
            </script>
        </body>
    </html>