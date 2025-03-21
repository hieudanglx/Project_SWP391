/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
@WebServlet(name = "resetPasswordOfCustomerController", urlPatterns = {"/resetPasswordOfCustomerController"})
public class resetPasswordOfCustomerController extends HttpServlet {

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
            out.println("<title>Servlet resetPasswordOfCustomerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet resetPasswordOfCustomerController at " + request.getContextPath() + "</h1>");
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
        CustomerDAO cusDAO = new CustomerDAO();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            request.setAttribute("errorMessage", "Phiên đặt lại mật khẩu đã hết hạn. Vui lòng thử lại!");
            request.getRequestDispatcher("forgotPasswordOfCustomer.jsp").forward(request, response);
            return;
        }

        // Nhận mật khẩu mới từ form
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Regex kiểm tra mật khẩu: 8-16 ký tự, ít nhất 1 chữ hoa, 1 số
        String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,16}$";

        // Kiểm tra mật khẩu có hợp lệ không
        if (!newPassword.matches(passwordPattern)) {
            request.setAttribute("errorMessage", "Mật khẩu phải có 8-16 ký tự, ít nhất 1 chữ hoa và 1 số!");
            request.getRequestDispatcher("resetPasswordOfCustomer.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("resetPasswordOfCustomer.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu trong cơ sở dữ liệu
        boolean isUpdated = cusDAO.updatePassword(email, newPassword);

        if (isUpdated) {
            session.removeAttribute("email"); // Xóa email khỏi session sau khi đặt lại mật khẩu
            session.setAttribute("successMessage", "Mật khẩu đã được đặt lại thành công!");
            response.sendRedirect("loginOfCustomer.jsp");
        } else {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi đặt lại mật khẩu. Vui lòng thử lại!");
            request.getRequestDispatcher("resetPasswordOfCustomer.jsp").forward(request, response);
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
