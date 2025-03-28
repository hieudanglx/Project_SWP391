<%-- 
    Document   : import_inventory
    Created on : Mar 15, 2025, 5:11:46 PM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Import Products to Inventory</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .sidebar {
                width: 280px;
                height: 100vh;
                background: linear-gradient(to bottom, #343a40, #212529);
                color: white;
                padding: 20px 0;
                position: fixed;
                box-shadow: 2px 0 10px rgba(0,0,0,0.1);
                z-index: 1000;
                overflow-y: auto;
            }
            .sidebar-header {
                padding: 0 20px 20px 20px;
                border-bottom: 1px solid rgba(255,255,255,0.1);
                margin-bottom: 15px;
            }
            .sidebar a {
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                display: block;
                padding: 12px 20px;
                transition: all 0.3s;
                border-left: 4px solid transparent;
            }
            .sidebar a:hover, .sidebar a.active {
                background: rgba(255,255,255,0.1);
                color: white;
                border-left: 4px solid #0d6efd;
            }
            .sidebar a i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }
            .content {
                margin-left: 280px;
                padding: 20px;
                transition: all 0.3s;
            }
            .navbar {
                margin-left: 280px;
                width: calc(100% - 280px);
                background: white !important;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 15px 20px;
            }
            .card {
                border: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                border-radius: 10px;
            }
            .card-header {
                background-color: white;
                border-bottom: 1px solid rgba(0,0,0,0.08);
                padding: 20px 25px;
            }
            .form-control, .btn {
                border-radius: 8px;
                padding: 10px 15px;
            }
            .form-control:focus {
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
            }
            .form-label {
                font-weight: 500;
                color: #495057;
            }
            .bg-light-gray {
                background-color: #f0f2f5 !important;
            }
            .btn-success {
                background-color: #198754;
                border-color: #198754;
                padding: 12px 30px;
                font-weight: 600;
                transition: all 0.3s;
            }
            .btn-success:hover {
                background-color: #157347;
                border-color: #146c43;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .user-avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                background-color: #e9ecef;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 10px;
            }
            .input-group-text {
                background-color: #f8f9fa;
                border-right: none;
            }
            .input-with-icon .form-control {
                border-left: none;
            }
            .readonly-field {
                background-color: #f8f9fa !important;
                cursor: not-allowed;
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />

        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"><i class="fas fa-warehouse"></i> Manage Inventory</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
        </nav>


        <div class="content">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="ListInventory">Inventory</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Import Products</li>
                </ol>
            </nav>

            <div class="card shadow-sm mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-plus-circle text-success me-2"></i> Import Products to Inventory</h5>
                </div>
                <div class="card-body p-4">
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>


                    <form action="importInventory" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="productID" class="form-label">Product ID:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                    <input type="number" id="productID" name="productID" class="form-control readonly-field" value="${param.productID != null ? param.productID : inventory.productID}" readonly />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="productName" class="form-label">Product Name:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                    <input type="text" id="productName" name="productName" class="form-control readonly-field" value="${param.productName != null ? param.productName : inventory.productName}" readonly />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="price" class="form-label">Selling Price:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-money-bill"></i></span>
                                    <input type="number" id="price" name="price" class="form-control readonly-field" value="${param.price != null ? param.price : inventory.price}" readonly />
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="importQuantity" class="form-label">Import Quantity:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-boxes"></i></span>
                                    <input type="number" id="importQuantity" name="importQuantity" class="form-control" value="${param.importQuantity != null ? param.importQuantity : inventory.getImport_quantity()}" required min="1" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="importPrice" class="form-label">Import Price:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-tags"></i></span>
                                    <input type="number" id="importPrice" name="importPrice" class="form-control" value="${param.importPrice != null ? param.importPrice : inventory.getImport_price()}" required min="1000" />
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="supplier" class="form-label">Supplier:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-truck"></i></span>
                                    <input type="text" id="supplier" name="supplier" class="form-control" value="${param.supplier != null ? param.supplier : inventory.supplier}" required />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="importDate" class="form-label">Import Date:</label>
                                <div class="input-group input-with-icon mb-3">
                                    <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                    <input type="text" id="importDate" name="importDate" class="form-control"
                                           value="${inventory.getDATE() != null ? 
                                                    inventory.getDATE().format(java.time.format.DateTimeFormatter.ofPattern('yyyy/MM/dd')) : ''}" 
                                           required />
                                </div>
                            </div>


                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <a href="ListInventory" class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Back
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save me-2"></i>Import to Inventory
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="mt-4 text-center text-muted small">
                <p>© 2025 Inventory Management System</p>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>

            // Form validation
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.querySelector('form');
                form.addEventListener('submit', function (event) {
                    const importQuantity = document.getElementById('importQuantity').value;
                    const importPrice = document.getElementById('importPrice').value;
                    const supplier = document.getElementById('supplier').value;

                    if (importQuantity <= 0) {
                        alert('Import quantity must be greater than 0');
                        event.preventDefault();
                        return false;
                    }

                    if (importPrice <= 0) {
                        alert('Import price must be greater than 0');
                        event.preventDefault();
                        return false;
                    }

                    if (supplier.trim() === '') {
                        alert('Please enter supplier name');
                        event.preventDefault();
                        return false;
                    }
                    let dateInput = document.getElementById("importDate");
                    dateInput.addEventListener("input", function () {
                        this.value = this.value.replace(/-/g, "/"); // Thay dấu "-" bằng "/"
                    
                });
            });
            
        </script>
    </body>
</html>