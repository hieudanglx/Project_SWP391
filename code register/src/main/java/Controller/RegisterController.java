/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

/**
 *
 * @author nguye
 */
import DAOs.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.Customer;
import jakarta.servlet.annotation.WebServlet;

/**
 * Servlet xử lý đăng ký khách hàng mới
 */
@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Nhận dữ liệu từ form
            String username = request.getParameter("username").trim();
            String phoneNumber = request.getParameter("phoneNumber").trim();
            String email = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();
            String address = request.getParameter("address").trim();

            // Kiểm tra dữ liệu đầu vào
            if (username.isEmpty() || phoneNumber.isEmpty() || email.isEmpty() || password.isEmpty() || address.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"message\":\"All fields are required!\"}");
                return;
            }

            // Kiểm tra số điện thoại và email đã tồn tại chưa
            CustomerDAO customerDAO = new CustomerDAO();
            if (customerDAO.isPhoneExisted(phoneNumber)) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                out.print("{\"message\":\"Phone number already exists!\"}");
                return;
            }

            if (customerDAO.isEmailExisted(email)) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                out.print("{\"message\":\"Email already exists!\"}");
                return;
            }

            // Tạo khách hàng mới (Không có status và imgCustomer)
            Customer newCustomer = new Customer(username, email, password, address, phoneNumber, null, null);
            customerDAO.add(newCustomer);

            // Trả về phản hồi thành công
            response.setStatus(HttpServletResponse.SC_OK);
            out.print("{\"message\":\"Registration successful!\"}");
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"message\":\"An error occurred: " + e.getMessage() + "\"}");
            e.printStackTrace();
        }

    }
}