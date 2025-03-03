
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

@WebServlet("/UpdateProfile")
public class UpdateProfileOfGuestController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = 1; // Hard-code ID để test

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        HttpSession session = request.getSession();

        Customer existingCustomer = (Customer) session.getAttribute("customer");

        if (existingCustomer != null) {
            existingCustomer.setUsername(username);
            existingCustomer.setEmail(email);
            existingCustomer.setPhoneNumber(phoneNumber);
            existingCustomer.setAddress(address);

            customerDAO.updateCustomer(existingCustomer, false);
            
            // Lưu thông báo vào session
            session.setAttribute("updateSuccess", "Profile updated successfully!");
        }

        response.sendRedirect("ViewProfileOfCustomer");
    }
}
