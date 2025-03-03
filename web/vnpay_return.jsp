<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="vnpay.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <!-- Bootstrap core CSS -->
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>

        <style>
            /* --- Kết quả thanh toán --- */
            .payment-container {
                max-width: 800px;
                margin: 60px auto;
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
            }

            .payment-container h3 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .payment-table {
                width: 100%;
                margin-top: 15px;
            }

            .payment-group {
                display: flex;
                justify-content: space-between;
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            .payment-group label {
                font-weight: bold;
                color: #444;
            }

            .payment-value {
                color: #555;
                font-weight: normal;
            }

            .payment-status {
                font-size: 18px;
                font-weight: bold;
                padding: 10px;
                border-radius: 5px;
                margin-top: 15px;
            }

            .payment-status.success {
                color: #2e7d32;
                background: #e8f5e9;
            }

            .payment-status.failed {
                color: #d32f2f;
                background: #ffebee;
            }

            .payment-footer {
                margin-top: 20px;
                font-size: 14px;
                color: #666;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            //Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);

        %>
        <!--Begin display -->
        <div class="payment-container">
            <div>
                <h3>KẾT QUẢ THANH TOÁN</h3>
            </div>
            <div class="payment-table">
                <div class="payment-group">
                    <label>Mã giao dịch thanh toán:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_TxnRef")%></span>
                </div>    
                <div class="payment-group">
                    <label>Số tiền:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_Amount")%></span>
                </div>  
                <div class="payment-group">
                    <label>Mô tả giao dịch:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_OrderInfo")%></span>
                </div> 
                <div class="payment-group">
                    <label>Mã lỗi thanh toán:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_ResponseCode")%></span>
                </div> 
                <div class="payment-group">
                    <label>Mã giao dịch tại CTT VNPAY-QR:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_TransactionNo")%></span>
                </div> 
                <div class="payment-group">
                    <label>Mã ngân hàng thanh toán:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_BankCode")%></span>
                </div> 
                <div class="payment-group">
                    <label>Thời gian thanh toán:</label>
                    <span class="payment-value"><%=request.getParameter("vnp_PayDate")%></span>
                </div> 
                <div class="payment-group">
                    <label>Tình trạng giao dịch:</label>
                    <span class="payment-status
                          <%
                              if (signValue.equals(vnp_SecureHash)) {
                                  if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                      out.print("success");
                                  } else {
                                      out.print("failed");
                                  }
                              } else {
                                  out.print("failed");
                              }
                          %>">
                        <%
                            if (signValue.equals(vnp_SecureHash)) {
                                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                    out.print("Thành công");
                                } else {
                                    out.print("Không thành công");
                                }
                            } else {
                                out.print("Invalid signature");
                            }
                        %>
                    </span>
                </div> 
            </div>
            <footer class="payment-footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>
    </body>
</html>
