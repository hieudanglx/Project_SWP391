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
            
            .content {
                margin-left: 250px;
                padding: 20px;
                background-color: #f0f2f5;
            }
            .content {
                    margin-left: 0;
                }
                /* Main Content Styles - ENHANCED */
            .main-content {
                flex: 1;
                padding: 30px 20px;
                display: flex;
                justify-content: center;
            }
            .card {
                width: 450px;
                max-height: 80vh;
                overflow-y: auto;
                scrollbar-width: none; /* Ẩn scrollbar trên Firefox */
                -ms-overflow-style: none; /* Ẩn scrollbar trên Internet Explorer */
            }
            .card::-webkit-scrollbar {
                display: none; /* Ẩn scrollbar trên Chrome, Safari */
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        <div class="content">
        <div class="main-content">
            <h3 class="text-center mb-3">Staff Registration</h3>

            <c:if test="${not empty errorMessage}">
                <p class="alert alert-danger">${errorMessage}</p>
            </c:if>

            <form action="CreateAccountStaff" method="POST">
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
                    <input type="text" class="form-control" id="dob" name="dob" value="${dob}" required >
                </div>
                <div class="mb-2">
                    <label for="sex" class="form-label">Sex</label>
                    <select class="form-select" id="sex" name="sex" required readonly>
                        <option value="Male" ${sex == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${sex == 'Female' ? 'selected' : ''}>Female</option>
                    </select>
                </div>
                <div class="mb-2">
                    <label for="status" class="form-label">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="0" ${status == 0 ? 'selected' : ''}>Active</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between mt-3">
                    <button type="submit" class="btn btn-success flex-grow-1 me-2">Register</button>
                    <a href="ListAccountStaff" class="btn btn-secondary flex-grow-1">Back</a>
                </div>
            </form>
        </div>
</div>
        <script>
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
