<%-- 
    Document   : import_inventory
    Created on : Mar 15, 2025, 5:11:46 PM
    Author     : Tran Phong Hai - CE180803
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập Kho Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f4f4; }
        .sidebar { width: 250px; height: 100vh; background: #343a40; color: white; padding: 15px; position: fixed; }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px; }
        .sidebar a:hover { background: #495057; border-radius: 5px; }
        .content { margin-left: 270px; padding: 20px; }
        .navbar { margin-left: 250px; width: calc(100% - 250px); }
    </style>
</head>
<body>
    <div class="sidebar">
        <h4 class="text-center">
            <a href="HomeDashBoard_Admin.jsp" class="text-decoration-none text-light fw-bold">Dashboard</a>
        </h4>
        <a href="/ListAccountStaff">Manage Staff</a>
        <a href="listAccountCustomer">Manage Customer</a>
        <a href="listProductsForAdmin">Manage Products</a>
        <a href="feedback">Manage Feedback</a>
        <a href="Revenue">Manage Revenue</a>
        <a href="ListInventory">Manage Inventory</a>
    </div>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="ListInventory">Manage Inventory</a>
            <div class="ms-auto">
                <a href="ManagerProfile.jsp" class="text-dark me-3 fw-bold">${sessionScope.fullname}</a>
                <a href="javascript:void(0);" class="fw-bold" onclick="logout()">Logout</a>
            </div>
        </div>
    </nav>

    <div class="content">
        <div class="container mt-4 bg-white p-4 rounded shadow">
            <h2 class="text-center">Nhập Kho Sản Phẩm</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <form action="importInventory" method="post">
                <div class="mb-3">
                    <label for="productID" class="form-label">Mã Sản Phẩm:</label>
                    <input type="number" id="productID" name="productID" class="form-control" value="${inventory.productID}" readonly />
                </div>
                <div class="mb-3">
                    <label for="productName" class="form-label">Tên Sản Phẩm:</label>
                    <input type="text" id="productName" name="productName" class="form-control" value="${inventory.productName}" readonly />
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Giá Bán:</label>
                    <input type="number" id="price" name="price" class="form-control" value="${inventory.price}" readonly />
                </div>
                <div class="mb-3">
                    <label for="importQuantity" class="form-label">Số Lượng Nhập:</label>
                    <input type="number" id="importQuantity" name="importQuantity" class="form-control" value="${param.importQuantity != null ? param.importQuantity : inventory.getImport_quantity()}" required />
                </div>
                <div class="mb-3">
                    <label for="importPrice" class="form-label">Giá Nhập:</label>
                    <input type="number" id="importPrice" name="importPrice" class="form-control" value="${param.importPrice != null ? param.importPrice : inventory.getImport_price()}" required />
                </div>
                <div class="mb-3">
                    <label for="supplier" class="form-label">Nhà Cung Cấp:</label>
                    <input type="text" id="supplier" name="supplier" class="form-control" value="${param.supplier != null ? param.supplier : inventory.supplier}" required />
                </div>
                <div class="mb-3">
                    <label for="importDate" class="form-label">Ngày Nhập:</label>
                    <input type="date" id="importDate" name="importDate" class="form-control" value="${param.importDate != null ? param.importDate : inventory.getDATE()}" required />
                </div>
                <button type="submit" class="btn btn-success">Nhập Kho</button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function logout() {
            fetch('/LogOutStaffAndAdminController', { method: 'POST' })
                .then(response => response.ok ? window.location.href = '/LoginOfDashboard.jsp' : alert('Logout Failed!'))
                .catch(error => console.error('Logout Error:', error));
        }
    </script>
</body>
</html>
