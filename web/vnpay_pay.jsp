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
        <!-- Bootstrap core CSS -->
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>
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
            <div class="order-texth1">
                <h1>VNPAY DEMO</h1>
            </div>
            <h3>Tạo mới đơn hàng</h3>
            <div class="table-responsive">
                <form action="ajaxServlet" id="frmCreateOrder" method="post">        
                    <div class="sotien-form-group">
                        <label for="amount">Số tiền</label>
                        <input class="order-input" data-val="true" data-val-number="The field Amount must be a number." 
                               data-val-required="The Amount field is required." id="amount" max="100000000" min="1" 
                               name="amount" type="number" value="10000" />
                    </div>
                    <h4>Chọn phương thức thanh toán</h4>
                    <div class="order-form-group">
                        <h5>Cách 1: Chuyển hướng sang Cổng VNPAY chọn phương thức thanh toán</h5>
                        <input type="radio" checked="true" id="bankCode1" name="bankCode" value="">
                        <label for="bankCode1">Cổng thanh toán VNPAYQR</label><br>

                        <h5>Cách 2: Tách phương thức tại site của đơn vị kết nối</h5>
                        <input type="radio" id="bankCode2" name="bankCode" value="VNPAYQR">
                        <label for="bankCode2">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label><br>

                        <input type="radio" id="bankCode3" name="bankCode" value="VNBANK">
                        <label for="bankCode3">Thanh toán qua thẻ ATM/Tài khoản nội địa</label><br>

                        <input type="radio" id="bankCode4" name="bankCode" value="INTCARD">
                        <label for="bankCode4">Thanh toán qua thẻ quốc tế</label><br>
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
                $.ajax({
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