/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import dao.ProductDao;

/**
 *
 * @author Dinh Van Do - CE182224
 */
@WebServlet(name = "createProduct", urlPatterns = {"/createProduct"})
public class createProduct extends HttpServlet {

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
        String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");
            int price = Integer.parseInt(request.getParameter("price"));
            int category = Integer.parseInt(request.getParameter("category"));
            String brand = request.getParameter("brand");
            String camera = request.getParameter("camera");
            String ram = request.getParameter("ram");
            String rom = request.getParameter("rom");
            String color = request.getParameter("color");
            String operatingSystem = request.getParameter("operatingSystem");
            String size = request.getParameter("size");
            String refreshRate = request.getParameter("refreshRate");
            String chip = request.getParameter("chip");
            String gpu = request.getParameter("gpu");
//            int quantitySell = Integer.parseInt(request.getParameter("quantitySell"));
//            int quantityProduct = Integer.parseInt(request.getParameter("quantityProduct"));
            String imageURL = request.getParameter("imageURL");
            

            Product product = new Product(productID, productName, price, category, brand, camera, ram, rom, color,
                    operatingSystem, size, refreshRate, chip, gpu, 0, 0, imageURL, 0);

            ProductDao productDAO = new ProductDao();
            boolean isAdded = productDAO.addProduct(product);

            if (isAdded) {
                response.sendRedirect("listProductsForAdmin");
            } else {
                request.setAttribute("error", "Failed to add product");
                request.getRequestDispatcher("error.jsp").forward(request, response);
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
