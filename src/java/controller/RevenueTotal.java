/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
@WebServlet("/RevenueTotal")
public class RevenueTotal extends HttpServlet {

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
            out.println("<title>Servlet RevenueTotal</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueTotal at " + request.getContextPath() + "</h1>");
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
        OrderDAO dao = new OrderDAO();

        // Lấy tổng doanh thu
        double totalSales = dao.getTotalSales();
        System.out.println("[DEBUG] Tổng doanh thu lấy từ DB: " + totalSales);

        // Format số với dấu phẩy
        DecimalFormat df = new DecimalFormat("#,###");
        String formattedSales = df.format(totalSales);

        System.out.println("[DEBUG] Tổng doanh thu sau khi format: " + formattedSales);

// Gửi dữ liệu sang JSP
        request.setAttribute("totalSales", totalSales);
        request.getRequestDispatcher("HomeDashBoard_Admin.jsp").forward(request, response);
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
        processRequest(request, response);
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

    public static void main(String[] args) {
        // Khởi tạo DAO
        OrderDAO dao = new OrderDAO();

        // Gọi phương thức getTotalSales() để lấy tổng doanh thu
        double totalSales = dao.getTotalSales();

        // Kiểm tra giá trị lấy từ DB
        System.out.println("[TEST] Tổng doanh thu lấy từ DB: " + totalSales);

        // Format số theo dạng có dấu phẩy ngăn cách
        DecimalFormat df = new DecimalFormat("#,###");
        String formattedSales = df.format(totalSales);

        // In kết quả sau khi format
        System.out.println("[TEST] Tổng doanh thu sau khi format: " + formattedSales);
    }
}
