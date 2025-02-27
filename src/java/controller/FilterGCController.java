/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Product;
import dao.ProductDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
@WebServlet(name = "FilterGCController", urlPatterns = {"/FilterGCController"})
public class FilterGCController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        ProductDao link = new ProductDao();
        int min = 0;
        int max = Integer.MAX_VALUE;
        String minParam = request.getParameter("minPrice");
        String maxParam = request.getParameter("maxPrice");

        if (minParam != null && !minParam.trim().isEmpty()) {
            min = Integer.parseInt(minParam);
        }
        if (maxParam != null && !maxParam.trim().isEmpty()) {
            max = Integer.parseInt(maxParam);
        }
        int CategoryID = 0;
        String categoryIdParam = request.getParameter("CategoryID");
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                CategoryID = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                // Xử lý trường hợp giá trị không phải số
                request.setAttribute("error", "ID danh mục không hợp lệ");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
        } else {
            // Xử lý trường hợp không có CategoryID
            request.setAttribute("error", "Thiếu tham số CategoryID");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Rest of your code
        Product filter = new Product(CategoryID,
                request.getParameter("brand"),
                request.getParameter("ram"),
                request.getParameter("rom"),
                request.getParameter("os"),
                request.getParameter("size"),
                request.getParameter("res"), 
                request.getParameter("rate"),
                request.getParameter("chiptype"),
                request.getParameter("chipname"));
        
        List<String> listbrand = link.getBrandbyCategoryID(CategoryID);
        List<Product> list = link.filterProducts(filter, null, min, max);
        request.setAttribute("CategoryID", CategoryID);
        request.setAttribute("listbrand", listbrand);
        request.setAttribute("list", list);
        request.getRequestDispatcher("viewListProductGC.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(FilterGCController.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(FilterGCController.class.getName()).log(Level.SEVERE, null, ex);
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
