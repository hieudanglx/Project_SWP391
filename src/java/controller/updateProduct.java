/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

/**
 *
 * @author Dinh Van Do - CE182224
 */
@WebServlet(name = "updateProduct", urlPatterns = {"/updateProduct"})
public class updateProduct extends HttpServlet {

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
            // Nhận dữ liệu từ form JSP

        } catch (Exception e) {
            request.setAttribute("error", "Invalid data: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        String id = request.getParameter("productID");
        ProductDao productDao = new ProductDao();
        Product product = productDao.getProductById(Integer.parseInt(id));
        if (product.getColor().isEmpty()) {
            request.setAttribute("error", "Failed to create product");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        request.setAttribute("product", product);
        request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
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
            String cameraFront = "";
            String cameraBehind = "";
            String ramType = "";
            String supportsUpgradingRAM = "";
            String supportsUpgradingROM = "";
            int productID = Integer.parseInt(request.getParameter("productID"));
            String productName = request.getParameter("productName");
            int price = Integer.parseInt(request.getParameter("price"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String brand = request.getParameter("brand");
            if (categoryID == 1) {
                ramType = request.getParameter("ramType");
                supportsUpgradingRAM = request.getParameter("supportsUpgradingRAM");
                supportsUpgradingROM = request.getParameter("supportsUpgradingROM");
            } else {
                cameraFront = request.getParameter("cameraFront");
                cameraBehind = request.getParameter("cameraBehind");
            }
            String ram = request.getParameter("ram");
            String rom = request.getParameter("rom");
            String color = request.getParameter("color");
            String operatingSystemName = request.getParameter("operatingSystemName");
            String operatingSystemVersion = request.getParameter("operatingSystemVersion");
            String screenSize = request.getParameter("screenSize");
            String refreshRate = request.getParameter("refreshRate");
            String screenResolution = request.getParameter("screenResolution");
            String chipType = request.getParameter("chipType");
            String chipName = request.getParameter("chipName");
            String gpuType = request.getParameter("gpuType");
            String gpuName = request.getParameter("gpuName");
            int quantitySell = Integer.parseInt(request.getParameter("quantitySell"));
            int quantityProduct = Integer.parseInt(request.getParameter("quantityProduct"));
            String imageURL = request.getParameter("imageURL");
            int isDelete = 0;

            // Tạo đối tượng Product
            Product product = new Product(productID, productName, price, categoryID, brand, cameraFront, cameraBehind,
                    ram, ramType, supportsUpgradingRAM, rom, supportsUpgradingROM, color,
                    operatingSystemName, operatingSystemVersion, screenSize, refreshRate,
                    screenResolution, chipType, chipName, gpuType, gpuName,
                    quantitySell, quantityProduct, imageURL, isDelete);

            // Gọi DAO để cập nhật sản phẩm
            ProductDao productDAO = new ProductDao();

//            boolean exist = productDAO.isProductExists(product);
//            if (exist) {
//                request.setAttribute("error", "The product has existed");
//                request.setAttribute("product", product);
//                request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
//            } else {
                boolean isUpdated = productDAO.updateProduct(product);

                if (isUpdated) {                    
                    request.setAttribute("error", "Update sucessful");
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("productDetailForAF.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to update product");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            //}

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred");
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
