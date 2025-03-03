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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = 1; // Bạn có thể lấy ID từ session hoặc request nếu cần
        Customer customer = customerDAO.getCustomerById(customerId);

        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
        }

        request.getRequestDispatcher("ViewProfileOfCustomer.jsp").forward(request, response);
    }
}
