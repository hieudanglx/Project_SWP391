package controller;

import dao.AccountDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CreateAccountStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // Cân nhắc mã hóa mật khẩu
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String cccd = request.getParameter("cccd");
        String province = request.getParameter("province_city");
        String dob = request.getParameter("dob");
        String sex = request.getParameter("sex");
        
        // Xử lý trạng thái (tránh lỗi nếu giá trị null)
        String statusParam = request.getParameter("status");
        boolean statusBoolean = (statusParam != null && statusParam.equals("1"));

        // Kiểm tra trùng lặp
        AccountDao staffDAO = new AccountDao();
        String errorMessage = null;

        if (staffDAO.isUsernameStaffExists(username)) {
            errorMessage = "Lỗi: Tên đăng nhập đã tồn tại!";
        } else if (staffDAO.isEmailStaffExists(email)) {
            errorMessage = "Lỗi: Email đã tồn tại!";
        } else if (staffDAO.isPhoneNumberStaffExists(phoneNumber)) {
            errorMessage = "Lỗi: Số điện thoại đã tồn tại!";
        } else if (staffDAO.isCCCDExists(cccd)) {
            errorMessage = "Lỗi: CCCD đã tồn tại!";
        }

        // Nếu có lỗi, trả về trang nhập với thông báo lỗi
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("address", address);
            request.setAttribute("cccd", cccd);
            request.setAttribute("province_city", province);
            request.setAttribute("dob", dob);
            request.setAttribute("sex", sex);
            request.setAttribute("status", statusParam);

            request.getRequestDispatcher("Create_account_staff.jsp").forward(request, response);
            return;
        }

        // Thêm nhân viên vào database
        boolean success = staffDAO.addStaff(fullName, username, password, email, phoneNumber, address, cccd, province, dob, sex, statusBoolean);
        if (success) {
            response.sendRedirect("ListAccountStaff");
        } else {
            request.setAttribute("errorMessage", "Thêm nhân viên thất bại!");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("address", address);
            request.setAttribute("cccd", cccd);
            request.setAttribute("province_city", province);
            request.setAttribute("dob", dob);
            request.setAttribute("sex", sex);
            request.setAttribute("status", statusParam);

            request.getRequestDispatcher("Create_account_staff.jsp").forward(request, response);
        }
    }
}