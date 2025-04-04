/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDao;
import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.Product;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
@WebServlet(name = "loginOfCustomer", urlPatterns = {"/loginOfCustomer"})
public class loginOfCustomerController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginOfCustomerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginOfCustomerController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        CustomerDAO cusDAO = new CustomerDAO();
        CartDao link = new CartDao();
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        // Kiểm tra ussername password rỗng hoặc null
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tên người dùng và mật khẩu không được để trống!");
            request.getRequestDispatcher("loginOfCustomer.jsp").forward(request, response);
            return;
        }

        try {
            Integer status = cusDAO.ValidateStatusCustomer(username, password);

            if (status != null) {
                if (status == 0) { // Tài khoản hợp lệ & không bị chặn
                    HttpSession session = request.getSession();
                    Customer customer = cusDAO.getCustomer(username, password);
                    session.setAttribute("size", link.getTotalItems(customer.getCustomerID()));
                    session.setAttribute("total", link.getTotalCartValue(customer.getCustomerID()));
                    session.setAttribute("customer", customer);
                    session.setAttribute("customerID", customer.getCustomerID());

                    request.getRequestDispatcher("homeController?CategoryID=2").forward(request, response);

                } else if (status == 1) { // Tài khoản bị chặn
                    request.setAttribute("errorMessage", "Tài khoản của bạn đã bị chặn. Vui lòng liên hệ với quản trị viên!");
                    request.getRequestDispatcher("loginOfCustomer.jsp").forward(request, response);
                }
            } else {
                // Nếu không có tài khoản nào khớp với tên người dùng và mật khẩu
                request.setAttribute("errorMessage", "Tên người dùng hoặc mật khẩu không hợp lệ!");
                request.getRequestDispatcher("loginOfCustomer.jsp").forward(request, response);
            }
        } catch (ServletException | IOException | SQLException e) {
            request.setAttribute("errorMessage", "Lỗi máy chủ nội bộ. Vui lòng thử lại sau." +e.getMessage());
            request.getRequestDispatcher("loginOfCustomer.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
