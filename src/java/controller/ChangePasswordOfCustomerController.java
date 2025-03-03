/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.EmailSender;
import model.OTPGenerate;

import java.io.IOException;

/**
 *
 * @author nguye
 */
public class ChangePasswordOfCustomerController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByEmail(email);

        if (customer == null || !customer.getPassword().equals(oldPassword)) {
            request.setAttribute("error", "Email hoặc mật khẩu cũ không chính xác!");
            request.getRequestDispatcher("changePasswordOfCustomer.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.getRequestDispatcher("changePasswordOfCustomer.jsp").forward(request, response);
            return;
        }

        // Tạo mã OTP và lưu vào database
        String otpCode = OTPGenerate.generateOTP();
        customerDAO.saveResetToken(email, otpCode);

        // Gửi OTP qua email
        EmailSender.sendEmail(email, "Mã xác nhận đổi mật khẩu", "Mã xác nhận của bạn là: " + otpCode);

        // Chuyển hướng sang trang nhập OTP
        request.setAttribute("email", email);
        request.setAttribute("newPassword", newPassword);
        request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
    }
}
