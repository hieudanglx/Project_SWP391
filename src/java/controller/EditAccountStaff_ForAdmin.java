/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AccountStaff;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
@WebServlet(name = "EditAccountStaff_ForAdmin", urlPatterns = {"/EditAccountStaff_ForAdmin"})
public class EditAccountStaff_ForAdmin extends HttpServlet {

    private AccountDao accountDao;

    public void init() {
        accountDao = new AccountDao();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

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
        int staffID = Integer.parseInt(request.getParameter("staffID"));
        AccountDao accountDao = new AccountDao();
        AccountStaff staff = accountDao.getAccountStaffByID(staffID); // Giả sử bạn có phương thức này trong DAO
        request.setAttribute("staff", staff);
        request.getRequestDispatcher("EditStaff.jsp").forward(request, response);
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
        int staffID = Integer.parseInt(request.getParameter("staffID"));
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String username = request.getParameter("username");
        int status = Integer.parseInt(request.getParameter("status"));
        String province_city = request.getParameter("province_city");
        String cccd= request.getParameter("cccd");
        String dob = request.getParameter("dob"); // Ngày sinh lấy dưới dạng chuỗi YYYY-MM-DD
        String sex = request.getParameter("sex");

// Cập nhật đối tượng AccountStaff
        AccountStaff staff = new AccountStaff(staffID, address, email,  password, fullName,  phoneNumber,  username, cccd,  sex, dob, province_city, status);

// Gọi DAO để cập nhật
        boolean isUpdated = accountDao.updateAccountStaff_ForAdmin(staff);
        if (isUpdated) {
            response.sendRedirect("ListAccountStaff"); // Chuyển hướng về trang danh sách staff sau khi cập nhật thành công
        } else {
            request.setAttribute("error", "Failed to update staff member"); // Đặt thông báo lỗi
            request.getRequestDispatcher("error.jsp").forward(request, response); // Chuyển hướng về trang cập nhật với thông báo lỗi
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
