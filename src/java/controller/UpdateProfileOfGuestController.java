package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/UpdateProfile")
public class UpdateProfileOfGuestController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer existingCustomer = (Customer) session.getAttribute("customer");

        if (existingCustomer != null) {
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String dobString = request.getParameter("dob"); // Nhận giá trị từ form
            String sexInput = request.getParameter("sex");  // Lấy giới tính từ form

            // Chuyển đổi từ String sang java.sql.Date
            Date dob = null;
            try {
                if (dobString != null && !dobString.isEmpty()) {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date parsedDate = format.parse(dobString);
                    dob = new java.sql.Date(parsedDate.getTime());
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }

            // Kiểm tra giá trị hợp lệ của sex
            String sex = "Other"; // Giá trị mặc định nếu không hợp lệ
            if ("Male".equalsIgnoreCase(sexInput) || "Female".equalsIgnoreCase(sexInput) || "Other".equalsIgnoreCase(sexInput)) {
                sex = sexInput;
            }

            // Cập nhật thông tin khách hàng
            existingCustomer.setFullName(fullName);
            existingCustomer.setEmail(email);
            existingCustomer.setPhoneNumber(phoneNumber);
            existingCustomer.setAddress(address);
            existingCustomer.setDob(dob + "");
            existingCustomer.setSex(sex); // Gán sex đã kiểm tra

            // Cập nhật vào DB
            customerDAO.updateCustomer(existingCustomer, false);

            // Cập nhật session
            session.setAttribute("customer", existingCustomer);
            session.setAttribute("updateSuccess", "Profile updated successfully!");
        }

        response.sendRedirect("ViewProfileOfCustomer");
    }
}
