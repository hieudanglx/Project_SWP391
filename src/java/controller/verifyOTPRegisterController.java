/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author nguye
 */
@WebServlet(name = "verifyOTPRegisterController", urlPatterns = {"/verifyOTPRegisterController"})
public class verifyOTPRegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String enteredOTP = request.getParameter("otp");
        String correctOTP = (String) session.getAttribute("otp");

        Customer newCustomer = (Customer) session.getAttribute("newCustomer");

        if (!enteredOTP.equals(correctOTP)) {
            request.setAttribute("errorMessage", "Mã OTP không đúng!");
            request.getRequestDispatcher("verifyOTPRegister.jsp").forward(request, response);
            return;
        }

        CustomerDAO cusDAO = new CustomerDAO();
        cusDAO.addCustomer(newCustomer);

        // Đăng ký thành công
        request.setAttribute("successMessage", "Đăng ký thành công! Bây giờ bạn có thể đăng nhập.");
        request.getRequestDispatcher("loginOfCustomer.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Servlet for verifying OTP during registration";
    }
}
