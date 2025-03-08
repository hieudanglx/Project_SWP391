/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author nguye
 */
@WebServlet(name = "verifyOTPChangeStaffController", urlPatterns = {"/verifyOTPChangeStaffController"})
public class verifyOTPChangeStaffController extends HttpServlet {

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
            out.println("<title>Servlet verifyOTPChangePCController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet verifyOTPChangePCController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        String enteredOTP = request.getParameter("otp");
        String correctOTP = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");
        String newPassword = (String) session.getAttribute("tempPassword");

        // Kiểm tra nếu OTP, email hoặc mật khẩu mới bị mất trong session
        if (correctOTP == null || email == null || newPassword == null) {
            request.setAttribute("errorMessage", "OTP đã hết hạn. Vui lòng thử lại!");
            request.getRequestDispatcher("verifyOTPChangeStaff.jsp").forward(request, response);
            return;
        }

        // Kiểm tra OTP có khớp không
        if (!enteredOTP.equals(correctOTP)) {
            request.setAttribute("errorMessage", "Mã OTP không đúng!");
            request.getRequestDispatcher("verifyOTPChangeStaff.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu vào CSDL
        AccountDao accountDao = new AccountDao();
        boolean isUpdated = accountDao.updateStaffPassword(email, newPassword);

        if (!isUpdated) {
            request.setAttribute("errorMessage", "Cập nhật mật khẩu thất bại!");
            request.getRequestDispatcher("verifyOTPChangeStaff.jsp").forward(request, response);
            return;
        }

        // Xóa dữ liệu OTP khỏi session
        session.removeAttribute("otp");
        session.removeAttribute("tempPassword");

        // Chuyển hướng đến trang đăng nhập nhân viên
        response.sendRedirect("LoginOfDashboard.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý xác minh OTP và đổi mật khẩu của nhân viên";
    }
}
