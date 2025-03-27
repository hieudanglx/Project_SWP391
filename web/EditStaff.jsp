<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Staff Information</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #1a73e8;
                --secondary-color: #2c3e50;
                --accent-color: #4caf50;
                --background-color: #f4f6f9;
                --card-color: #ffffff;
                --text-color: #333;
            }
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background-color: var(--background-color);
                font-family: 'Inter', 'Arial', sans-serif;
                line-height: 1.6;
                color: var(--text-color);
            }
            .content {
                margin-left: 250px;
                padding: 30px;
                transition: all 0.3s ease;
            }
            .update-container {
                background-color: var(--card-color);
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                padding: 35px;
                max-width: 650px;
                margin: 0 auto;
                border: 1px solid rgba(0, 0, 0, 0.05);
                position: relative;
                overflow: hidden;
            }
            .update-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            }
            h3 {
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 25px;
                font-weight: 700;
                position: relative;
                padding-bottom: 10px;
            }
            h3::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background-color: var(--accent-color);
            }
            .form-label {
                font-weight: 600;
                color: var(--secondary-color);
                font-size: 0.85rem;
                margin-bottom: 0.4rem;
                transition: color 0.3s ease;
            }
            .form-control, .form-select {
                border-radius: 8px;
                border-color: rgba(0, 0, 0, 0.1);
                padding: 0.575rem 0.95rem;
                font-size: 0.9rem;
                transition: all 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(26, 115, 232, 0.2);
            }
            .form-control[readonly] {
                background-color: #f9f9f9;
                cursor: not-allowed;
                color: #6c757d;
            }
            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
            }
            .btn-update {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.4s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }
            .btn-update:hover {
                background-color: #1557b0;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }
            .btn-update i {
                margin-right: 5px;
            }
            @media (max-width: 768px) {
                .content {
                    margin-left: 0;
                    padding: 15px;
                }
                .form-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="update-container">
                <h3>Edit Staff Information</h3>
                <form action="EditAccountStaff_ForAdmin" method="POST">
                    <input type="hidden" name="staffID" value="${staff.staffID}" />
                    
                    <div class="form-grid">
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${staff.fullName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address" value="${staff.address}" required>
                        </div>
                        <div class="mb-3">
                            <label for="province_city" class="form-label">Province/City</label>
                            <input type="text" class="form-control" id="province_city" name="province_city" value="${staff.province_city}" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${staff.email}" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" value="${staff.password}" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${staff.phoneNumber}" required>
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" value="${staff.username}" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="cccd" class="form-label">CCCD</label>
                            <input type="text" class="form-control" id="cccd" name="cccd" value="${staff.cccd}" readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" id="dob" name="dob" value="${staff.dob}" required>
                    </div>

                    <div class="mb-3">
                        <label for="sex" class="form-label">Sex</label>
                        <select class="form-select" id="sex" name="sex">
                            <option value="Male" ${staff.sex == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${staff.sex == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${staff.sex == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="0" ${staff.status == 0 ? 'selected' : ''}>Active</option>
                            <option value="1" ${staff.status == 1 ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-update mt-3">
                            Update Staff Information
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>