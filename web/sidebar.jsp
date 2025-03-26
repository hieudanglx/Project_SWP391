<%-- 
    Document   : sidebar
    Created on : Mar 23, 2025, 7:36:45 PM
    Author     : Dinh Van Do - CE182224
--%>

<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <!-- Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
<!--        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">-->
        <title>Admin Dashboard</title>
    </head>

    <style>
        body {
            font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        /* Sidebar */
        .sidebar {
            height: 100vh;
            width: 280px;
            background: linear-gradient(135deg, #3a4f6f, #162742);
            color: white;
            position: fixed;
            padding-top: 15px;
            box-shadow: 3px 0 15px rgba(0, 0, 0, 0.15);
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 12px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 15px;
        }

        .sidebar-logo {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 1px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .sidebar-logo i {
            margin-right: 10px;
            color: #2fd1cb;
        }

        .sidebar a {
            padding: 14px 20px;
            text-decoration: none;
            font-size: 15px;
            color: rgba(255, 255, 255, 0.8);
            display: flex;
            align-items: center;
            transition: all 0.3s;
            border-left: 4px solid transparent;
            margin: 4px 0;
            border-radius: 0 30px 30px 0;
        }

        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid #2fd1cb;
            transform: translateX(5px);
        }

        .sidebar a.active {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border-left: 4px solid #2fd1cb;
            font-weight: 500;
        }

        .sidebar a i {
            margin-right: 15px;
            width: 20px;
            text-align: center;
            font-size: 18px;
            color: #2fd1cb;
        }

        /* Existing active link styling with some enhancements */
        .sidebar a.active {
            background: rgba(255, 255, 255, 0.2); /* Slightly more visible background */
            color: white;
            border-left: 4px solid #2fd1cb; /* Teal accent border */
            font-weight: 600; /* Slightly bolder font */
            transform: translateX(10px); /* More pronounced horizontal shift */
            box-shadow: 0 4px 10px rgba(47, 209, 203, 0.3); /* Subtle shadow effect */
            transition: all 0.3s ease; /* Smooth transition for hover and active states */
        }

        /* Additional hover effect for non-active links */
        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border-left: 4px solid rgba(47, 209, 203, 0.7); /* Softer accent on hover */
            transform: translateX(8px);
        }

        /* Icon styling for active state */
        .sidebar a.active i {
            color: #2fd1cb; /* Bright teal for active icon */
            transform: scale(1.1); /* Slightly larger icon */
            transition: transform 0.3s ease;
        }

        .menu-category {
            color: rgba(255, 255, 255, 0.5);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 20px 0 5px 20px;
            font-weight: 500;
        }

        /* Main Content */
        .content {
            margin-left: 280px;
            padding: 20px;
            transition: all 0.3s ease;
        }

        /* Navbar */
        .navbar-custom {
            background-color: white;
            padding: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-radius: 10px;
        }

        .profile {
            display: flex;
            align-items: center;
        }

        .profile a {
            margin-right: 15px;
            font-weight: 600;
            color: #343a40;
            text-decoration: none;
            transition: all 0.2s;
        }

        .profile a:hover {
            color: #2fd1cb;
        }

        .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            border: 2px solid #2fd1cb;
        }

        /* Table */
        .table-responsive {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.08);
        }

        .table thead {
            background-color: #162742;
            color: white;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        /* Buttons */
        .btn-primary {
            background-color: #2fd1cb;
            border-color: #2fd1cb;
            padding: 9px 18px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background-color: #25b5b0;
            border-color: #25b5b0;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(47, 209, 203, 0.3);
        }

        .btn-warning {
            background-color: #ffb74d;
            border-color: #ffb74d;
            padding: 9px 18px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .btn-warning:hover {
            background-color: #ffa726;
            border-color: #ffa726;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 183, 77, 0.3);
        }

        .btn-danger {
            background-color: #ef5350;
            border-color: #ef5350;
            padding: 9px 18px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .btn-danger:hover {
            background-color: #e53935;
            border-color: #e53935;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(239, 83, 80, 0.3);
        }

        /* Toggle button for responsive sidebar */
        .sidebar-toggle {
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 1100;
            background: #162742;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: none;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        /* Disabled links styling */
        .sidebar a.disabled {
            color: rgba(255, 255, 255, 0.4);
            pointer-events: none;
            opacity: 0.6;
            cursor: not-allowed;
        }

        .sidebar a.disabled i {
            color: rgba(47, 209, 203, 0.4);
        }

        /* For responsive design */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .content {
                margin-left: 0;
            }
            .sidebar-toggle {
                display: flex;
            }
            .content.sidebar-active {
                margin-left: 280px;
            }
        }
    </style>
    <body>
        <%
            // Ki?m tra session Username
            String username = (String) session.getAttribute("Username");
            boolean isAdmin = "admin".equals(username);
            
            // X?c ??nh URL Dashboard d?a tr?n role
            String dashboardUrl = isAdmin ? "HomeDashBoard_Admin.jsp" : "Top_selling";
        %>

        <!-- Toggle button for mobile -->
        <button class="sidebar-toggle" id="sidebarToggle">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Admin Portal</span>
                </div>
            </div>

            <div class="menu-category">Main Navigation</div>
            <a href="<%= dashboardUrl %>" class="active">
                <i class="fas fa-home"></i> Dashboard
            </a>

            <div class="menu-category">User Management</div>
            <a href="/ListAccountStaff" class="<%= !isAdmin ? "disabled" : "" %>">
                <i class="fas fa-user-tie"></i> Manage Staff
            </a>
            <a href="listAccountCustomer" class="<%= !isAdmin ? "disabled" : "" %>">
                <i class="fas fa-users"></i> Manage Customers
            </a>

            <div class="menu-category">Shop Management</div>
            <a href="listProductsForAdmin"class="<%= !isAdmin ? "disabled" : "" %>">
                <i class="fas fa-box"></i> Manage Products
            </a>
            <a href="listOrderAdmin">
                <i class="fas fa-shopping-cart"></i> Manage Orders
            </a>
            <a href="ListInventory"class="<%= !isAdmin ? "disabled" : "" %>">
                <i class="fas fa-warehouse"></i> Manage Inventory
            </a>

            <div class="menu-category">Business Insights</div>
            <a href="feedback">
                <i class="fas fa-comment-dots"></i> Customer Feedback
            </a>
            <a href="Revenue"class="<%= !isAdmin ? "disabled" : "" %>">
                <i class="fas fa-chart-line"></i> Revenue Analytics
            </a>

            <div class="menu-category">Account</div>
            <a href="viewProfileStaff" class="<%= isAdmin ? "disabled" : "" %>">
                <i class="fas fa-user-circle"></i> My Profile
            </a>
            <a href="javascript:void(0);" class="text-lg-startr fw-bold" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</a>                         
        </div>

        <!-- JavaScript for toggling sidebar on mobile -->
        <script>
            document.getElementById('sidebarToggle').addEventListener('click', function () {
                document.getElementById('sidebar').classList.toggle('active');
                document.querySelector('.content').classList.toggle('sidebar-active');                               
            });
            
            
        </script>
    </body>
</html>