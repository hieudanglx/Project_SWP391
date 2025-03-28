/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.AccountDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.AccountStaff;
import model.EmailSenderStaff;
import model.OTPGenerate;

/**
 *
 * @author nguye
 */
@WebServlet(name = "changePasswordStaff", urlPatterns = {"/changePasswordStaff"})
public class ChangePasswordOfStaffController extends HttpServlet {

    private final AccountDao accountDao = new AccountDao(); // Khởi tạo AccountDao

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        currentPassword = accountDao.hashPassword(currentPassword);
        // Kiểm tra nếu thiếu email
        if (email == null || email.isEmpty()) {
            request.setAttribute("errorMessage", "Bạn chưa nhập email!");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin nhân viên theo email
        AccountStaff staff = accountDao.getStaffByEmail(email);

        if (staff == null) {
            request.setAttribute("errorMessage", "Tài khoản không tồn tại!");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu hiện tại
        if (!staff.getPassword().equals(currentPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu mới
        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
            return;
        }

        // Kiểm tra nếu mật khẩu mới trùng với mật khẩu cũ
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
            return;
        }

        // Nếu mọi thứ hợp lệ, gửi OTP qua email
        String otp = OTPGenerate.generateOTP();
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);
        session.setAttribute("tempPassword", newPassword);

        // Gửi email chứa OTP cho nhân viên
        EmailSenderStaff.sendEmail(email, "Mã OTP đặt lại mật khẩu",
                "Mã OTP của bạn là: " + otp + "\nVui lòng nhập OTP này để tiếp tục.");

        // Chuyển hướng đến trang nhập OTP để xác nhận
        request.getRequestDispatcher("verifyOTPChangeStaff.jsp").forward(request, response);
    }
}
