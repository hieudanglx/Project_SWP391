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
import java.util.ArrayList;
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
        int min = Integer.parseInt(request.getParameter("minPrice") == null || request.getParameter("minPrice").isEmpty() ? "0" : request.getParameter("minPrice")) ;
        int max = Integer.parseInt(request.getParameter("maxPrice") == null || request.getParameter("maxPrice").isEmpty() ? "0" : request.getParameter("maxPrice")) ;
        int CategoryID = Integer.parseInt(request.getParameter("CategoryID") == null || request.getParameter("CategoryID").isEmpty() ? "1" : request.getParameter("CategoryID")) ;
        
        Product filter = new Product();
        filter.setCategoryID(CategoryID);
        filter.setBrand(request.getParameter("brand"));
        filter.setRefreshRate(request.getParameter("rate"));
        filter.setRam(request.getParameter("ram"));
        filter.setRom(request.getParameter("rom"));
        filter.setOperatingSystemName(request.getParameter("os"));
        filter.setScreenSize(request.getParameter("size"));
        filter.setScreenResolution(request.getParameter("res"));
      
        List<String> chiptype = link.getChipType();
        ArrayList<List<String>> Chip = link.getChipByChipType();
        for (String type : chiptype) {
            String temp = request.getParameter(type);
            System.out.println(type);
            if (temp != null && !temp.isEmpty()) {
                filter.setChipType(type);
                filter.setChipName(request.getParameter(type));
            }
        }
        List<String> listbrand = link.getBrandbyCategoryID(CategoryID);
        List<Product> list = link.filterProducts(filter, min, max);
        request.setAttribute("CategoryID", CategoryID);
        request.setAttribute("listbrand", listbrand);
        request.setAttribute("Chiptype", chiptype);
        request.setAttribute("Chip", Chip);
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
