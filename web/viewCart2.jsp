<%-- 
    Document   : viewCart2
    Created on : Feb 25, 2025, 5:23:00 PM
    Author     : CE180594_Phan Qu?c Duy
--%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gi? H�ng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                width: 50%;
                margin: 0 auto;
            }
            .product, .customer-info {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 10px;
            }
            .product img {
                width: 50px;
                height: 50px;
            }
            .product-details {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .product-info {
                flex-grow: 1;
                padding: 0 10px;
            }
            .quantity-controls {
                display: flex;
                align-items: center;
            }
            .quantity-controls button {
                margin: 0 5px;
            }
            input, select {
                width: 100%;
                padding: 5px;
                margin: 5px 0;
            }
            .btn-order {
                background-color: orange;
                color: white;
                padding: 10px;
                border: none;
                width: 100%;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Gi? H�ng</h2>

            <!-- Danh s�ch s?n ph?m -->
            <c:forEach var="product" items="${productList}">
                <div class="product">
                    <div class="product-details">
                        <img src="${product.imgURL}" alt="${product.name}">
                        <div class="product-info">
                            <strong>${product.name}</strong><br>
                            <span>${product.price}?</span>
                        </div>
                        <div class="quantity-controls">
                            <button>-</button>
                            <input type="text" value="${product.quantity}" size="2">
                            <button>+</button>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Th�ng tin kh�ch h�ng -->
            <div class="customer-info">
                <h3>TH�NG TIN KH�CH H�NG</h3>
                <input type="text" placeholder="H? t�n">
                <input type="email" placeholder="Email">
                <input type="tel" placeholder="S? ?i?n tho?i">

                <h3>??A CH? NH?N H�NG</h3>
                <select>
                    <option>T?nh/Th�nh ph?</option>
                </select>
                <select>
                    <option>Qu?n/Huy?n</option>
                </select>
                <input type="text" placeholder="S? nh�, t�n ???ng, ph??ng/x�">

                <h3>H�NH TH?C THANH TO�N</h3>
                <label><input type="radio" name="payment" value="cod"> Thanh to�n khi nh?n h�ng (COD)</label><br>
                <label><input type="radio" name="payment" value="vnpay"> Thanh to�n b?ng th? ATM n?i ??a (VNPAY)</label>

                <button class="btn-order">??t h�ng</button>
            </div>
        </div>
    </body>
</html>

