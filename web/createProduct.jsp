<%-- 
    Document   : createProduct
    Created on : Feb 24, 2025, 1:12:38 AM
    Author     : Dinh Van Do - CE182224
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Create New Product</h2>

            <form action="createProduct" method="POST" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="productID" class="form-label">Product ID</label>
                    <input type="text" class="form-control" id="productID" name="productID" required />
                </div>

                <div class="mb-3">
                    <label for="productName" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" required />
                </div>

                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="number" class="form-control" id="price" name="price" required />
                </div>

                 <div class="mb-3">
                    <label for="category" class="form-label">Category</label>
                    <select class="form-control" id="category" name="category" required>
                        <option value="1">1(Laptop)</option>
                        <option value="2">2(DienThoai)</option>
                        <option value="3">3(Tablet)</option>
                    </select>
                </div>


                <div class="mb-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" required />
                </div>

                <div class="mb-3">
                    <label for="camera" class="form-label">Camera</label>
                    <input type="text" class="form-control" id="camera" name="camera" required />
                </div>

                <div class="mb-3">
                    <label for="ram" class="form-label">RAM</label>
                    <input type="text" class="form-control" id="ram" name="ram" required />
                </div>

                <div class="mb-3">
                    <label for="rom" class="form-label">ROM</label>
                    <input type="text" class="form-control" id="rom" name="rom" required />
                </div>

                <div class="mb-3">
                    <label for="color" class="form-label">Color</label>
                    <input type="text" class="form-control" id="color" name="color" required />
                </div>

                <div class="mb-3">
                    <label for="operatingSystem" class="form-label">Operating System</label>
                    <input type="text" class="form-control" id="operatingSystem" name="operatingSystem" required />
                </div>

                <div class="mb-3">
                    <label for="size" class="form-label">Size</label>
                    <input type="text" class="form-control" id="size" name="size" required />
                </div>

                <div class="mb-3">
                    <label for="refreshRate" class="form-label">Refresh Rate</label>
                    <input type="text" class="form-control" id="refreshRate" name="refreshRate" required />
                </div>

                <div class="mb-3">
                    <label for="chip" class="form-label">Chip</label>
                    <input type="text" class="form-control" id="chip" name="chip" required />
                </div>

                <div class="mb-3">
                    <label for="gpu" class="form-label">GPU</label>
                    <input type="text" class="form-control" id="gpu" name="gpu" required />
                </div>

                <!--                <div class="mb-3">
                                    <label for="quantitySell" class="form-label">Quantity Sold</label>
                                    <input type="number" class="form-control" id="quantitySell" name="quantitySell" required />
                                </div>-->

                <!--                <div class="mb-3">
                                    <label for="quantityProduct" class="form-label">Quantity Available</label>
                                    <input type="number" class="form-control" id="quantityProduct" name="quantityProduct" required />
                                </div>-->

                <div class="mb-3">
                    <label for="imageURL" class="form-label">Image URL</label>
                    <input type="url" class="form-control" id="imageURL" name="imageURL" required />
                </div>

                <!--                <input type="hidden" name="isDelete" value="0" />-->

                <div class="d-flex justify-content-start">
                    <button type="submit" class="btn btn-primary me-2">Save</button>
                    <a href="/listProductsForAdmin" class="btn btn-secondary">Back to List</a>
                </div>
            </form>
        </div>
        <script>
            (function () {
                'use strict';
                window.addEventListener('load', function () {
                    var forms = document.getElementsByClassName('needs-validation');
                    Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>

    </body>
</html>
