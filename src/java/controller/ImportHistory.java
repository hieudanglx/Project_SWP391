/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.InventoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Inventory;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
@WebServlet("/importHistory")
public class ImportHistory extends HttpServlet {
   private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO;

    @Override
    public void init() {
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIDStr = request.getParameter("productID");

        if (productIDStr != null) { // Lấy lịch sử nhập của một sản phẩm cụ thể
            try {
                int productID = Integer.parseInt(productIDStr);
                List<Inventory> importHistory = inventoryDAO.getImportHistoryByProductID(productID);
                request.setAttribute("importHistory", importHistory);
                request.getRequestDispatcher("view_import_detail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect("ImportHistory"); // Nếu productID không hợp lệ, quay lại trang danh sách
            }
        } else { // Hiển thị toàn bộ lịch sử nhập hàng
            List<Inventory> importHistory = inventoryDAO.getAllImportHistory();
            request.setAttribute("importHistory", importHistory);
            request.getRequestDispatcher("view_import_history.jsp").forward(request, response);
        }
    }


    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
