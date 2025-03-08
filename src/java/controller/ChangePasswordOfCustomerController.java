/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.EmailSenderStaff;
import model.OTPGenerate;

import java.io.IOException;
import model.EmailSenderCustomer;

/**
 *
 * @author nguye
 */
@WebServlet(name = "ChangePasswordOfCustomer", urlPatterns = {"/ChangePasswordOfCustomer"})
public class ChangePasswordOfCustomerController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // Kiểm tra nếu thiếu email (không đăng nhập)
        if (email == null || email.isEmpty()) {
            request.setAttribute("errorMessage", "Bạn chưa nhập email!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByEmail(email);

        if (customer == null) {
            request.setAttribute("errorMessage", "Tài khoản không tồn tại!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        if (!customer.getPassword().equals(currentPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        if (currentPassword.equals(newPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        // Nếu mọi thứ hợp lệ, gửi OTP qua email
        String otp = OTPGenerate.generateOTP();
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);
        session.setAttribute("tempPassword", newPassword);

        EmailSenderCustomer.sendEmail(email, "Mã OTP đặt lại mật khẩu",
                "Mã OTP của bạn là: " + otp + "\nVui lòng nhập OTP này để tiếp tục.");

        request.getRequestDispatcher("verifyOTPChangePC.jsp").forward(request, response);
    }
}
