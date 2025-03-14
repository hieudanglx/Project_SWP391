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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import java.io.IOException;

@WebServlet("/ViewProfileOfCustomer")
public class ViewProfileOfCustomerController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy customerId từ session
        Integer customerId = (Integer) session.getAttribute("customerID");

        if (customerId == null) {
            // Chưa đăng nhập, chuyển hướng về trang đăng nhập
            response.sendRedirect("LoginOfDashboard.jsp");
            return;
        }

        // Lấy thông tin khách hàng từ database
        Customer customer = customerDAO.getCustomerById(customerId);
        System.out.println(customer.getFullName() + " " + customer.getCustomerID());
        if (customer != null) {
            session.setAttribute("customer", customer);
            session.setAttribute("avatarPath", customer.getImgCustomer());

        }

        // Chuyển hướng đến trang ViewProfileOfCustomer.jsp
        request.getRequestDispatcher("ViewProfieOfCustomer.jsp").forward(request, response);
    }
}
