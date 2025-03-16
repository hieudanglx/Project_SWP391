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
@WebServlet(name = "SearchInventory", urlPatterns = {"/SearchInventory"})
public class SearchInventory extends HttpServlet {

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
            out.println("<title>Servlet SearchInventory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchInventory at " + request.getContextPath() + "</h1>");
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
        InventoryDAO inventoryDAO = new InventoryDAO();
        String filter = request.getParameter("filter");
        String searchKeyword = request.getParameter("keyword");
        String category = request.getParameter("category");

        List<Inventory> importList;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Tìm kiếm theo tên sản phẩm hoặc nhà cung cấp
            importList = inventoryDAO.searchInventory(searchKeyword);
            request.setAttribute("importList", importList);
            request.getRequestDispatcher("viewlistInventory.jsp").forward(request, response);
        } else {
            if ("laptop".equalsIgnoreCase(filter)) {
                importList = inventoryDAO.getInventoryListByCategory("laptop");
            } else if ("SmartPhone".equalsIgnoreCase(filter)) {
                importList = inventoryDAO.getInventoryListByCategory("SmartPhone");
            } else if ("Tablet".equalsIgnoreCase(filter)) {
                importList = inventoryDAO.getInventoryListByCategory("Tablet");
            } else {
                importList = inventoryDAO.getAllInventories();
            }

            request.setAttribute("importList", importList);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("selectedCategory", category);

            request.getRequestDispatcher("viewlistInventory.jsp").forward(request, response);
        }
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

}
