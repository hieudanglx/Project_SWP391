<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Tạo mới đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/popup.css">  
    </head>
    <style>
        /* Định dạng chung cho container */
        .order-container2 {
            max-width: 800px;
            margin: 120px auto 50px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* Tiêu đề trang */
        .order-texth1 h1 {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        /* Định dạng cho input */
        .order-form-group {
            margin-bottom: 20px;
            text-align: left;
            margin-left: 240px;
        }



        /* Tiêu đề nhỏ */
        .order-container2 h3,
        .order-container2 h4,
        .order-container2 h5 {
            color: #444;
            margin-bottom: 10px;
        }



        /* Nút thanh toán */
        .order-btn {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            border: none;
            border-radius: 25px;
            background: linear-gradient(135deg, #4CAF50, #45A049);
            color: white;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        .order-btn:hover {
            background: linear-gradient(135deg, #45A049, #3E8E41);
        }

        /* Footer */
        .order-footer {
            margin-top: 20px;
            font-size: 14px;
            color: gray;
        }
        .sotien-form-group{

        }

    </style>

    <body>
        <%@include file="header.jsp" %>
        <div class="order-container2">
           
            <h3>Thanh toán qua thẻ ATM/Tài khoản nội địa</h3>
            <div class="table-responsive">
                <form action="ajaxServlet" id="frmCreateOrder" method="post">        
                    <div class="sotien-form-group">
                        <h5 for="amount">Số tiền: </h5> 
                        <input class="order-input" data-val="true" id="amount" name="amount" 
                               type="hidden" value="${(sessionScope.total )}" />

                        <span class="text-danger fw-bold"> <fmt:formatNumber value="${sessionScope.total}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNÐ</span>
                    </div>
                   
                    <div class="order-form-group">                        
                        <input type="hidden" id="bankCode3" name="bankCode" value="VNBANK">                       
                    </div>
                    <div class="order-form-group">
                        <h5>Chọn ngôn ngữ giao diện thanh toán:</h5>
                        <input type="radio" id="language1" checked="true" name="language" value="vn">
                        <label for="language1">Tiếng Việt</label><br>
                        <input type="radio" id="language2" name="language" value="en">
                        <label for="language2">Tiếng Anh</label><br>
                    </div>
                    <button type="submit" class="order-btn">Thanh toán</button>
                </form>
            </div>
            <footer class="order-footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>

        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajaxServlet({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>       
    </body>
</html>