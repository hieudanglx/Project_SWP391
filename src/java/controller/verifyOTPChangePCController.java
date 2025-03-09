/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
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
@WebServlet(name = "verifyOTPChangePCController", urlPatterns = {"/verifyOTPChangePCController"})
public class verifyOTPChangePCController extends HttpServlet {

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

        if (correctOTP == null || email == null || newPassword == null) {
            request.setAttribute("errorMessage", "OTP đã hết hạn. Vui lòng thử lại!");
            request.getRequestDispatcher("verifyOTPChangePC.jsp").forward(request, response);
            return;
        }

        if (!enteredOTP.equals(correctOTP)) {
            request.setAttribute("errorMessage", "Mã OTP không đúng!");
            request.getRequestDispatcher("verifyOTPChangePC.jsp").forward(request, response);
            return;
        }
        CustomerDAO cusDAO = new CustomerDAO();
        // Cập nhật mật khẩu vào DB
        boolean isUpdated = cusDAO.updatePassword(email, newPassword);
        if (!isUpdated) {
            request.setAttribute("errorMessage", "Cập nhật mật khẩu thất bại!");
            request.getRequestDispatcher("verifyOTPChangePC.jsp").forward(request, response);
            return;
        }

        // Xóa dữ liệu OTP khỏi session
        session.removeAttribute("otp");
        session.removeAttribute("tempPassword");

        // Chuyển về trang Profile
        response.sendRedirect("loginOfCustomer.jsp");
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
