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
        Integer productID = null;

        if (productIDStr != null) {
            try {
                productID = Integer.parseInt(productIDStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("ImportHistory"); // Nếu productID không hợp lệ, quay lại trang danh sách
                return;
            }
        }

        // Gọi hàm gộp
        List<Inventory> importHistory = inventoryDAO.getImportHistory(productID);
        request.setAttribute("importHistory", importHistory);

        // Chọn trang JSP phù hợp
        String targetPage = (productID != null) ? "view_import_detail.jsp" : "view_import_history.jsp";
        request.getRequestDispatcher(targetPage).forward(request, response);
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
