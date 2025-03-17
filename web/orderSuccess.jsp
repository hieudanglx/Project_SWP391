<%-- 
    Document   : orderSuccess
    Created on : Mar 17, 2025, 2:35:57 AM
    Author     : TRAN NHU Y -  CE182032
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt hàng thành công</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f8f9fa;
                color: #333;
                line-height: 1.6;
            }

            .container {
                max-width: 800px;
                margin: 50px auto;
                padding: 30px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .success-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 20px;
                background-color: #4CAF50;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .success-icon i {
                color: white;
                font-size: 40px;
            }

            h1 {
                color: #4CAF50;
                margin-bottom: 20px;
                font-size: 28px;
            }

            .order-details {
                margin: 30px 0;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 8px;
            }

            .order-id {
                font-size: 24px;
                font-weight: bold;
                color: #2c3e50;
                margin: 10px 0;
                padding: 10px;
                background-color: #e9ecef;
                border-radius: 5px;
                display: inline-block;
            }

            .message {
                font-size: 16px;
                margin-bottom: 20px;
                color: #666;
            }

            .btn {
                display: inline-block;
                padding: 12px 30px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: all 0.3s ease;
                margin-top: 20px;
            }

            .btn:hover {
                background-color: #45a049;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .footer {
                margin-top: 40px;
                font-size: 14px;
                color: #888;
            }

            @media (max-width: 600px) {
                .container {
                    margin: 20px;
                    padding: 20px;
                }

                h1 {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="success-icon">
                <i>✓</i>
            </div>

            <h1>Đặt hàng thành công!</h1>

            <p class="message">Cảm ơn bạn đã mua hàng tại cửa hàng của chúng tôi.</p>

            <div class="order-details">
                <p>Mã đơn hàng của bạn là:</p>
                <div class="order-id">${orderID}</div>
                <p>Vui lòng lưu lại mã đơn hàng để tiện theo dõi.</p>
            </div>

            <p class="message">Chúng tôi sẽ liên hệ để xác nhận đơn hàng sớm nhất có thể.</p>

            <a href="index.jsp" class="btn">Tiếp tục mua sắm</a>

            <div class="footer">
                <p>Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua email hoặc hotline.</p>
            </div>
        </div>
    </body>
</html>
