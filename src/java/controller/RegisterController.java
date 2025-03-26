/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author nguye
 */
import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import jakarta.servlet.annotation.WebServlet;
import java.util.Date;

/**
 * Servlet xử lý đăng ký khách hàng mới
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username").trim();
            String fullName = request.getParameter("fullName").trim();
            String email = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();
            String address = request.getParameter("address").trim();
            String phoneNumber = request.getParameter("phoneNumber").trim();
            String sex = request.getParameter("sex").trim();
            String dob = request.getParameter("dob").trim();

            // Kiểm tra dữ liệu đầu vào
            if (username.isEmpty() || phoneNumber.isEmpty() || email.isEmpty() || password.isEmpty() || address.isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();

            if (customerDAO.isUsernameExisted(username)) {
                request.setAttribute("errorMessage", "Tên người dùng đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (customerDAO.isPhoneExisted(phoneNumber)) {
                request.setAttribute("errorMessage", "Số điện thoại đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (customerDAO.isEmailExisted(email)) {
                request.setAttribute("errorMessage", "Email đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            Customer newCustomer = new Customer(username, fullName, email, password, address, phoneNumber, sex, dob, null, null);
            customerDAO.add(newCustomer);

            // Đăng ký thành công
            request.setAttribute("successMessage", "Đăng ký thành công! Bây giờ bạn có thể đăng nhập.");
            request.getRequestDispatcher("loginOfCustomer.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
