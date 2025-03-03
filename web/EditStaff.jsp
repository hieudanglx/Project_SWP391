<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Update Staff</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-container .form-label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Staff</h1>
        <form action="EditAccount_Staff" method="POST">
    <input type="hidden" name="staffID" value="${staff.staffID}" />
    
    <div class="mb-3">
        <label for="address" class="form-label">Address:</label>
        <input type="text" class="form-control" id="address" name="address" value="${staff.address}" required>
    </div>
    
    <div class="mb-3">
        <label for="email" class="form-label">Email:</label>
        <input type="email" class="form-control" id="email" name="email" value="${staff.email}" required>
    </div>
    
    <div class="mb-3">
        <label for="password" class="form-label">Password:</label>
        <input type="password" class="form-control" id="password" name="password" value="${staff.password}" required>
    </div>
    
    <div class="mb-3">
        <label for="fullName" class="form-label">Full Name:</label>
        <input type="text" class="form-control" id="fullName" name="fullName" value="${staff.fullName}" required>
    </div>
    
    <div class="mb-3">
        <label for="phoneNumber" class="form-label">Phone Number:</label>
        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${staff.phoneNumber}" required>
    </div>
    
    <div class="mb-3">
    <label for="username" class="form-label">Username:</label>
    <input type="text" class="form-control bg-light" id="username" name="username" value="${staff.username}" readonly>
</div>
    
    <div class="mb-3">
        <label for="status" class="form-label">Status:</label>
        <select class="form-select" id="status" name="status">
            <option value="0" ${staff.status == 0 ? 'selected' : ''}>Active</option>
            <option value="1" ${staff.status == 1 ? 'selected' : ''}>Inactive</option>
        </select>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Update
        </button>
    </div>
</form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>