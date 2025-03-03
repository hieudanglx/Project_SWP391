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

/**
 *
 * @author nguye
 */
@WebServlet(name = "ChangePasswordStaffController", urlPatterns = {"/changePasswordStaff"})
public class ChangePasswordOfStaffController extends HttpServlet {
    
    private final AccountDao accountDao = new AccountDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("sendOTP".equals(action)) {
            String email = request.getParameter("email");
            AccountStaff staff = accountDao.getAccountStaffByEmail(email);

            if (staff == null) {
                request.setAttribute("error", "Email không tồn tại!");
                request.getRequestDispatcher("changePasswordStaff.jsp").forward(request, response);
                return;
            }

            String otp = accountDao.sendStaffOTP(email);
            session.setAttribute("otp", otp);
            session.setAttribute("staffEmail", email);
            request.setAttribute("message", "OTP đã được gửi đến email của bạn.");
            request.getRequestDispatcher("verifyOTPStaff.jsp").forward(request, response);

        } else if ("verifyOTP".equals(action)) {
            int enteredOTP = Integer.parseInt(request.getParameter("otp"));
            int sessionOTP = (int) session.getAttribute("otp");

            if (enteredOTP == sessionOTP) {
                request.getRequestDispatcher("newPasswordStaff.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "OTP không đúng!");
                request.getRequestDispatcher("verifyOTPStaff.jsp").forward(request, response);
            }

        } else if ("changePassword".equals(action)) {
            String newPassword = request.getParameter("newPassword");
            String email = (String) session.getAttribute("staffEmail");

            if (accountDao.updateStaffPassword(email, newPassword)) {
                request.setAttribute("message", "Mật khẩu đã được cập nhật thành công!");
                session.invalidate(); // Xóa session sau khi đổi mật khẩu
                request.getRequestDispatcher("loginStaff.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Cập nhật mật khẩu thất bại!");
                request.getRequestDispatcher("newPasswordStaff.jsp").forward(request, response);
            }
        }
    }
}
