/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
public class CreateAccountStaff extends HttpServlet {

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
            out.println("<title>Servlet CreateAccountStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateAccountStaff at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String fullName = request.getParameter("fullName");
    String username = request.getParameter("username");
    String password = request.getParameter("password"); // Cân nhắc mã hóa
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phoneNumber");
    String address = request.getParameter("address");
    String cccd = request.getParameter("cccd");

    int status = Integer.parseInt(request.getParameter("status"));
    boolean statusBoolean = (status == 1);

    AccountDao staffDAO = new AccountDao();
    
    // Kiểm tra trùng lặp
    String errorMessage = null;
    if (staffDAO.isUsernameStaffExists(username)) {
        errorMessage = "Lỗi: Tên đăng nhập đã tồn tại!";
    } else if (staffDAO.isEmailStaffExists(email)) {
        errorMessage = "Lỗi: Email đã tồn tại!";
    } else if (staffDAO.isPhoneNumberStaffExists(phoneNumber)) {
        errorMessage = "Lỗi: Số điện thoại đã tồn tại!";
    } else if (staffDAO.isCCCDExists(cccd)) {
        errorMessage = "Lỗi: CCCD đã tồn tại!";
    }

    if (errorMessage != null) {
        request.setAttribute("errorMessage", errorMessage);

        // Giữ lại dữ liệu nhập trên form
        request.setAttribute("fullName", fullName);
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("address", address);
        request.setAttribute("cccd", cccd);
        request.setAttribute("status", status);

        request.getRequestDispatcher("Create_account_staff.jsp").forward(request, response);
        return;
    }

    // Thêm nhân viên vào database
    boolean success = staffDAO.addStaff(fullName, username, password, email, phoneNumber, address,cccd, statusBoolean);
    if (success) {
        response.sendRedirect("ListAccountStaff");
    } else {
        request.setAttribute("errorMessage", "Thêm nhân viên thất bại!");
        request.setAttribute("fullName", fullName);
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("address", address);
        request.setAttribute("cccd", cccd);
        request.setAttribute("status", status);

        request.getRequestDispatcher("Create_account_staff.jsp").forward(request, response);
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
