/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
 * @author TRAN NHU Y - CE182032
 */
@WebServlet(name = "verifyOTPController", urlPatterns = {"/verifyOTPController"})
public class verifyOTPController extends HttpServlet {

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
            out.println("<title>Servlet verifyOTPController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet verifyOTPController at " + request.getContextPath() + "</h1>");
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

        // Lấy OTP nhập từ form
        String enteredOTP = request.getParameter("otp");

        // Lấy OTP đúng từ session (luôn ở dạng String)
        String correctOTP = (String) session.getAttribute("otp");

        // Lấy thời gian OTP được gửi từ session
        Long otpTime = (Long) session.getAttribute("otpTime");
        int otpExpiryTime =  30 * 1000; // 30 x 1000 ms)

        // Kiểm tra nếu không có OTP hoặc OTP đã hết hạn
        if (correctOTP == null || otpTime == null || (System.currentTimeMillis() - otpTime > otpExpiryTime)) {
            session.removeAttribute("otp");  // Xóa OTP khỏi session
            session.removeAttribute("otpTime");
            request.setAttribute("errorMessage", "OTP đã hết hạn. Vui lòng yêu cầu lại.");
            request.getRequestDispatcher("forgotPasswordOfCustomer.jsp").forward(request, response);
            return;
        }

        // So sánh OTP dưới dạng chuỗi
        if (enteredOTP.equals(correctOTP)) {
            request.getRequestDispatcher("resetPasswordOfCustomer.jsp").forward(request, response); // Chuyển đến trang đặt lại mật khẩu
        } else {
            request.setAttribute("errorMessage", "Mã OTP không đúng!");
            request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
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
