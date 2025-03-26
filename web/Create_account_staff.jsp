<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Registration</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #34495e;
                --accent-color: #3498db;
            }
            body {
                background-color: #ecf0f1;
                font-family: 'Inter', 'Arial', sans-serif;
                line-height: 1.6;
            }
            .content {
                margin-left: 250px;
                padding: 15px;
                background-color: transparent;
            }
            .registration-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                padding: 25px;
                max-width: 550px;
                margin: 0 auto;
                border: 1px solid #e0e4e8;
            }
            .form-label {
                font-weight: 600;
                color: var(--secondary-color);
                font-size: 0.9rem;
                margin-bottom: 0.3rem;
            }
            .form-control, .form-select {
                border-radius: 6px;
                border-color: #dee2e6;
                padding: 0.475rem 0.75rem;
                font-size: 0.9rem;
            }
            .form-control:focus, .form-select:focus {
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
            }
            .btn-group {
                display: flex;
                gap: 10px;
            }
            .btn-success {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
                transition: all 0.3s ease;
            }
            .btn-success:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }
            .btn-secondary {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
            }
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border-radius: 6px;
                padding: 10px;
                margin-bottom: 15px;
                font-size: 0.9rem;
            }
            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
            }
            @media (max-width: 768px) {
                .content {
                    margin-left: 0;
                }
                .form-grid {
                    grid-template-columns: 1fr;
                }
            }
            h3 {
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 20px;
                font-weight: 700;
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="registration-container">
                <h3>Staff Registration</h3>

                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>

                <form action="CreateAccountStaff" method="POST">
                    <div class="form-grid">
                        <div class="mb-2">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName}" required>
                        </div>
                        <div class="mb-2">
                            <label for="cccd" class="form-label">CCCD</label>
                            <input type="text" class="form-control" id="cccd" name="cccd" value="${staff.cccd}" required>
                        </div>
                        <div class="mb-2">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" value="${username}" required>
                        </div>
                        <div class="mb-2">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                        </div>
                        <div class="mb-2">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${phoneNumber}" required>
                        </div>
                        <div class="mb-2">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address" value="${address}" required>
                        </div>
                        <div class="mb-2">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="mb-2">
                            <label for="province_city" class="form-label">Province/City</label>
                            <input type="text" class="form-control" id="province_city" name="province_city" value="${province_city}" required readonly>
                        </div>
                        <div class="mb-2">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="text" class="form-control" id="dob" name="dob" value="${dob}" required>
                        </div>
                        <div class="mb-2">
                            <label for="sex" class="form-label">Sex</label>
                            <select class="form-select" id="sex" name="sex" required readonly>
                                <option value="Male" ${sex == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${sex == 'Female' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-2">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="0" ${status == 0 ? 'selected' : ''}>Active</option>
                            <option value="1" ${status == 1 ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>

                    <div class="btn-group mt-3">
                        <button type="submit" class="btn btn-success flex-grow-1">Register</button>
                        <a href="ListAccountStaff" class="btn btn-secondary flex-grow-1">Back</a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Previous JavaScript remains the same as in the original file
            document.addEventListener("DOMContentLoaded", function () {
                let cccdInput = document.getElementById("cccd");
                if (cccdInput) {
                    cccdInput.addEventListener("input", autoFillCCCD);
                }
            });

            function autoFillCCCD() {
                let cccd = document.getElementById("cccd").value;
                let provinceCity = document.getElementById("province_city");
                let dob = document.getElementById("dob");
                let sex = document.getElementById("sex");

                let provinces = {
                    "001": "Hà Nội", "002": "Hà Giang", "004": "Cao Bằng", "006": "Bắc Kạn", "008": "Tuyên Quang",
                    "010": "Lào Cai", "011": "Điện Biên", "012": "Lai Châu", "014": "Sơn La", "015": "Yên Bái",
                    "017": "Hòa Bình", "019": "Thái Nguyên", "020": "Lạng Sơn", "022": "Quảng Ninh", "024": "Bắc Giang",
                    "025": "Phú Thọ", "026": "Vĩnh Phúc", "027": "Bắc Ninh", "030": "Hải Dương", "031": "Hải Phòng",
                    "033": "Hưng Yên", "034": "Thái Bình", "035": "Hà Nam", "036": "Nam Định", "037": "Ninh Bình",
                    "038": "Thanh Hóa", "040": "Nghệ An", "042": "Hà Tĩnh", "044": "Quảng Bình", "045": "Quảng Trị",
                    "046": "Thừa Thiên Huế", "048": "Đà Nẵng", "049": "Quảng Nam", "051": "Quảng Ngãi", "052": "Bình Định",
                    "054": "Phú Yên", "056": "Khánh Hòa", "058": "Ninh Thuận", "060": "Bình Thuận", "062": "Kon Tum",
                    "064": "Gia Lai", "066": "Đắk Lắk", "067": "Đắk Nông", "068": "Lâm Đồng", "070": "Bình Phước",
                    "072": "Tây Ninh", "074": "Bình Dương", "075": "Đồng Nai", "077": "Bà Rịa - Vũng Tàu", "079": "Hồ Chí Minh",
                    "080": "Long An", "082": "Tiền Giang", "083": "Bến Tre", "084": "Trà Vinh", "086": "Vĩnh Long",
                    "087": "Đồng Tháp", "089": "An Giang", "091": "Kiên Giang", "092": "Cần Thơ", "093": "Hậu Giang",
                    "094": "Sóc Trăng", "095": "Bạc Liêu", "096": "Cà Mau"
                };

                if (cccd.length === 12) {
                    let provinceCode = cccd.substring(0, 3);
                    let genderCode = parseInt(cccd.charAt(3));
                    let birthYear = parseInt(cccd.substring(4, 6));

                    // Xác định tỉnh/thành phố
                    provinceCity.value = provinces[provinceCode] || "Mã tỉnh không hợp lệ";

                    // Xác định năm sinh
                    let fullYear;
                    if (genderCode === 0 || genderCode === 1) {
                        fullYear = 1900 + birthYear;
                    } else if (genderCode === 2 || genderCode === 3) {
                        fullYear = 2000 + birthYear;
                    } else {
                        dob.value = "";
                        alert("Mã giới tính không hợp lệ!");
                        return;
                    }
                    dob.value = fullYear.toString().padStart(4, '0') + "-01-01";

                    // Xác định giới tính
                    if (genderCode % 2 === 0) {
                        sex.value = "Male"; // Nam
                    } else {
                        sex.value = "Female"; // Nữ
                    }
                } else {
                    provinceCity.value = "";
                    dob.value = "";
                    sex.value = "";
                }
            }
        </script>
    </body>
</html>