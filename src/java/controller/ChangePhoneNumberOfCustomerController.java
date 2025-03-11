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
import java.io.IOException;
import model.Customer;
import model.EmailSenderCustomer;
import model.OTPGenerate;

/**
 *
 * @author nguye
 */
@WebServlet(name = "ChangePhoneNumberOfCustomer", urlPatterns = {"/ChangePhoneNumberOfCustomer"})
public class ChangePhoneNumberOfCustomerController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String currentPhoneNumber = request.getParameter("currentPhoneNumber");
        String newPhoneNumber = request.getParameter("newPhoneNumber");

        // Kiểm tra nếu thiếu thông tin
        if (email == null || currentPhoneNumber == null || newPhoneNumber == null
                || email.isEmpty() || currentPhoneNumber.isEmpty() || newPhoneNumber.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
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

        if (!customer.getPhoneNumber().equals(currentPhoneNumber)) {
            request.setAttribute("errorMessage", "Số điện thoại hiện tại không đúng!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        if (currentPhoneNumber.equals(newPhoneNumber)) {
            request.setAttribute("errorMessage", "Số điện thoại mới không được trùng với số cũ!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
            return;
        }

        // Gửi OTP qua email
        String otp = OTPGenerate.generateOTP();
        long otpExpiryTime = System.currentTimeMillis() + 5 * 60 * 1000; // OTP hết hạn sau 5 phút

        session.setAttribute("otp", otp);
        session.setAttribute("otpExpiry", otpExpiryTime);
        session.setAttribute("email", email);
        session.setAttribute("tempPhoneNumber", newPhoneNumber);

        EmailSenderCustomer.sendEmail(email, "Mã OTP thay đổi số điện thoại",
                "Mã OTP của bạn là: " + otp + "\nVui lòng nhập OTP này trong vòng 5 phút để tiếp tục.");

        request.getRequestDispatcher("verifyOTPChangePhone.jsp").forward(request, response);
    }
}
